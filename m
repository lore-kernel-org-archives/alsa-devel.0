From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: [patch 3/5] cs42l51: add asoc driver
Date: Wed, 26 May 2010 10:20:33 +0200
Message-ID: <m38w77gjla.fsf@anduin.mandriva.com>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.121399024@mandriva.com>
	<20100525225151.GA13890@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.moondrake.net [212.85.150.166])
	by alsa0.perex.cz (Postfix) with ESMTP id C8198103904
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 10:20:31 +0200 (CEST)
In-Reply-To: <20100525225151.GA13890@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Tue, 25 May 2010 15:51:52 -0700")
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
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

Hi,

> On Tue, May 25, 2010 at 02:22:39PM +0200, apatard@mandriva.com wrote:
>
>> +	/* route microphone */
>> +	ret = snd_soc_write(codec, CS42L51_ADC_INPUT, 0xF0);
>> +	if (ret < 0)
>> +		goto error_alloc;
>
> As I said last time this really should be visible to userspace rather
> than fixed function in the driver.
>

It is visible userspace. Look at the DAPM widgets
cs42l51_adcl_mux_controls/cs42l51_adcr_mux_controls. It's there to set a
nice default.


>> +#define DAPM_EVENT_PRE_POST_PMD	(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)
>
> As I said last time this should be in soc-dapm.h rather than in the
> driver.
>

You told me it was not so important as I'm the only user so I have been
lazy and didn't sent a patch for that. Of course, if it's really
important, please say it and I'll be happy to send a patch to
soc-dapm.h.


>> +	SND_SOC_DAPM_DAC_E("Left DAC", "Left HiFi Playback",
>> +		CS42L51_POWER_CTL1, 5, 1,
>> +		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
>> +	SND_SOC_DAPM_DAC_E("Right DAC", "Right HiFi Playback",
>> +		CS42L51_POWER_CTL1, 6, 1,
>> +		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
>
> Your event here uses snd_soc_write() so for a stereo enable/disable
> you'll do extra writes.  If you changed it to use snd_soc_update_bits()
> then these would be suppressed.
>

ok. I didn't know about snd_soc_update_bits()


>> +	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
>> +	case SND_SOC_DAIFMT_CBM_CFM:
>> +		cs42l51->func = MODE_MASTER;
>> +		break;
>> +	default:
>> +	case SND_SOC_DAIFMT_CBS_CFS:
>> +		cs42l51->func = MODE_SLAVE_AUTO;
>> +		break;
>
> Is the device really capable of automatically coping with mixed master
> buses automatically,

hm... seeing such question means it may be yet an other bad naming. The
_AUTO part is refering to the speed mode of the codec. It's to set the
AUTO bit of the CS42L51_MIC_POWER_CTL reg and avoid most of the
clocks configurations.

Quote from the specs:
"Enables the auto-detect circuitry for detecting the speed mode of the
CODEC when operating as a slave.
When AUTO is enabled, the MCLK/LRCK ratio must be implemented according
to Table 3 on page 39. The SPEED[1:0] bits are ignored when this bit is
enabled. Speed is determined by the MCLK/LRCK ratio."

>  or should the default be to return an error?

I wanted to make sure things were working even with not supported
setting but it looks like it was not a good idea otherwise you wouldn't
ask. Will fix to return an error.

>
>> +	dev_info(&pdev->dev, "CS42L51 ALSA SoC Codec\n");
>
> I really would prefer to remove this.

I'd like to keep it. Being able to tell from logs if the codec driver
has been loaded or not is really nice for debugging purpose.

>
>> +struct cs42l51_setup_data {
>> +	int i2c_bus;
>> +	unsigned short i2c_address;
>> +};
>
> This is unused and could be removed.

ok.

Thanks,
Arnaud
