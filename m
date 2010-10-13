From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [patch 1/3] ASoC: add support for alc562[123]
	codecs
Date: Wed, 13 Oct 2010 19:58:03 +0200
Message-ID: <871v7ux9ec.fsf@lechat.rtp-net.org>
References: <20101012094453.660938870@rtp-net.org>
	<20101012100036.605541759@rtp-net.org>
	<20101012171602.GG30933@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 31A2524461
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 19:58:03 +0200 (CEST)
In-Reply-To: <20101012171602.GG30933@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Tue\, 12 Oct 2010 18\:16\:02 +0100")
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
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

Hi,

> On Tue, Oct 12, 2010 at 11:44:54AM +0200, Arnaud Patard wrote:
>
>> This patch is adding support for alc562[123] codecs. It's based
>> on the source code available in HP source code and other places.
>
> Looks very good - a few minor things below but they should be fairly
> easy to fix up.
>
>> +static int amp_mixer_event(struct snd_soc_dapm_widget *w,
>> +	struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	/* index 0x46: class-d internal register */
>> +	snd_soc_write(w->codec, ALC5623_HID_CTRL_INDEX, 0x46);
>
> This is a bit magic; some comments would help.

ok. I've added a comment. The aim is to power on/off the class-d amp
parts and to do that one has to write to index-46h reg and to do that
one has to write 0x46 to ALC5623_HID_CTRL_INDEX and then the value into
ALC5623_HID_CTRL_DATA.

>
>> +	if (pll_id == ALC5623_PLL_FR_MCLK) {
>> +		for (i = 0; i < ARRAY_SIZE(codec_master_pll_div); i++) {
>> +			if (codec_master_pll_div[i].pll_in == freq_in
>> +			   && codec_master_pll_div[i].pll_out == freq_out) {
>> +				/* PLL source from MCLK */
>> +				pll_div  = codec_master_pll_div[i].regvalue;
>> +				break;
>> +			}
>> +		}
>> +	} else {
>> +		for (i = 0; i < ARRAY_SIZE(codec_slave_pll_div); i++) {
>
> I'd expect a switch statement here.

ok.

>
>> +	coeff = get_coeff(codec, rate);
>> +	if (coeff >= 0) {
>> +		coeff = coeff_div[coeff].regvalue;
>> +		dev_dbg(codec->dev, "%s: sysclk=%d,rate=%d,coeff=0x%04x\n",
>> +			__func__, alc5623->sysclk, rate, coeff);
>> +		snd_soc_write(codec, ALC5623_STEREO_AD_DA_CLK_CTRL, coeff);
>> +	}
>
> Shouldn't we be returning an error if we can't get coefficients?

I was hoping that current value of the ALC5623_STEREO_AD_DA_CLK_CTRL
would be ok but you're probably right. It should be safer to return an
error.


>
>> +	switch (level) {
>> +	case SND_SOC_BIAS_ON:
>> +		enable_power_depop(codec);
>> +		break;
>
> enable_power_depop() takes a rather long time - about 500ms - which is
> surprising for _ON.  Are you sure it should be done here?

It was there in the original driver and when working on this driver, I
didn't see any reason for moving it elsewhere. tbh, if I have to move it
elsewhere, I don't know where I'll put it.
>
>> +static int alc5623_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
>> +{
>> +	/* we only need to suspend if we are a valid card */
>> +	if (!codec->card)
>> +		return 0;
>
> This isn't needed any more, this won't get called if there isn't a card.

ok. removed.
>
>> +	/* charge alc5623 caps */
>> +	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
>> +		alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +		codec->bias_level = SND_SOC_BIAS_ON;
>> +		schedule_delayed_work(&codec->delayed_work,
>> +			msecs_to_jiffies(caps_charge));
>> +	}
>
> Just go directly to the bias level you want, don't use delayed work.
> ASoC will already do resume out of line with the main system so there's
> no need to do this and it will disrupt audio operation just after resume
> if you do it.

ok.


Arnaud
