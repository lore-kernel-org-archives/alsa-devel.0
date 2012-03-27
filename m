From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 4/8] sound:asoc:spdif_in: Add spdif IN
	support
Date: Tue, 27 Mar 2012 14:55:44 +0530
Message-ID: <4F718798.40408@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<568712727a6488bb0c16cf9031fa498059974e6e.1332242166.git.rajeev-dlh.kumar@st.com>
	<20120320155526.GG3445@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
	[207.126.144.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A0D90104183
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 11:25:23 +0200 (CEST)
In-Reply-To: <20120320155526.GG3445@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, spear-devel <spear-devel@list.st.com>, Vipin KUMAR <vipin.kumar@st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 3/20/2012 9:25 PM, Mark Brown wrote:
> On Tue, Mar 20, 2012 at 05:03:48PM +0530, Rajeev Kumar wrote:
>
> This looks good, a few minor things but almost good to go.
>
>> This patch implements the spdif IN driver for ST peripheral
>
> S/PDIF.
>

Ok,


>> +	if (irq_status&  SPDIF_IRQ_FIFOWRITE)
>> +		pr_err("spdif in: fifo write error\n");
>> +	if (irq_status&  SPDIF_IRQ_EMPTYFIFOREAD)
>> +		pr_err("spdif in: empty fifo read error\n");
>> +	if (irq_status&  SPDIF_IRQ_FIFOFULL)
>> +		pr_err("spdif in: fifo full error\n");
>> +	if (irq_status&  SPDIF_IRQ_OUTOFRANGE)
>> +		pr_err("spdif in: out of range error\n");
>
> dev_err().
>

Ok

>> +	if (!devm_request_mem_region(&pdev->dev, res->start,
>> +				resource_size(res), pdev->name)) {
>> +		dev_warn(&pdev->dev, "Failed to get memory resourse\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
>> +	if (!host) {
>> +		dev_warn(&pdev->dev, "kzalloc fail\n");
>> +		return -ENOMEM;
>> +	}
>
> Good to see this - this is the sort of stuff I was looking for in the
> I2S driver.
>

Will follow this in I2S driver.

>> +	host->clk = clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(host->clk))
>> +		return PTR_ERR(host->clk);
>
>> +	pdata = dev_get_platdata(&pdev->dev);
>
> Should really be error checking in case you didn't get your platform
> data.
>

Agreed,

>> +	ret = devm_request_irq(&pdev->dev, host->irq, spdif_in_irq, 0,
>> +			"spdif-in", host);
>> +	if (ret) {
>
> I'm really not enthused about the idea of using devm_request_irq() here
> - what steps are you taking to make sure that the IRQ can't possibly
> fire after you've started tearing down the device.  In general it's
> relatively hard to use devm_request_irq() safely.
>

Disabling interrupt in remove will insure that interrupt will not fire 
after tearing down the device.


>> +#define SPDIF_IN_DEV_PM_OPS NULL
>
> Just remove this if it's unconditionally empty.
>

OK,

Best Regards
Rajeev

>> +static int __init spdif_in_init(void)
>
> module_platform_driver().
