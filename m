From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_array_free - snd: bad kfree when HDA reconfig
Date: Thu, 15 Sep 2011 22:23:12 +0800
Message-ID: <CAN8ccibfeqqOJCm5mc6WPcy__vmb0fEV+prBxkFosr6wRjoHSg@mail.gmail.com>
References: <CAN8cciZcDYzWdLZxGZQH40Q2Vi2+7D3oNpk48Jw=X7n-Q5Tvwg@mail.gmail.com>
	<s5hlitu8api.wl%tiwai@suse.de>
	<CAN8cciaVf7eoenrPmR2d4gxqyqs4TAk1OVt3wgzLi_qo09hQuw@mail.gmail.com>
	<s5hy5xrek5e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B950103B1D
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 16:23:13 +0200 (CEST)
Received: by fxe22 with SMTP id 22so694977fxe.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 07:23:12 -0700 (PDT)
In-Reply-To: <s5hy5xrek5e.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/14 Takashi Iwai <tiwai@suse.de>:
>
> Try the patch below in addition to the previous one.
>
>
> thanks,
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] Add missing export of snd_hidden_ksize()
>
> Also fix the ifdef of krealloc() wrapper for some corner cases.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> =A0acore/sound.inc =A0 | =A0 =A01 +
> =A0include/adriver.h | =A0 =A03 ++-
> =A02 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/acore/sound.inc b/acore/sound.inc
> index a79755e..2e63c98 100644
> --- a/acore/sound.inc
> +++ b/acore/sound.inc
> @@ -3,6 +3,7 @@
> =A0EXPORT_SYMBOL(snd_hidden_kmalloc);
> =A0EXPORT_SYMBOL(snd_hidden_kzalloc);
> =A0EXPORT_SYMBOL(snd_hidden_kcalloc);
> +EXPORT_SYMBOL(snd_hidden_ksize);
> =A0EXPORT_SYMBOL(snd_hidden_kfree);
> =A0EXPORT_SYMBOL(snd_hidden_kstrdup);
> =A0EXPORT_SYMBOL(snd_hidden_kstrndup);
> diff --git a/include/adriver.h b/include/adriver.h
> index fe70442..848bc17 100644
> --- a/include/adriver.h
> +++ b/include/adriver.h
> @@ -2002,7 +2002,8 @@ static inline bool flush_delayed_work_sync(struct d=
elayed_work *dwork)
> =A0#endif
>
> =A0/* krealloc() wrapper */
> -#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 6, 0) && LINUX_VERSION_CO=
DE < KERNEL_VERSION(2, 6, 22)) || defined(CONFIG_SND_DEBUG_MEMORY)
> +#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 6, 0) && LINUX_VERSION_CO=
DE < KERNEL_VERSION(2, 6, 22)) || \
> + =A0 =A0 =A0 (defined(CONFIG_SND_DEBUG_MEMORY) && !defined(SKIP_HIDDEN_M=
ALLOCS))
> =A0#include <linux/slab.h>
> =A0static inline void *snd_compat_krealloc(const void *p, size_t new_size=
, gfp_t flags)
> =A0{
> --
> 1.7.6.1
>
>

your patch fix the problem

BTW, there is some strange behaviour of the non-sticky pcm
implementation on ad1988

Refer to commit 0e7adbe263f89ea2ef15b5af5e80a812b2a85025

Disable sticky PCM stream assignment for AD codecs

why hda_codec_cleanup_stream is called twice  and this also occur with
capture and playback


ALSA hda_intel.c:1755: azx_pcm_prepare: bufsize=3D0x10000, format=3D0x4011
ALSA hda_codec.c:1408: hda_codec_setup_stream: NID=3D0x4, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1408: hda_codec_setup_stream: NID=3D0x3, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1408: hda_codec_setup_stream: NID=3D0x6, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1408: hda_codec_setup_stream: NID=3D0x5, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1408: hda_codec_setup_stream: NID=3D0xa, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x4
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x6
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x5
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0xa
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x3
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x4
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x6
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x5
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0xa
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x3



ALSA hda_intel.c:1755: azx_pcm_prepare: bufsize=3D0x10000, format=3D0x4011
ALSA hda_codec.c:1408: hda_codec_setup_stream: NID=3D0x8, stream=3D0x1,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x8
ALSA hda_codec.c:1471: hda_codec_cleanup_stream: NID=3D0x8
