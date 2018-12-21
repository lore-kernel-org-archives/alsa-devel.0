From: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [PATCH v4 1/2] ASoC: cs35l36: Add support for
 Cirrus CS35L36 Amplifier
Date: Fri, 21 Dec 2018 19:51:31 +0000
Message-ID: <alpine.DEB.2.10.1812211349040.17092@james-tower>
References: <1545334876-12054-1-git-send-email-james.schulman@cirrus.com>
 <20181221111208.GB16508@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id BB304267944
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 20:51:37 +0100 (CET)
In-Reply-To: <20181221111208.GB16508@imbe.wolfsonmicro.main>
Content-Language: en-US
Content-ID: <30C7DE28F711CF40907EE752B51A8B97@namprd19.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "Schulman,
 James" <James.Schulman@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org



On Fri, 21 Dec 2018, Charles Keepax wrote:

> On Thu, Dec 20, 2018 at 01:41:15PM -0600, James Schulman wrote:
>> Add driver support for Cirrus Logic CS35L36 boosted
>> speaker amplifier
>>
>> Signed-off-by: James Schulman <james.schulman@cirrus.com>
>> ---
>> +struct cs35l36_platform_data {
>> +	bool sclk_frc;
>> +	bool lrclk_frc;
>
> These two are now unused.
>
>> +	bool multi_amp_mode;
>> +	bool dcm_mode;
>> +	int ldm_mode_sel;
>> +	bool amp_gain_zc;
>
> As is this guy.
>
>> +	bool amp_pcm_inv;
>> +	bool pdm_ldm_exit;
>> +	bool pdm_ldm_enter;
>
> And these two.
>
>> +	bool imon_pol_inv;
>> +	bool vmon_pol_inv;
>> +	int boost_ind;
>> +	int bst_vctl;
>> +	int bst_vctl_sel;
>> +	int bst_ipk;
>> +	bool extern_boost;
>> +	int temp_warn_thld;
>> +	struct cs35l36_vpbr_cfg vpbr_config;
>> +	struct cs35l36_irq_cfg irq_config;
>> +};
>
>> +
>> +	/* INT/GPIO Pin Config */
>> +	irq_gpio = of_get_child_by_name(np, "cirrus,irq-config");
>> +	irq_gpio_config->is_present = irq_gpio ? true : false;
>
> Should this be based off the interrupts property itself? The
> defaults for both of the properties in this block seem quite sane
> so it seems like people might use the IRQ but not specify this
> block.
>

Thanks a ton Charles. I'm just going to get rid of the irq_cfg struct 
altogether. It's not necessary now that we've implemented the majority 
from the 'interrupts' property. I'll keep two properties for the 
irq-drive-select and the irq-gpio-select, but the rest of it we'll just 
optimize out.

>> +	if (irq_gpio_config->is_present) {
>> +		if (of_property_read_u32(irq_gpio, "cirrus,irq-drive-select",
>> +					 &val) >= 0)
>> +			irq_gpio_config->irq_drv_sel = val;
>> +		if (of_property_read_u32(irq_gpio, "cirrus,irq-gpio-select",
>> +					 &val) >= 0)
>> +			irq_gpio_config->irq_gpio_sel = val;
>> +
>> +		irq_d = irq_get_irq_data(i2c_client->irq);
>> +		if (!irq_d) {
>> +			dev_err(&i2c_client->dev, "Invalid IRQ: %d\n",
>> +				i2c_client->irq);
>> +			return -EINVAL;
>> +		}
>> +
>> +		irq_gpio_config->irq_pol = irqd_get_trigger_type(irq_d);
>> +	}
>
>> +
>> +	dev_info(&i2c_client->dev, "Cirrus Logic CS35L%d, Revision: %02X\n",
>> +		 cs35l36->chip_version, reg_revid >> 8);
>> +
>> +	ret =  snd_soc_register_component(dev, &soc_component_dev_cs35l36,
>> +					  cs35l36_dai, ARRAY_SIZE(cs35l36_dai));
>
> Could use devm_ here.
>
> Fix up those and you can add my:
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Thanks,
> Charles
>

Awesome, thank you! I think enough will change that I'll wait before 
adding the 'Reviewed-by'.

Thanks,
James
