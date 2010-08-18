From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: add 88pm860x codec driver
Date: Wed, 18 Aug 2010 22:33:19 +0800
Message-ID: <AANLkTi=2FboP+xhSHjgyoM6LfmKw1khV62gTVrkxxUHF@mail.gmail.com>
References: <AANLkTimBPhvukwqDGY8iORhY+wg8OnHi9+eOedJB2E8k@mail.gmail.com>
	<20100818141914.GC15536@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CDB3C10382C
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 16:33:21 +0200 (CEST)
Received: by ywg8 with SMTP id 8so11202ywg.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 07:33:19 -0700 (PDT)
In-Reply-To: <20100818141914.GC15536@sirena.org.uk>
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

On Wed, Aug 18, 2010 at 10:19 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 18, 2010 at 09:49:26PM +0800, Haojian Zhuang wrote:
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dac) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* automute is set before oper=
ating DAC. Anti-pop */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&pm860x->mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm860x->automute =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dac |=3D MODULATOR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* mute */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM8=
60X_DAC_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 DAC_MUTE, DAC_MUTE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM8=
60X_EAR_CTRL_2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 RSYNC_CHANGE, RSYNC_CHANGE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&pm860x->mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* update dac */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM8=
60X_DAC_EN_2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 dac, dac);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
>
> I still can't follow what this automute variable is supposed to be
> doing. =A0In both the PMU and the PMD cases you set automute, and the fact
> that you forcibly clear it when you apply the change means that it
> doesn't look like it's doing anything I'd recognise as automute,
> suggesting that the variable is misnamed. =A0It's very difficult to follow
> what all this is supposed to be doing.
>
Mute while DAC is enabled and PGA is updated. It's the purpose of
anti-pop by silicon.

> As I said last time what I'd expect to see is a user visible mute
> control which sets a variable in the driver which is then updated in the
> chip only while the DAC is powered. =A0The other option is to tie the
> control to the DAC power, in which case things should be handleable in
> the widget event without the variable.
>
Why should I move the work to invoking amixer by user? Why shouldn't
it be taken by driver automatically?

>> +static int pm860x_digital_mute(struct snd_soc_dai *codec_dai, int mute)
>> +{
>> + =A0 =A0 struct snd_soc_codec *codec =3D codec_dai->codec;
>> + =A0 =A0 int data =3D 0;
>> +
>> + =A0 =A0 if (mute)
>> + =A0 =A0 =A0 =A0 =A0 =A0 data =3D DAC_MUTE;
>> + =A0 =A0 snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, data);
>
> This isn't joined up at all with the automute code above...
>

>> + =A0 =A0 /* set master/slave audio interface */
>> + =A0 =A0 switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> + =A0 =A0 case SND_SOC_DAIFMT_CBM_CFM:
>> + =A0 =A0 case SND_SOC_DAIFMT_CBM_CFS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pm860x->dir =3D=3D PM860X_CLK_DIR_OUT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inf |=3D PCM_INF2_MASTER;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>
> This is still setting the same register value for two different DAI
> formats. =A0You need to fix this, and in the other set_fmt() function.
>
These two registers are EXACTLY same. Why do I need to define two same
bit macro?

> You're also missing a default: case.
>
Please check the code. If it's default case, it'll return -EINVAL. I
didn't miss it.

>> + =A0 =A0 if ((pm860x->det.hs_shrt & SND_JACK_BTN_0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 && (shrt & (SHORT_HS1 | SHORT_HS2)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D SND_JACK_BTN_0;
>> +
>> + =A0 =A0 if ((pm860x->det.hook_det & SND_JACK_BTN_1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 && (status & HOOK_STATUS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D SND_JACK_BTN_1;
>> +
>> + =A0 =A0 if ((pm860x->det.lo_shrt & SND_JACK_BTN_2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 && (shrt & (SHORT_LO1 | SHORT_LO2)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D SND_JACK_BTN_2;
>
> You should ideally allow the user to override these via platform data if
> the buttons have specific functions.
>
OK.

> One other thing you should do is split the jack configuration for
> headphone and microphone - a system may have two physical jacks, one for
> each, so you should allow the user to configure the detection onto
> separate jacks if they want to.
>
Up to now, I can't split it to two different jacks. Since there's some
issue on mic detection.
