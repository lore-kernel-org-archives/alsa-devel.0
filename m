From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ALSA: HDA: hda_local: Less magic numbers.
Date: Wed, 17 Sep 2008 13:31:58 +0930 (CST)
Message-ID: <200809170401.m8H41wmn014947@mercury.physics.adelaide.edu.au>
References: <s5h8wtsmgtu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 8929A1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 06:15:35 +0200 (CEST)
In-Reply-To: <s5h8wtsmgtu.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 16,
	2008 02:10:53 PM
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
Cc: alsa-devel@alsa-project.org, "Robin H. Johnson" <robbat2@gentoo.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Takashi

> > A quick glance at the codebase shows:
> > 
> > AC_PINCTL* long form:
> > patch_conexant.c
> > patch_realtek.c
> > patch_sigmatel.c
> > 
> > /PIN_(VREF|IN|OUT|HP)/
> > hda_codec.c
> > patch_analog.c
> > patch_atihdmi.c
> > patch_cmedia.c
> > patch_conexant.c
> > patch_realtek.c
> > patch_sigmatel.c
> > patch_via.c
> > 
> > Raw hex for AC_VERB_SET_PIN_WIDGET_CONTROL verbs:
> > patch_analog.c
> > patch_realtek.c (LOTS)
> > patch_via.c (LOTS)
> > 
> > The raw hex ones SHOULD be replaced, but the rest of them I'm not fussed either
> > way. Takashi can make a decision as to which variant is preferred, I don't mind
> > doing the cleanup.
> 
> Robin's patch is a right improvement wrt readability for whom are not
> familiar with HD-audio codec spec, so I applied it as is.

I have no problem with this so long as it hasn't broken anything.  I can't
easily test this myself until I return from LPC.

> FWIW, AC_* and PIN_* have somewhat different fields: the former is the
> definition of each bit, and the latter is the values used in the real
> world.

Thanks - that's very succintly put. :-)

Regards
  jonathan
