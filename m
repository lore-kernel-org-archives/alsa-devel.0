From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: AK4671: add ak4671 codec driver
Date: Fri, 04 Sep 2009 10:30:29 +0900
Message-ID: <4AA06DB5.6060107@samsung.com>
References: <4A9FB5C7.5060607@samsung.com>
	<20090903140236.GB1406@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id C0CFB24364
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 03:30:33 +0200 (CEST)
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KPF006ERAUTKV@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 04 Sep 2009 10:30:30 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KPF00E84AUTKU@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 04 Sep 2009 10:30:29 +0900 (KST)
In-reply-to: <20090903140236.GB1406@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On 9/3/2009 11:02 PM, Mark Brown wrote:
> On Thu, Sep 03, 2009 at 09:25:43PM +0900, Joonyoung Shim wrote:
>> The AK4671 is a stereo CODEC with a built-in Microphone-Amplifier,
>> Receiver-Amplifier and Headphone-Amplifier.
>>
>> The datasheet for the ak4671 can find at the following url:
>> http://www.asahi-kasei.co.jp/akm/en/product/ak4671/ak4671_f01e.pdf
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> 
> This looks very good, everything below is relatively minor.
> 
>> +/* write to the ak4671 register space */
>> +static int ak4671_write(struct snd_soc_codec *codec, unsigned int reg,
>> +		unsigned int value)
>> +{
>> +	u8 data[2];
>> +
>> +	/* data is
>> +	 *   D15..D8 AK4671 register offset
>> +	 *   D7...D0 register data
>> +	 */
>> +	data[0] = reg & 0xff;
>> +	data[1] = value & 0xff;
>> +
>> +	ak4671_write_reg_cache(codec, reg, value);
>> +	if (codec->hw_write(codec->control_data, data, 2) == 2)
>> +		return 0;
>> +	else
>> +		return -EIO;
>> +}
> 
> It would be nice (but not essential) to move over to soc-cache if
> possible - see the current for-2.6.32 code.
> 

I saw the soc-cache code. Ok, i will move to soc-cache, test it.

>> +static const struct snd_kcontrol_new ak4671_snd_controls[] = {
>> +	/* Common playback gain controls */
>> +	SOC_SINGLE_TLV("Stereo Line Output1 Playback Volume",
>> +			AK4671_OUTPUT_VOLUME_CONTROL, 0, 0x6, 0, out1_tlv),
>> +	SOC_SINGLE_TLV("Headphone Output2 Playback Volume",
>> +			AK4671_OUTPUT_VOLUME_CONTROL, 4, 0xd, 0, out2_tlv),
>> +	SOC_SINGLE_TLV("Stereo Line Output3 Playback Volume",
>> +			AK4671_LOUT3_POWER_MANAGERMENT, 6, 0x3, 0, out3_tlv),
> 
> Could drop the "Stereo" from the control names - it'll probably read
> better in applications.
> 

Ok.

>> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> +       case SND_SOC_DAIFMT_CBM_CFM:
>> +               ak4671->pll_on = 1;
>> +               mode |= AK4671_M_S;
>> +               break;
>> +       case SND_SOC_DAIFMT_CBM_CFS:
>> +               ak4671->pll_on = 1;
>> +               mode &= ~(AK4671_M_S);
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
> 
> Looks like pll_on is always set?  If that's true then there's not much
> gain from keeping track of it.
> 

The ak4671 supports four mode.

1. PLL Master Mode
2. PLL Slave Mode
3. EXT Slave Mode
4. EXT Master Mode

The 1 and 2 mode need pll_on set but the 3 and 4 mode don't need pll_on 
set, but i didn't implemented EXT mode yet.
Ok, I will remove the pll_on keeping until implementing the EXT mode.

>> +/* event handlers */
>> +static int ak4671_set_bias_level(struct snd_soc_codec *codec,
>> +		enum snd_soc_bias_level level)
>> +{
>> +	struct ak4671_priv *ak4671 = codec->private_data;
>> +	u8 reg;
>> +
>> +	switch (level) {
>> +	case SND_SOC_BIAS_ON:
>> +	case SND_SOC_BIAS_PREPARE:
>> +	case SND_SOC_BIAS_STANDBY:
>> +		if (ak4671->pll_on) {
>> +			reg = ak4671_read_reg_cache(codec,
>> +					AK4671_PLL_MODE_SELECT1);
>> +			reg |= AK4671_PMPLL;
>> +			ak4671_write(codec, AK4671_PLL_MODE_SELECT1, reg);
>> +			/* pll lock time: max 40ms */
>> +			mdelay(40);
>> +		}
> 
> I suspect this will run into trouble with bypass paths (which do appear
> to exist if I read the DAPM routes correctly).  If a bypass path is
> active then the CODEC will be brought up to full bias out of sync with
> any configuration of pll_on by the DAI format configuration.
> 

A bypass path should operate regardless pll_on.

> I've not looked at the datasheet but I think what you need here is to
> make the PLL a SND_SOC_DAPM_SUPPLY for the DACs and ADCs, then use an
> event on that to turn on and off the PLL.  DAPM will then keep the PLL
> powered so long as one of the DACs or ADCs is in use.
> 

I'll check about this.

>> +static struct snd_soc_dai_ops ak4671_dai_ops = {
>> +	.hw_params	= ak4671_hw_params,
>> +	.set_sysclk	= ak4671_set_dai_sysclk,
>> +	.set_fmt	= ak4671_set_dai_fmt,
>> +
>> +	/* TODO */
> 
> Could just remove the comment here.
> 

This is my fault. I will remove the comment.

>> +#ifdef CONFIG_PM
>> +static int ak4671_suspend(struct platform_device *pdev, pm_message_t state)
>> +{
>> +	/* TODO */
>> +
>> +	return 0;
>> +}
>> +
>> +static int ak4671_resume(struct platform_device *pdev)
>> +{
>> +	/* TODO */
>> +
>> +	return 0;
>> +}
>> +#else
>> +#define ak4671_suspend		NULL
>> +#define ak4671_resume		NULL
>> +#endif
> 
> May as well just remove these completely if they're not implemented.
> 

I will remove it.

Thanks.
