From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Select INPUT for Realtek
	HD-audio codec
Date: Thu, 15 Jan 2015 10:20:59 +0100
Message-ID: <54B7867B.1070400@canonical.com>
References: <1421313591-28245-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 02060260418
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 10:20:58 +0100 (CET)
In-Reply-To: <1421313591-28245-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Acked-by: David Henningsson <david.henningsson@canonical.com>

Sorry for not writing up a patch yesterday.

On 2015-01-15 10:19, Takashi Iwai wrote:
> The commit commit [33f4acd3b214: ALSA: hda - Enable mic mute hotkey
> and LEDs for an HP machine] introduced a quirk for a HP machine
> involving with the input event handling.  Although the relevant code
> is protected via IS_ENABLED(CONFIG_INPUT), this doesn't suffice when
> the audio driver is built in while the input is module.
>
> As an easy workaround, this patch forcibly selects CONFIG_INPUT in
> Kconfig.  This shouldn't be a practical problem since CONFIG_INPUT is
> almost mandatory for all systems.  Also, this allows to remove the
> ugly ifdefs in the code.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/Kconfig         | 1 +
>   sound/pci/hda/patch_realtek.c | 6 ------
>   2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
> index ebf4c2fb99df..7f0f2c5a4e97 100644
> --- a/sound/pci/hda/Kconfig
> +++ b/sound/pci/hda/Kconfig
> @@ -107,6 +107,7 @@ config SND_HDA_PATCH_LOADER
>   config SND_HDA_CODEC_REALTEK
>   	tristate "Build Realtek HD-audio codec support"
>   	select SND_HDA_GENERIC
> +	select INPUT
>   	help
>   	  Say Y or M here to include Realtek HD-audio codec support in
>   	  snd-hda-intel driver, such as ALC880.
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index a50e15e166c6..1720f8a457d1 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -121,9 +121,7 @@ struct alc_spec {
>   	hda_nid_t pll_nid;
>   	unsigned int pll_coef_idx, pll_coef_bit;
>   	unsigned int coef0;
> -#if IS_ENABLED(CONFIG_INPUT)
>   	struct input_dev *kb_dev;
> -#endif
>   };
>
>   /*
> @@ -3476,7 +3474,6 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *codec,
>   	}
>   }
>
> -#if IS_ENABLED(CONFIG_INPUT)
>   static void gpio2_mic_hotkey_event(struct hda_codec *codec,
>   				   struct hda_jack_callback *event)
>   {
> @@ -3489,12 +3486,10 @@ static void gpio2_mic_hotkey_event(struct hda_codec *codec,
>   	input_report_key(spec->kb_dev, KEY_MICMUTE, 0);
>   	input_sync(spec->kb_dev);
>   }
> -#endif
>
>   static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
>   					     const struct hda_fixup *fix, int action)
>   {
> -#if IS_ENABLED(CONFIG_INPUT)
>   	/* GPIO1 = set according to SKU external amp
>   	   GPIO2 = mic mute hotkey
>   	   GPIO3 = mute LED
> @@ -3550,7 +3545,6 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
>   		input_unregister_device(spec->kb_dev);
>   		spec->kb_dev = NULL;
>   	}
> -#endif
>   }
>
>   static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
