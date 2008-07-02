From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] ALSA SoC: Add OpenFirmware helper
	for	matching bus and codec drivers
Date: Wed, 2 Jul 2008 09:48:04 -0600
Message-ID: <20080702154804.GA23011@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<s5hiqvod37w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id B083F24663
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 17:48:08 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so643442wfg.23
	for <alsa-devel@alsa-project.org>; Wed, 02 Jul 2008 08:48:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hiqvod37w.wl%tiwai@suse.de>
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
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 02, 2008 at 11:50:43AM +0200, Takashi Iwai wrote:
> At Tue, 01 Jul 2008 17:53:30 -0600,
> Grant Likely wrote:
> > diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> > index 18f28ac..c5736e5 100644
> > --- a/sound/soc/Kconfig
> > +++ b/sound/soc/Kconfig
> > @@ -23,6 +23,12 @@ config SND_SOC
> >  	  This ASoC audio support can also be built as a module.  If so, the module
> >  	  will be called snd-soc-core.
> >  
> > +config SND_SOC_OF
> > +	tristate "OF helpers for SoC audio support"
> > +	depends on SND_SOC
> > +	---help---
> > +	  Add support for OpenFirmware device tree descriptions of sound device
> > +
> 
> This is a helper module and not necessarily manually selectable.
> Better to make the other driver selecting this.

Yes, you're right.  I hadn't put too much thought into the Kconfig stuff
for this patch because, at the moment, I'm viewing this as a temporary
solution until ASoCv2 is merged.

Which raises another question: Liam and Mark, what is your opinion on
merging this driver?  Is it something that you would merge with the v1
API and then rework it when v2 is merged?  Or would you rather it be
kept out until v2 is ready?  I haven't even looked at the v2 API yet, so
I don't know how much rework is involved.

Cheers,
g.
