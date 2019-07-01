From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: why error return in
 sound/soc/codecs/pcm3168a.c::pcm3168a_set_dai_fmt ?
Date: Mon, 1 Jul 2019 15:06:09 +0200
Message-ID: <20190701130609.GB3692@piout.net>
References: <8e4d6674-0a5b-7063-534d-cea4e55056d5@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F1DDF8076A
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2019 15:06:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8e4d6674-0a5b-7063-534d-cea4e55056d5@televic.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jurgen Lambrecht <J.Lambrecht@televic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

On 04/06/2019 06:37:48+0000, Jurgen Lambrecht wrote:
> Hi,
> =

> When following =

> https://bootlin.com/blog/eight-channels-audio-on-i-mx7-with-pcm3168/ I =

> get this error (from soc_core.c):
> =

> ... kernel: [=A0=A0=A0 3.059634][=A0=A0 T15] pcm3168a 3-0039: ASoC: Faile=
d to set =

> DAI format: -22
> =

> I could propose this patch (I get that printf when applying the patch)
> (all other errors in that file have a printf):
> =

> diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
> index 08d3fe192e65..75ccbb919902 100644
> --- a/sound/soc/codecs/pcm3168a.c
> +++ b/sound/soc/codecs/pcm3168a.c
> @@ -353,6 +353,7 @@ static int pcm3168a_set_dai_fmt(struct snd_soc_dai *d=
ai,
>  =A0=A0=A0=A0=A0=A0=A0 case SND_SOC_DAIFMT_NB_NF:
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>  =A0=A0=A0=A0=A0=A0=A0 default:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(component->dev, "wron=
g INV_MASK\n");
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>  =A0=A0=A0=A0=A0=A0=A0 }
> =

> But why does this code returns an error for code that has no effect?
> OK, it could be because SND_SOC_DAIFMT_INV_MASK must be =

> SND_SOC_DAIFMT_NB_NF. But then Alexandre's blog contains an error, =

> because the dac TDM sets frame-inversion in its dts (and it should not).
> =


While I'm pretty sure what is in the blog is working (it is deployed in
production), I remember there was something fishy with frame-inversion.
I unfortunately don't remember the specifics.

Honestly, I would think you can remove frame-inversion safely as the
codec is only supposed to support NB_NF.

-- =

Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
