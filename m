From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 5/7] slimbus: qcom: Add runtime-pm support using
 clock-pause feature
Date: Sat, 7 Oct 2017 11:25:12 +0100
Message-ID: <17495a78-9e81-c0c3-fe17-78732eff8b9e@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-6-srinivas.kandagatla@linaro.org>
 <20171007082259.kumlkus5mg5eh5cr@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171007082259.kumlkus5mg5eh5cr@latitude>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

Thanks for the review comments

On 07/10/17 09:22, Jonathan Neuschäfer wrote:
> Hi, some more trivial comments below.
> 
> On Fri, Oct 06, 2017 at 05:51:34PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Sagar Dharia <sdharia@codeaurora.org>
>>
>> Slimbus HW mandates that clock-pause sequence has to be executed
>> before disabling relevant interface and core clocks.
>> Runtime-PM's autosuspend feature is used here to enter/exit low
>> power mode for Qualcomm's Slimbus controller. Autosuspend feature
>> enables driver to avoid changing power-modes too frequently since
>> entering clock-pause is an expensive sequence
>>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
> [...]
>> +static int msm_clk_pause_wakeup(struct slim_controller *ctrl)
>> +{
>> +	struct msm_slim_ctrl *dev = slim_get_ctrldata(ctrl);
>> +
>> +	clk_prepare_enable(dev->hclk);
>> +	clk_prepare_enable(dev->rclk);
>> +	enable_irq(dev->irq);
>> +
>> +	writel_relaxed(1, dev->base + FRM_WAKEUP);
>> +	/* Make sure framer wakeup write goes through before ISR fires */
>> +	mb();
>> +	/**
> 
> This isn't really a kerneldoc comment.
Yep I agree will fix all such instances.

> 
>> +	 * HW Workaround: Currently, slave is reporting lost-sync messages
>> +	 * after slimbus comes out of clock pause.
>> +	 * Transaction with slave fail before slave reports that message
>> +	 * Give some time for that report to come
>> +	 * Slimbus wakes up in clock gear 10 at 24.576MHz. With each superframe
>> +	 * being 250 usecs, we wait for 5-10 superframes here to ensure
>> +	 * we get the message
>> +	 */
>> +	usleep_range(1250, 2500);
>> +	return 0;
>> +}
> [...]
>> +#ifdef CONFIG_PM_SLEEP
>> +static int msm_slim_suspend(struct device *dev)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!pm_runtime_enabled(dev) ||
>> +		(!pm_runtime_suspended(dev))) {
>> +		dev_dbg(dev, "system suspend");
>> +		ret = msm_slim_runtime_suspend(dev);
>> +	}
>> +	if (ret == -EISCONN) {
>> +	/**
> 
> ditto.
> Also, it looks misindented.
Yep. will fix this too.

> 
>> +	 * If the clock pause failed due to active channels, there is
>> +	 * a possibility that some audio stream is active during suspend.
>> +	 * (e.g. modem usecase during suspend)
>> +	 * We dont want to return suspend failure in that case so that
>> +	 * display and relevant components can still go to suspend.
>> +	 * If there is some other error, then it should prevent
>> +	 * system level suspend
>> +	 */
>> +		ret = 0;
>> +	}
>> +	return ret;
>> +}
> 
> 
> Thanks,
> Jonathan Neuschäfer
> 
