From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 12/13] slimbus: qcom: Add runtime-pm support using
 clock-pause
Date: Fri, 24 Nov 2017 14:39:53 +0000
Message-ID: <fac57b60-05b6-a546-bdd4-9e1d994cd74b@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-13-srinivas.kandagatla@linaro.org>
 <20171123101749.ojiv6l52jjq6b55b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171123101749.ojiv6l52jjq6b55b@localhost.localdomain>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 23/11/17 10:17, Charles Keepax wrote:
> On Wed, Nov 15, 2017 at 02:10:42PM +0000, srinivas.kandagatla@linaro.org wrote:
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
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int qcom_slim_suspend(struct device *dev)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!pm_runtime_enabled(dev) ||
>> +		(!pm_runtime_suspended(dev))) {
>> +		dev_dbg(dev, "system suspend");
>> +		ret = qcom_slim_runtime_suspend(dev);
>> +	}
>> +
>> +	/*
>> +	 * If the clock pause failed due to active channels, there is
>> +	 * a possibility that some audio stream is active during suspend.
>> +	 * (e.g. modem usecase during suspend)
>> +	 * We dont want to return suspend failure in that case so that
>> +	 * display and relevant components can still go to suspend.
>> +	 * If there is some other error, then it should prevent
>> +	 * system level suspend
>> +	 */
>> +	if (ret == -EISCONN)
>> +		ret = 0;
> 
> Who actually returns the EISCONN for this to catch? Or will that
> be added to slim_ctrl_clk_pause once support for the audio
> channels is added?

This looks like a leftover code, I will remove it in next version and we 
can add it once related code is added.



> 
> Thanks,
> Charles
> 
>> +
>> +	return ret;
>> +}
