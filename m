From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] ALSA: hda: Simplify
	snd_hdac_refresh_widgets()
Date: Mon, 8 Jul 2019 09:49:01 -0700
Message-ID: <CAE=gft72HzSUG6Yc0G2wTdGgmUste67ZUDibjBttXZVD7Kds8Q@mail.gmail.com>
References: <20190705100605.19945-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99F89F801A4
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2019 18:49:41 +0200 (CEST)
Received: by mail-lf1-x142.google.com with SMTP id b17so7813154lff.7
 for <alsa-devel@alsa-project.org>; Mon, 08 Jul 2019 09:49:40 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com.
 [209.85.208.171])
 by smtp.gmail.com with ESMTPSA id j11sm2868841lfm.29.2019.07.08.09.49.38
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jul 2019 09:49:38 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id k18so16620758ljc.11
 for <alsa-devel@alsa-project.org>; Mon, 08 Jul 2019 09:49:38 -0700 (PDT)
In-Reply-To: <20190705100605.19945-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 5, 2019 at 3:06 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> Along with the recent fix for the races of snd_hdac_refresh_widgets()
> it turned out that the instantiation of widgets sysfs at
> snd_hdac_sysfs_reinit() could cause a race.  The race itself was
> already covered later by extending the mutex protection range, the
> commit 98482377dc72 ("ALSA: hda: Fix widget_mutex incomplete
> protection"), but this also indicated that the call of *_reinit() is
> basically superfluous, as the widgets shall be created sooner or later
> from snd_hdac_device_register().
>
> This patch removes the redundant call of snd_hdac_sysfs_reinit() at
> first.  By this removal, the sysfs argument itself in
> snd_hdac_refresh_widgets() becomes superfluous, too, because the only
> case sysfs=false is always with codec->widgets=NULL.  So, we drop this
> redundant argument as well.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/sound/hdaudio.h      |  2 +-
>  sound/hda/hdac_device.c      | 13 +++++--------
>  sound/hda/hdac_sysfs.c       |  2 +-
>  sound/pci/hda/hda_codec.c    |  2 +-
>  sound/soc/codecs/hdac_hdmi.c |  2 +-
>  5 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> index e8346784cf3f..f475293d0668 100644
> --- a/include/sound/hdaudio.h
> +++ b/include/sound/hdaudio.h
> @@ -120,7 +120,7 @@ void snd_hdac_device_unregister(struct hdac_device *codec);
>  int snd_hdac_device_set_chip_name(struct hdac_device *codec, const char *name);
>  int snd_hdac_codec_modalias(struct hdac_device *hdac, char *buf, size_t size);
>
> -int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs);
> +int snd_hdac_refresh_widgets(struct hdac_device *codec);
>
>  unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
>                                unsigned int verb, unsigned int parm);
> diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
> index 11050bfd8068..a265c1d68876 100644
> --- a/sound/hda/hdac_device.c
> +++ b/sound/hda/hdac_device.c
> @@ -89,7 +89,7 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
>
>         fg = codec->afg ? codec->afg : codec->mfg;
>
> -       err = snd_hdac_refresh_widgets(codec, false);
> +       err = snd_hdac_refresh_widgets(codec);
>         if (err < 0)
>                 goto error;
>
> @@ -394,9 +394,8 @@ static void setup_fg_nodes(struct hdac_device *codec)
>  /**
>   * snd_hdac_refresh_widgets - Reset the widget start/end nodes
>   * @codec: the codec object
> - * @sysfs: re-initialize sysfs tree, too
>   */
> -int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
> +int snd_hdac_refresh_widgets(struct hdac_device *codec)
>  {
>         hda_nid_t start_nid;
>         int nums, err = 0;
> @@ -414,11 +413,9 @@ int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
>                 goto unlock;
>         }
>
> -       if (sysfs) {
> -               err = hda_widget_sysfs_reinit(codec, start_nid, nums);
> -               if (err < 0)
> -                       goto unlock;
> -       }
> +       err = hda_widget_sysfs_reinit(codec, start_nid, nums);
> +       if (err < 0)
> +               goto unlock;
>
>         codec->num_nodes = nums;
>         codec->start_nid = start_nid;
> diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
> index 909d5ef1179c..e56e83325903 100644
> --- a/sound/hda/hdac_sysfs.c
> +++ b/sound/hda/hdac_sysfs.c
> @@ -428,7 +428,7 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
>         int i;
>
>         if (!codec->widgets)
> -               return hda_widget_sysfs_init(codec);
> +               return 0;

Hi Takashi,
So this no-ops out reinit() if there are no widgets. Are there any
cases in which hda_widget_sysfs_exit() could be called, followed by
hda_widget_sysfs_reinit()? That would be problematic, as exit would
wipe out the widgets, but now reinit would never restore them.

Are there any plausible cases where a caller might call
refresh_widgets() and then attempt to utilize or otherwise depend on
the widgets being present? The semantics of this function seem odd to
me now, as it will now return having updated num_nodes, start_nid, and
end_nid, but without having actually built the widgets array.

I'm probably biased, but I still think it makes more sense to let
sysfs_reinit actually reinitialize the widgets, but just pass down
start_nid and count so that the tree is built correctly.
-Evan
