From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Fri, 9 Dec 2011 18:37:40 +0900
Message-ID: <CANKRQnhNJaiQvzBBy10oBV_=TP+rxtPXE-cX=8uMsgXY6qrN+A@mail.gmail.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
	<20111202153401.GX8245@opensource.wolfsonmicro.com>
	<CANKRQniyjT_2Ko=EYmffu3_NzDJQTMm9nY6rUp-DQ70e6AVQpA@mail.gmail.com>
	<20111205183223.GB7467@opensource.wolfsonmicro.com>
	<CANKRQnhEFvubv0b63z34=_xn4x4q=20enofqPrMsFetj1x7-NQ@mail.gmail.com>
	<CANKRQnhbBNDjQw5MQGexZAEboC0oHB5QS1LfHo6pDeoeDSwByw@mail.gmail.com>
	<20111207132322.GA18837@opensource.wolfsonmicro.com>
	<CANKRQniJR+b1gUwZUUiPoNDKVqU7TCkThLaHL2DFXAF=cARrTA@mail.gmail.com>
	<20111209084337.GJ26952@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3B5E7243D0
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 10:37:44 +0100 (CET)
Received: by dajy12 with SMTP id y12so2725761daj.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Dec 2011 01:37:40 -0800 (PST)
In-Reply-To: <20111209084337.GJ26952@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Dec 09, 2011 at 05:38:57PM +0900, Tomoya MORINAGA wrote:
>
>> Firstly, the above "dai_link structure" means below ? If yes, there is
>> no member "dai_fmt", right ?
>> 697 struct snd_soc_dai_link {
>
> As previously advised you should work against current development
> kernels. =A0dai_fmt is present in current development kernels (and Linus'
> tree for that matter).
>
>> > + =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIF=
MT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>
>> At the above point, do you mean I shouldn't =A0set these formats(
>> SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS)
>> directly ?
>
> Yes.

Seeing linux-next tree, I could understand your saying.
I saw linux tree(3.2-rc4).

thanks,
tomoya
