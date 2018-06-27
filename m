From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/3] ALSA: hda - Handle error from
	snd_hda_power_up*()
Date: Wed, 27 Jun 2018 16:54:31 +0100
Message-ID: <153011487107.8693.7624551348316365861@mail.alporthouse.com>
References: <20180627091034.22724-1-tiwai@suse.de>
 <20180627091034.22724-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F238266E76
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 17:54:38 +0200 (CEST)
In-Reply-To: <20180627091034.22724-2-tiwai@suse.de>
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
Cc: =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai (2018-06-27 10:10:32)
> Although snd_hda_power_up() and snd_hda_power_up_pm() may fail, we
> haven't dealt with the error properly in many places.  It's an unusual
> situation but still possible.
> 
> This patch spots these places and adds the proper error paths.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Verdict from CI,

https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_2430/issues.html

is that this one causes a bunch of pm fallout.

Do you mind doing a quick revert? Or working with our CI to find the bad
chunk?

On a second look,

> @@ -7310,7 +7339,8 @@ static void ca0132_free(struct hda_codec *codec)
>         struct ca0132_spec *spec = codec->spec;
>  
>         cancel_delayed_work_sync(&spec->unsol_hp_work);
> -       snd_hda_power_up(codec);
> +       if (snd_hda_power_up(codec) < 0)
> +               goto skip_shutdown;
>         switch (spec->quirk) {
>         case QUIRK_SBZ:
>                 sbz_exit_chip(codec);
> @@ -7326,6 +7356,7 @@ static void ca0132_free(struct hda_codec *codec)
>                 break;
>         }
>         snd_hda_power_down(codec);
> + skip_shutdown:
>         if (spec->mem_base)
>                 iounmap(spec->mem_base);
>         kfree(spec->spec_init_verbs);

would seem to be the only chunk more complicated than the rest.
-Chris
