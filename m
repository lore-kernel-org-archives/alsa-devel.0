From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 4/5] ASoC: add 88pm860x codec driver
Date: Fri, 13 Aug 2010 22:53:52 +0800
Message-ID: <AANLkTim+TWCb1z1dd54omBkwJSkSUFeUSFz8xGuArAh2@mail.gmail.com>
References: <AANLkTi=kyxr_0ObZfSLET0Vi2Hp13=H=C1kM9Q2t-eU0@mail.gmail.com>
	<20100813142301.GD6449@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A10F24156
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 16:53:56 +0200 (CEST)
Received: by gya1 with SMTP id 1so1078134gya.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 07:53:55 -0700 (PDT)
In-Reply-To: <20100813142301.GD6449@rakim.wolfsonmicro.main>
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

On Fri, Aug 13, 2010 at 10:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 13, 2010 at 09:55:44PM +0800, Haojian Zhuang wrote:
>
>> +static int snd_soc_put_equalizer(struct snd_kcontrol *kcontrol,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_=
ctl_elem_value *ucontrol)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
>> + =A0 =A0 struct pm860x_priv *pm860x =3D snd_soc_codec_get_drvdata(codec=
);
>> +
>> + =A0 =A0 if (ucontrol->value.integer.value[0] >=3D FILTER_MAX)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 pm860x->filter =3D ucontrol->value.integer.value[0];
>> + =A0 =A0 switch (pm860x->filter) {
>> + =A0 =A0 case FILTER_BYPASS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_I2S_IFACE_4,=
 I2S_EQU_BYP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2S_EQ=
U_BYP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_EAR_CTRL_2, =
RSYNC_CHANGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RSYNC_=
CHANGE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> Rather than hard coding every possible set of EQ configurations into the
> driver it would be much better to allow the user to supply these via
> platform data. =A0That way if users want to supply their own EQ
> coefficients they will be able to. =A0Several Wolfson CODEC drivers have
> examples of doing this.
>
> It's fine to provide a default set of configurations in case the user
> doesn't specify anything in platform data.
>
OK.

>> + =A0 =A0 case FILTER_HIGH_PASS_3:
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0x=
55);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0x=
39);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0x=
5a);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0x=
f3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0x=
7e);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0x=
53);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>
> You're also missing a default.
>
Bypass is default.  After audio part is reset, EQ is in bypass state.

>> +/* DAPM Widget Events */
>> +static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_kcontro=
l *kcontrol, int event)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D w->codec;
>> + =A0 =A0 struct pm860x_priv *pm860x =3D snd_soc_codec_get_drvdata(codec=
);
>> +
>> + =A0 =A0 /* unmute DAC */
>> + =A0 =A0 if (pm860x->automute) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_DAC_OFFSET, =
DAC_MUTE, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm860x->automute =3D 0;
>> + =A0 =A0 }
>> + =A0 =A0 snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RSYNC_CHANGE, RSYNC_CH=
ANGE);
>> + =A0 =A0 return 0;
>> +}
>
> What's this doing? =A0There's also some similar code in the DAC widget
> event - I think some comments explaining what's being done here are
> required at the very least.
>
A lot of registers belong to RSYNC domain. It means that those
changing won't be valid until RSYNC bit is set. So I'll set RSYNC
again in a lot of areas.

>> +static int pm860x_adc_event(struct snd_soc_dapm_widget *w,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_kcontrol *k=
control, int event)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D w->codec;
>> + =A0 =A0 unsigned int en1 =3D 0, en2 =3D 0;
>> +
>> + =A0 =A0 if (!strcmp(w->name, "Left ADC")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 en1 =3D ADC_MOD_LEFT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 en2 =3D ADC_LEFT;
>> + =A0 =A0 }
>> + =A0 =A0 if (!strcmp(w->name, "Right ADC")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 en1 =3D ADC_MOD_RIGHT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 en2 =3D ADC_RIGHT;
>> + =A0 =A0 }
>> + =A0 =A0 switch (event) {
>> + =A0 =A0 case SND_SOC_DAPM_PRE_PMU:
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_ADC_EN_1, en=
1, en1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_ADC_EN_2, en=
2, en2);
>
> Can you do this more simply by using a supply widget for the en1
> register bits?
>
When I enable this, I need to touch two different registers at the
same time. So I have to implement the adc_event().

>> +static int pm860x_spk_event(struct snd_soc_dapm_widget *w,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_kcontrol *k=
control, int event)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D w->codec;
>> +
>> + =A0 =A0 dev_dbg(codec->dev, "event:%x\n", event);
>> + =A0 =A0 return 0;
>> +}
>
> Remove this, it's purely for debug.
>
OK.

>> +static const struct soc_enum pm860x_enum[] =3D {
>> + =A0 =A0 SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 5, 4, pm860x_opamp_texts),
>
> Don't put your enums in an array, it is error prone and hard to read.
> Just define variables for each enum.
>
OK.


>> +/* Headset 1 Mux / Mux15 */
>> +static const char *in_text[] =3D {
>> + =A0 =A0 "DIGITAL", "ANALOG",
>
> Why ALL CAPS?
>
Sure. I'll change to lowcases.

>> + =A0 =A0 data =3D snd_soc_read(codec, PM860X_PCM_IFACE_2) & ~mask;
>> + =A0 =A0 data |=3D inf;
>> + =A0 =A0 snd_soc_write(codec, PM860X_PCM_IFACE_2, data);
>
> snd_soc_update_bits().
>
>> +static int pm860x_pcm_hw_free(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai=
 *dai)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D dai->codec;
>> +
>> + =A0 =A0 /* disable PCM interface */
>> + =A0 =A0 snd_soc_update_bits(codec, PM860X_ADC_EN_2, 1, 0);
>> + =A0 =A0 snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RSYNC_CHANGE, RSYNC_CH=
ANGE);
>> + =A0 =A0 return 0;
>> +}
>
> This looks like it should be done by DAPM.
>
But I don't want to export this to amixer.

>> +static int pm860x_i2s_hw_params(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_pcm=
_hw_params *params,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc=
_dai *dai)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D dai->codec;
>> + =A0 =A0 unsigned char inf;
>> + =A0 =A0 int data;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Enable LDO15 for VDD_CODEC, audio charger pump for VDDSTP=
/VDDSTN
>> + =A0 =A0 =A0* and reset audio module.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 data =3D LDO15_EN | CPUMP_EN | AUDIO_EN;
>> + =A0 =A0 snd_soc_update_bits(codec, PM860X_AUDIO_SUPPLIES_2, data, data=
);
>
> These look like they should all be handled via DAPM, probably supply
> widgets.
>
>> +static int pm860x_i2s_hw_free(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai=
 *dai)
>> +{
>
> This also looks like DAPM stuff.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable Mic1 Bias & MICDET, =
HSDET */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm860x_set_bits(codec->control=
_data, REG_ADC_ANA_1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 MIC1BIAS_MASK, MIC1BIAS_MASK);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm860x_set_bits(codec->control=
_data, REG_MIC_DET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 MICDET_MASK, MICDET_MASK);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm860x_set_bits(codec->control=
_data, REG_HS_DET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 EN_HS_DET, EN_HS_DET);
>
> The microphone bias should be handled via DAPM.
>
This one is different. Without this, mic/headset detection can't be
finished. This bit have to be set in initialization.
