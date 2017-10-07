From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 4/7] slimbus: Add support for 'clock-pause' feature
Date: Sat, 7 Oct 2017 11:24:59 +0100
Message-ID: <dfda11c1-2f2f-9b79-eb13-dd2115d2a919@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-5-srinivas.kandagatla@linaro.org>
 <20171007080625.gotgts2ssgacawpx@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171007080625.gotgts2ssgacawpx@latitude>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

Thanks for the review comments



On 07/10/17 09:06, Jonathan Neuschäfer wrote:
> Hi, some trivial comments below.
> 
> On Fri, Oct 06, 2017 at 05:51:33PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Sagar Dharia <sdharia@codeaurora.org>
>>
>> Per slimbus specification, a reconfiguration sequence known as
>> 'clock pause' needs to be broadcast over the bus while entering low-
>> power mode. Clock-pause is initiated by the controller driver.
>> To exit clock-pause, controller typically wakes up the framer device.
>> Since wakeup precedure is controller-specific, framework calls it via
>> controller's function pointer to invoke it.
>>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
> [...]
>> @@ -429,6 +444,14 @@ void slim_return_tx(struct slim_controller *ctrl, int err)
>>   		cur.cb(cur.ctx, err);
>>   
>>   	up(&ctrl->tx_sem);
>> +	if (!cur.clk_pause && (!cur.need_tid || err)) {
>> +		/**
> 
> This isn't really a kerneldoc comment.
Will fix all such instances in next version.
> 
>> +		 * remove runtime-pm vote if this was TX only, or
>> +		 * if there was error during this transaction
>> +		 */
>> +		pm_runtime_mark_last_busy(ctrl->dev.parent);
>> +		pm_runtime_put_autosuspend(ctrl->dev.parent);
>> +	}
>>   }
>>   EXPORT_SYMBOL_GPL(slim_return_tx);
>>   
> [...]
>> +/**
>> + * slim_ctrl_clk_pause: Called by slimbus controller to enter/exit 'clock pause'
>> + * Slimbus specification needs this sequence to turn-off clocks for the bus.
>> + * The sequence involves sending 3 broadcast messages (reconfiguration
>> + * sequence) to inform all devices on the bus.
>> + * To exit clock-pause, controller typically wakes up active framer device.
>> + * @ctrl: controller requesting bus to be paused or woken up
>> + * @wakeup: Wakeup this controller from clock pause.
>> + * @restart: Restart time value per spec used for clock pause. This value
>> + *	isn't used when controller is to be woken up.
>> + * This API executes clock pause reconfiguration sequence if wakeup is false.
>> + * If wakeup is true, controller's wakeup is called.
>> + * For entering clock-pause, -EBUSY is returned if a message txn in pending.
>> + */
>> +int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart)
>> +{
>> +	int i, ret = 0;
>> +	unsigned long flags;
>> +	struct slim_sched *sched = &ctrl->sched;
>> +	struct slim_val_inf msg = {0, 0, NULL, NULL, NULL, NULL};
>> +
>> +	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
>> +				3, SLIM_LA_MANAGER, &msg);
>> +
>> +	if (wakeup == false && restart > SLIM_CLK_UNSPECIFIED)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&sched->m_reconf);
>> +	if (wakeup) {
>> +		if (sched->clk_state == SLIM_CLK_ACTIVE) {
>> +			mutex_unlock(&sched->m_reconf);
>> +			return 0;
>> +		}
>> +
>> +		/**
> 
> ditto
> 
>> +		 * Fine-tune calculation based on clock gear,
>> +		 * message-bandwidth after bandwidth management
>> +		 */
>> +		ret = wait_for_completion_timeout(&sched->pause_comp,
>> +				msecs_to_jiffies(100));
>> +		if (!ret) {
>> +			mutex_unlock(&sched->m_reconf);
>> +			pr_err("Previous clock pause did not finish");
>> +			return -ETIMEDOUT;
>> +		}
>> +		ret = 0;
>> +
>> +		/**
> 
> ditto
> 
>> +		 * Slimbus framework will call controller wakeup
>> +		 * Controller should make sure that it sets active framer
>> +		 * out of clock pause
>> +		 */
>> +		if (sched->clk_state == SLIM_CLK_PAUSED && ctrl->wakeup)
>> +			ret = ctrl->wakeup(ctrl);
>> +		if (!ret)
>> +			sched->clk_state = SLIM_CLK_ACTIVE;
>> +		mutex_unlock(&sched->m_reconf);
>> +
>> +		return ret;
>> +	}
> [...]
> 
> 
> Thanks,
> Jonathan Neuschäfer
> 
