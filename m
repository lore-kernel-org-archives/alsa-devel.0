From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Tue, 16 Feb 2016 18:26:09 +0100
Message-ID: <2706488.VpKveMVPGI@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <112888486.mQgaWiH0PI@wuerfel> <s5hr3gc60ph.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B646826068F
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 18:26:26 +0100 (CET)
In-Reply-To: <s5hr3gc60ph.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Han Lu <han.lu@intel.com>, Libin Yang <libin.yang@linux.intel.com>, Thierry Reding <treding@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 16 February 2016 18:10:02 Takashi Iwai wrote:
> diff --git a/include/sound/jack.h b/include/sound/jack.h
> index 23bede121c78..a27c253a3207 100644
> --- a/include/sound/jack.h
> +++ b/include/sound/jack.h
> @@ -99,6 +99,7 @@ void snd_jack_report(struct snd_jack *jack, int status);
>  static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
>                                struct snd_jack **jack, bool initial_kctl, bool phantom_jack)
>  {
> +       *jack = NULL;
>         return 0;
>  }
>  
> diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
> index a33234e04d4f..babd3a8864a1 100644
> --- a/sound/pci/hda/hda_jack.c
> +++ b/sound/pci/hda/hda_jack.c
> @@ -403,10 +403,12 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
>  
>         jack->phantom_jack = !!phantom_jack;
>         jack->type = type;
> -       jack->jack->private_data = jack;
> -       jack->jack->private_free = hda_free_jack_priv;
> -       state = snd_hda_jack_detect(codec, nid);
> -       snd_jack_report(jack->jack, state ? jack->type : 0);
> +       if (jack->jack) {
> +               jack->jack->private_data = jack;
> +               jack->jack->private_free = hda_free_jack_priv;
> +               state = snd_hda_jack_detect(codec, nid);
> +               snd_jack_report(jack->jack, state ? jack->type : 0);
> +       }
>  
>         return 0;
>  }
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 8ee78dbd4c60..34a7b3aaba11 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2158,8 +2158,10 @@ static int add_acomp_jack_kctl(struct hda_codec *codec,
>         if (err < 0)
>                 return err;
>         per_pin->acomp_jack = jack;
> -       jack->private_data = per_pin;
> -       jack->private_free = free_acomp_jack_priv;
> +       if (jack) {
> +               jack->private_data = per_pin;
> +               jack->private_free = free_acomp_jack_priv;
> +       }
>         return 0;
>  }
> 
Looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>
