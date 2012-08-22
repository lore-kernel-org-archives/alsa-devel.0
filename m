From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - fix broken HDMI jack detection
	after S3
Date: Wed, 22 Aug 2012 19:00:32 +0200
Message-ID: <50351030.9050008@canonical.com>
References: <1345636901-9386-1-git-send-email-david.henningsson@canonical.com>
 <s5hy5l7yv4l.wl%tiwai@suse.de> <5034D2F5.3050406@canonical.com>
 <s5hvcgbytg6.wl%tiwai@suse.de> <5034E2D3.1080701@canonical.com>
 <s5hmx1nyqxx.wl%tiwai@suse.de> <5034EC57.2090503@canonical.com>
 <s5hfw7fyobn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E18262664C0
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 19:00:33 +0200 (CEST)
In-Reply-To: <s5hfw7fyobn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 1040030@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 08/22/2012 04:49 PM, Takashi Iwai wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Call snd_hda_jack_report_sync() generically in hda_codec.c
>
> Instead of calling the jack sync in the init callback of each codec,
> call it generically at initialization and resume.  By calling it at
> the last of resume sequence, a possible race between the jack sync and
> the unsol event enablement in the current code will be closed, too.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: David Henningsson <david.henningsson@canonical.com>

> ---
>   sound/pci/hda/hda_codec.c      | 2 ++
>   sound/pci/hda/patch_cirrus.c   | 2 --
>   sound/pci/hda/patch_conexant.c | 1 -
>   sound/pci/hda/patch_hdmi.c     | 2 --
>   sound/pci/hda/patch_realtek.c  | 2 --
>   sound/pci/hda/patch_sigmatel.c | 2 --
>   sound/pci/hda/patch_via.c      | 1 -
>   7 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index a6c34dc..4efd271 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -3618,6 +3618,7 @@ static void hda_call_codec_resume(struct hda_codec *codec)
>   		snd_hda_codec_resume_amp(codec);
>   		snd_hda_codec_resume_cache(codec);
>   	}
> +	snd_hda_jack_report_sync(codec);
>   	snd_hda_power_down(codec); /* flag down before returning */
>   }
>   #endif /* CONFIG_PM */
> @@ -3663,6 +3664,7 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
>   		err = codec->patch_ops.build_controls(codec);
>   	if (err < 0)
>   		return err;
> +	snd_hda_jack_report_sync(codec); /* call at the last init point */
>   	return 0;
>   }
>
> diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
> index 0c4c1a6..0bddb3e 100644
> --- a/sound/pci/hda/patch_cirrus.c
> +++ b/sound/pci/hda/patch_cirrus.c
> @@ -1193,7 +1193,6 @@ static int cs_init(struct hda_codec *codec)
>   	init_output(codec);
>   	init_input(codec);
>   	init_digital(codec);
> -	snd_hda_jack_report_sync(codec);
>
>   	return 0;
>   }
> @@ -1643,7 +1642,6 @@ static int cs421x_init(struct hda_codec *codec)
>   	init_output(codec);
>   	init_input(codec);
>   	init_cs421x_digital(codec);
> -	snd_hda_jack_report_sync(codec);
>
>   	return 0;
>   }
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 5e22a8f..172895a 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -4061,7 +4061,6 @@ static int cx_auto_init(struct hda_codec *codec)
>   	cx_auto_init_output(codec);
>   	cx_auto_init_input(codec);
>   	cx_auto_init_digital(codec);
> -	snd_hda_jack_report_sync(codec);
>   	snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
>   	return 0;
>   }
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 8f23374..d9439c5 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1311,7 +1311,6 @@ static int generic_hdmi_init(struct hda_codec *codec)
>   		hdmi_init_pin(codec, pin_nid);
>   		snd_hda_jack_detect_enable(codec, pin_nid, pin_nid);
>   	}
> -	snd_hda_jack_report_sync(codec);
>   	return 0;
>   }
>
> @@ -1428,7 +1427,6 @@ static int simple_playback_init(struct hda_codec *codec)
>   		snd_hda_codec_write(codec, pin, 0, AC_VERB_SET_AMP_GAIN_MUTE,
>   				    AMP_OUT_UNMUTE);
>   	snd_hda_jack_detect_enable(codec, pin, pin);
> -	snd_hda_jack_report_sync(codec);
>   	return 0;
>   }
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 4f81dd4..ce99cc9 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -2053,8 +2053,6 @@ static int alc_init(struct hda_codec *codec)
>
>   	alc_apply_fixup(codec, ALC_FIXUP_ACT_INIT);
>
> -	snd_hda_jack_report_sync(codec);
> -
>   	hda_call_check_power_status(codec, 0x01);
>   	return 0;
>   }
> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
> index ea5775a..4352954 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -4418,8 +4418,6 @@ static int stac92xx_init(struct hda_codec *codec)
>   		stac_toggle_power_map(codec, nid, 0);
>   	}
>
> -	snd_hda_jack_report_sync(codec);
> -
>   	/* sync mute LED */
>   	if (spec->gpio_led) {
>   		if (spec->vmaster_mute.hook)
> diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
> index 4307717..4b0796b 100644
> --- a/sound/pci/hda/patch_via.c
> +++ b/sound/pci/hda/patch_via.c
> @@ -2815,7 +2815,6 @@ static int via_init(struct hda_codec *codec)
>
>   	via_hp_automute(codec);
>   	vt1708_update_hp_work(spec);
> -	snd_hda_jack_report_sync(codec);
>
>   	return 0;
>   }
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
