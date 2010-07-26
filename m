From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Wrong channel order with multichannel HDMI on MCP7A
Date: Mon, 26 Jul 2010 12:32:23 +0300
Message-ID: <201007261232.24106.anssi.hannula@iki.fi>
References: <201007251951.39362.anssi.hannula@iki.fi>
	<s5hocduwqom.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 5301A103884
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 11:32:29 +0200 (CEST)
In-Reply-To: <s5hocduwqom.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai kirjoitti maanantai, 26. hein=E4kuuta 2010 12:14:17:
> At Sun, 25 Jul 2010 19:51:39 +0300,
> =

> Anssi Hannula wrote:
> > Hi all!
> > =

> > I have a motherboard with NVIDIA MCP7A HDMI audio.
> > However, multichannel audio is not mapped properly into the HDMI order.
> > =

> > On 5.1, I get RL in FC, RR in LFE, FC in RL, LFE in RR.
> > =

> > Interestingly, this is not consistent with the ALSA channel order (FL FR
> > RL RR FC LFE) being passed directly to HDMI (FL FR LFE FC RL RR).
> > Instead it looks like there has been a waveformatex (FL FR FC LFE RL RR;
> > windows?) =3D> HDMI conversion instead of ALSA =3D> HDMI.
> > =

> > Same happens for 7.1.
> > =

> > Is it possible to set the hardware to do an ALSA =3D> HDMI conversion
> > instead? If not, we should manually compensate for this somewhere,
> > right?
> =

> Does the patch below change anything?

AFAICS no stuff from patch_hdmi.c is used for MCP7x, so it has no effect. =

Tested anyway, it doesn't change anything.

> > Somewhat relatedly, trying to output 4 channels results in silence only.
> =

> Although 5.1/7.1 work?

Yep, with wrong channel order.

> > Trying to output 3 or 5 channels triggers a timeout with I/O error, with
> > the following in the kernel log: "ALSA pcm_lib.c:1757: playback write
> > error (DMA or IRQ trouble?)"
> =

> HD-audio doesn't support the odd number of channels in general, so
> they should be played as 4 or 6 channels.  But, it looks like
> something wrong in the setup...
> =

> =

> thanks,
> =

> Takashi
> =

> ---
> diff --git a/sound/pci/hda/patch_nvhdmi.c b/sound/pci/hda/patch_nvhdmi.c
> index 3c10c0b..7355c60 100644
> --- a/sound/pci/hda/patch_nvhdmi.c
> +++ b/sound/pci/hda/patch_nvhdmi.c
> @@ -511,6 +511,8 @@ static int patch_nvhdmi_8ch_7x(struct hda_codec *code=
c)
> =

>  	codec->patch_ops =3D nvhdmi_patch_ops_8ch_7x;
> =

> +	init_channel_allocations();
> +
>  	return 0;
>  }

-- =

Anssi Hannula
