From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: add 88pm860x codec driver
Date: Tue, 17 Aug 2010 19:37:21 +0800
Message-ID: <AANLkTikCqRFwn5dhVah7D9Cuu7PvUeTV_ywzZzz+DLxV@mail.gmail.com>
References: <AANLkTi=i5H_oJvXzMv71ofxyw9FFXpiXU=pgzf+rdgk0@mail.gmail.com>
	<20100817095800.GD18622@rakim.wolfsonmicro.main>
	<AANLkTi=4vfkpDF=RkTtRTUR=XP9UAmhkJyvFvowV_89O@mail.gmail.com>
	<20100817110223.GA18179@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 02BC724142
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 13:37:21 +0200 (CEST)
Received: by wyb42 with SMTP id 42so6954215wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2010 04:37:21 -0700 (PDT)
In-Reply-To: <20100817110223.GA18179@rakim.wolfsonmicro.main>
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

On Tue, Aug 17, 2010 at 7:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Aug 17, 2010 at 06:44:44PM +0800, Haojian Zhuang wrote:
>> On Tue, Aug 17, 2010 at 5:58 PM, Mark Brown
>
>> >> + =A0 =A0 switch (event) {
>> >> + =A0 =A0 case SND_SOC_DAPM_PRE_PMU:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_ADC_EN_1,=
 en1, en1);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, PM860X_ADC_EN_2,=
 en2, en2);
>
>> > I still don't follow why you need a custom event for this.
>
>> Enabling both bit 0 of ADC_EN_1 and bit 5 of ADC_EN_2 can enable left
>> ADC. Enabling both bit 1 of ADC_EN_1 and bit 4 of ADC_EN_2 can enable
>> right ADC. I can't find any DAPM API can handle this. So I implement
>> the custom event.
>
> As I said previously I would expect you to be using a DAPM supply widget
> for this.
>
Supply widget should be always on while DAPM is working. How about
only enable left ADC?

>> >> + =A0 =A0 /* set master/slave audio interface */
>> >> + =A0 =A0 switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> >> + =A0 =A0 case SND_SOC_DAIFMT_CBM_CFM:
>> >> + =A0 =A0 case SND_SOC_DAIFMT_CBM_CFS:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (pm860x->dir =3D=3D PM860X_CLK_DIR_OUT)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *inf |=3D PCM_INF2_MASTER;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
>> > You're setting the same register configuration for two different DAI
>> > clock master configurations here. =A0Presumably one of the settings is
>> > inaccurate?
>
>> No, they're different registers. But offsets are same. So I just return =
pointer.
>
> I can't associate your comment there with the code at all. =A0The code
> does nothing different for the two case statements and there's no other
> code I can see.
>
You can find pm860x_pcm_set_dai_fmt() and pm860x_i2s_set_dai_fmt().
Both functions called set_dai_fmt(). In set_dai_fmt(), all bit
operations are based on variable, not registers. Register operation is
implemented in pcm_set_dai_fmt() and i2s_set_dai_fmt().

>> >> + =A0 =A0 if (shrt & (SHORT_LO1 | SHORT_LO2))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D PM860X_SHORT_LINEOUT;
>> >> + =A0 =A0 if (shrt & (SHORT_HS1 | SHORT_HS2))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 report |=3D PM860X_SHORT_HEADSET;
>> >> + =A0 =A0 dev_dbg(pm860x->codec->dev, "report:0x%x\n", report);
>> >> + =A0 =A0 return IRQ_HANDLED;
>
>> > It would seem better to just remove the interrupt handling support
>> > entirely if you're not going to implement jack detection. =A0Right now=
 all
>> > the curernt code will do is waste power by enabling the feature but
>> > ignoring the result.
>
>> I need a document on illustrating jack on alsa. Could you share one?
>
> There's a number of in tree examples - seach for snd_soc_jack.
>
OK. How to test it? Still no document?
