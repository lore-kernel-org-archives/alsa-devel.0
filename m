From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] sound azt3328: hook up new emulated AC97
 on AC97 patch side
Date: Thu, 17 Feb 2011 19:25:45 +0100
Message-ID: <20110217182545.GA20893@rhlx01.hs-esslingen.de>
References: <20110216231612.GB1638@rhlx01.hs-esslingen.de>
	<s5htyg2woh2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 83F91103800
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 19:25:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htyg2woh2.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 17, 2011 at 06:38:33PM +0100, Takashi Iwai wrote:
> At Thu, 17 Feb 2011 00:16:12 +0100,
> Andreas Mohr wrote:
> > 
> > --- linux-2.6.orig/sound/pci/ac97/ac97_patch.c	2011-02-16 23:18:54.000000000 +0100
> > +++ linux-2.6/sound/pci/ac97/ac97_patch.c	2011-02-16 23:19:03.000000000 +0100
> > @@ -222,6 +222,47 @@
> >  	return is_surround_on(ac97);
> >  }
> >  
> > +/* find a mixer control element with the given name */
> > +static struct snd_kcontrol *snd_ac97_find_mixer_ctl(struct snd_ac97 *ac97,
> > +						    const char *name)
> 
> We don't have to copy the whole functions.
> Can't it be simply a function declaration?
> It's not necessary to grow the patch size...

OK, from a maintenance (e.g. -longterm) POV, that may be
a problematic patch hunk, however some people
consider (extra) forward declarations of function signatures to be a code smell.
And in this case this function clearly is infrastructure material for
several card-specific patch functions later on, thus one could
probably(?) argue that it should be at the top and not "somewhere in between"
all the patches.

But I can certainly change the patch to use whichever is the more favourable way.

Thanks!

Andreas Mohr
