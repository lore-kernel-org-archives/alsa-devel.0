From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Pop noise on startup when headphones are plugged
	in (Dell XPS13 9333)
Date: Mon, 20 Apr 2015 21:51:53 +0200
Message-ID: <1995457.VaPu0mS3r8@xps13>
References: <23057263.IjMh4t6SYF@xps13> <s5h618rwdc8.wl-tiwai@suse.de>
 <s5h1tjfw9m7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CF9C265529
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 21:51:55 +0200 (CEST)
Received: by wicmx19 with SMTP id mx19so48030037wic.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 12:51:55 -0700 (PDT)
In-Reply-To: <s5h1tjfw9m7.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 20 April 2015 09:18:40 Takashi Iwai wrote:
> At Mon, 20 Apr 2015 07:58:15 +0200,
> Takashi Iwai wrote:
> > 
> > At Sun, 19 Apr 2015 19:26:58 +0200,
> > Gabriele Mazzotta wrote:
> > > 
> > > Hi,
> > > 
> > > I've recently found that commit a551d91473 ("ALSA: hda - Use regmap for
> > > command verb caches, too") is somehow causing a pop noise on startup
> > > when headphones are plugged in, but I couldn't figure out the exact
> > > cause. Was this observed on other systems (mine is a Dell XPS13 9333,
> > > Realtek ALC3661)? Does anyone have any idea of what the cause might be?
> > 
> > Are you sure that the commit is the culprit?  There are lots of other
> > changes like the widget-based power saving.
> 
> FYI, the widget power-saving can be disabled by the following.  (It
> can be done by hints, too.)
> 
> If this fixes the problem, we likely need more tweaks at path power
> activation.  Or, as a last resort, put this to the fixup for your
> model.

Unfortunately the change here below has no effect on my machine.
patch_alc662() is the right function.

> Takashi
> 
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 231d0e4b9a95..637ff2b70f6e 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5584,7 +5584,7 @@ static int patch_alc269(struct hda_codec *codec)
>  
>  	spec = codec->spec;
>  	spec->gen.shared_mic_vref_pin = 0x18;
> -	codec->power_save_node = 1;
> +	/* codec->power_save_node = 1; */
>  
>  	snd_hda_pick_fixup(codec, alc269_fixup_models,
>  		       alc269_fixup_tbl, alc269_fixups);
