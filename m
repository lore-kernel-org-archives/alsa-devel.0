From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Pop noise on startup when headphones are plugged
	in (Dell XPS13 9333)
Date: Sat, 25 Apr 2015 13:51:33 +0200
Message-ID: <2264204.W7vnUSq2WO@xps13>
References: <23057263.IjMh4t6SYF@xps13>
 <CABFtUbRvTL2tB3esKUoxYRLmbzQPwa8i+aDyqZkVnaEYXC_0Zg@mail.gmail.com>
 <s5h1tj9o7z2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 568142614FF
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 13:51:35 +0200 (CEST)
Received: by wgen6 with SMTP id n6so74139514wge.3
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 04:51:35 -0700 (PDT)
In-Reply-To: <s5h1tj9o7z2.wl-tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 24 April 2015 17:34:57 Takashi Iwai wrote:
> At Fri, 24 Apr 2015 17:14:24 +0200,
> Gabriele Mazzotta wrote:
> > 
> > 2015-04-24 8:13 GMT+02:00 Takashi Iwai <tiwai@suse.de>:
> > > At Thu, 23 Apr 2015 21:12:50 +0200,
> > > Gabriele Mazzotta wrote:
> > >>
> > >> On Sunday 19 April 2015 19:26:58 Gabriele Mazzotta wrote:
> > >> > Hi,
> > >> >
> > >> > I've recently found that commit a551d91473 ("ALSA: hda - Use regmap for
> > >> > command verb caches, too") is somehow causing a pop noise on startup
> > >> > when headphones are plugged in, but I couldn't figure out the exact
> > >> > cause. Was this observed on other systems (mine is a Dell XPS13 9333,
> > >> > Realtek ALC3661)? Does anyone have any idea of what the cause might be?
> > >>
> > >> Hi,
> > >>
> > >> I don't know why a551d91473 caused the issue, but I found the real
> > >> cause of problem.
> > >>
> > >> On init, create_input_ctls() sets the vref of nid 0x19 to 80 (as
> > >> returned by snd_hda_get_default_vref()), but it should be set to HIZ.
> > >> This is not so different from the issue addressed by f38663ab5c
> > >> ("ALSA: hda - Set internal mic as default input source on Dell XPS 13 9333").
> > >>
> > >> I made a patch to prevent this from happening.
> > >>
> > >> Setting the vref is not necessary since alc_update_headset_mode() will
> > >> take care of it.
> > >>
> > >> Should I maybe add a new flag instead of using suppress_hp_mic_detect?
> > >
> > > Yeah, that's better.  Although the flag is currently unused, it's
> > > provided for a different purpose (to skip the headphone mic detection;
> > > which is different from "headset" mic).
> > >
> > > I wonder, though, whether the patch below improves anything.
> > > A similar patch was in the development series in the past, but I had
> > > to drop it because it caused behavior error.  But now I tried again,
> > > and it seems working.
> > >
> > >
> > > Takashi
> > 
> > The patch did no harm, but didn't solve the problem.
> 
> OK, so the problem doesn't seem relevant with the runtime PM, which
> was the usual suspect.
> 
> My patch should reduce the actual verb writes, so it would be nice to
> have even if it doesn't fix your problem.  But maybe I'll postpone it
> as a 4.2 material.
> 
> 
> thanks,
> 
> Takashi

Hi,

I think this the patch here below is simpler than the other I sent.
snd_hda_get_default_vref() guesses the vref input pins. We know that
some of these are for headphones/headset mics, so we could set the
vref to HIZ for these.

Are there systems that would misbehave with this change?

Gabriele

---
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 3d2597b..081db8b 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3257,7 +3257,9 @@ static int create_input_ctls(struct hda_codec *codec)
 			continue;
 
 		val = PIN_IN;
-		if (cfg->inputs[i].type == AUTO_PIN_MIC)
+		if (cfg->inputs[i].type == AUTO_PIN_MIC &&
+		    !cfg->inputs[i].is_headset_mic &&
+		    !cfg->inputs[i].is_headphone_mic)
 			val |= snd_hda_get_default_vref(codec, pin);
 		if (pin != spec->hp_mic_pin)
 			set_pin_target(codec, pin, val, false);
