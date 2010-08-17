From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: add 88pm860x codec driver
Date: Tue, 17 Aug 2010 18:44:44 +0800
Message-ID: <AANLkTi=4vfkpDF=RkTtRTUR=XP9UAmhkJyvFvowV_89O@mail.gmail.com>
References: <AANLkTi=i5H_oJvXzMv71ofxyw9FFXpiXU=pgzf+rdgk0@mail.gmail.com>
	<20100817095800.GD18622@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id D226D244BA
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 12:44:44 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2819291ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2010 03:44:44 -0700 (PDT)
In-Reply-To: <20100817095800.GD18622@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 17, 2010 at 5:58 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Aug 17, 2010 at 03:47:59PM +0800, Haojian Zhuang wrote:
>
>
>> +/* DAPM Widget Events */
>> +static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_kcontro=
l *kcontrol, int event)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D w->codec;
>> +
>> + =A0 =A0 /* unmute DAC */
>> + =A0 =A0 snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, 0);
>
> Can you explain what's going on with this mute handling please?
>
Em. Actually there should be automute variable. I shouldn't delete
that variable.  In order to anti-pop, mute DAC before enabling DAC.
Unmute it after enabling DAC. It's required by silicon.

>> + =A0 =A0 switch (event) {
>> + =A0 =A0 case SND_SOC_DAPM_PRE_PMU:
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_ADC_EN_1, en=
1, en1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_ADC_EN_2, en=
2, en2);
>
> I still don't follow why you need a custom event for this.
>
Enabling both bit 0 of ADC_EN_1 and bit 5 of ADC_EN_2 can enable left
ADC. Enabling both bit 1 of ADC_EN_1 and bit 4 of ADC_EN_2 can enable
right ADC. I can't find any DAPM API can handle this. So I implement
the custom event.


>> +static int pm860x_mic1_event(struct snd_soc_dapm_widget *w,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_kcontrol=
 *kcontrol, int event)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D w->codec;
>> +
>> + =A0 =A0 switch (event) {
>> + =A0 =A0 case SND_SOC_DAPM_POST_PMU:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Enable Mic1 Bias & MICDET, HSDET */
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_ADC_ANA_1, M=
IC1BIAS_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIC1BI=
AS_MASK);
>
> As I said last time you should handle this via DAPM.
>
I registered it as DAPM widget. Why do you say it's not handled via DAPM?

>> + =A0 =A0 =A0 =A0 =A0 =A0 pm860x_set_bits(codec->control_data, REG_MIC_D=
ET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MICDET_MASK, M=
ICDET_MASK);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm860x_set_bits(codec->control_data, REG_HS_DE=
T,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EN_HS_DET, EN_=
HS_DET);
>
> This should be associated with enabling microphone detection.
>
Yes, but you said that it could be controlled by enable_pin(). I
forced to enable microphone pins in machine driver.

>> + =A0 =A0 /* set master/slave audio interface */
>> + =A0 =A0 switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> + =A0 =A0 case SND_SOC_DAIFMT_CBM_CFM:
>> + =A0 =A0 case SND_SOC_DAIFMT_CBM_CFS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pm860x->dir =3D=3D PM860X_CLK_DIR_OUT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *inf |=3D PCM_INF2_MASTER;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> You're setting the same register configuration for two different DAI
> clock master configurations here. =A0Presumably one of the settings is
> inaccurate?
>
No, they're different registers. But offsets are same. So I just return poi=
nter.

>> +static int pm860x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int clk_id,=
 unsigned int freq, int dir)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D codec_dai->codec;
>> + =A0 =A0 struct pm860x_priv *pm860x =3D snd_soc_codec_get_drvdata(codec=
);
>> +
>> + =A0 =A0 if (dir =3D=3D PM860X_CLK_DIR_OUT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm860x->dir =3D PM860X_CLK_DIR_OUT;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm860x->dir =3D PM860X_CLK_DIR_IN;
>> +
>> + =A0 =A0 return 0;
>> +}
>
> What is this actually setting - which clock is being configured here?
>
While codec is master, the clock is fixed. I needn't set detail clock.
While codec is slave, it's not supported in this patch yet.

>> +static irqreturn_t pm860x_codec_handler(int irq, void *data)
>> +{
>> + =A0 =A0 struct pm860x_priv *pm860x =3D data;
>> + =A0 =A0 int status, shrt, report =3D 0;
>> +
>> + =A0 =A0 status =3D pm860x_reg_read(pm860x->i2c, REG_STATUS_1);
>> + =A0 =A0 shrt =3D pm860x_reg_read(pm860x->i2c, REG_SHORTS);
>> +
>> + =A0 =A0 if (status & HEADSET_STATUS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D PM860X_DET_HEADSET;
>> + =A0 =A0 if (status & MIC_STATUS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D PM860X_DET_MIC;
>> + =A0 =A0 if (status & HOOK_STATUS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D PM860X_DET_HOOK;
>> + =A0 =A0 if (shrt & (SHORT_LO1 | SHORT_LO2))
>> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D PM860X_SHORT_LINEOUT;
>> + =A0 =A0 if (shrt & (SHORT_HS1 | SHORT_HS2))
>> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D PM860X_SHORT_HEADSET;
>> + =A0 =A0 dev_dbg(pm860x->codec->dev, "report:0x%x\n", report);
>> + =A0 =A0 return IRQ_HANDLED;
>
> It would seem better to just remove the interrupt handling support
> entirely if you're not going to implement jack detection. =A0Right now all
> the curernt code will do is waste power by enabling the feature but
> ignoring the result.
>
I need a document on illustrating jack on alsa. Could you share one?
