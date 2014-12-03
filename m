From: Joe Perches <joe@perches.com>
Subject: Re: ALSA: ctxfi: Delete an unnecessary check before kfree()
Date: Wed, 03 Dec 2014 09:14:48 -0800
Message-ID: <1417626888.2902.13.camel@perches.com>
References: <5307CAA2.8060406@users.sourceforge.net>
	 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
	 <530A086E.8010901@users.sourceforge.net>
	 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	 <530A72AA.3000601@users.sourceforge.net>
	 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
	 <530B5FB6.6010207@users.sourceforge.net>
	 <alpine.DEB.2.10.1402241710370.2074@hadrien>
	 <530C5E18.1020800@users.sourceforge.net>
	 <alpine.DEB.2.10.1402251014170.2080@hadrien>
	 <530CD2C4.4050903@users.sourceforge.net>
	 <alpine.DEB.2.10.1402251840450.7035@hadrien>
	 <530CF8FF.8080600@users.sourceforge.net>
	 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
	 <530DD06F.4090703@users.sourceforge.net>
	 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
	 <5317A59D.4@users.sourceforge.net> <547E2612.6010304@users.sourceforge.net>
	 <s5hvblt6xav.wl-tiwai@suse.de> <547EF64B.1080403@users.sourceforge.net>
	 <s5h61dssy5n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h61dssy5n.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-12-03 at 13:41 +0100, Takashi Iwai wrote:
> At Wed, 03 Dec 2014 12:38:51 +0100,
> SF Markus Elfring wrote:
> > 
> > >>   Deletion of an unnecessary check before the function call "kfree"
> > >>   One function call less in get_daio_rsc() after error detection
> > > 
> > > In these cases, the changes aren't so straightforward, and they don't
> > > improve the readability.
> > 
> > How do you prefer to improve the affected source code here?
> 
> Don't touch then.  There are no bugs to fix there.

Takashi, what did you think of this?
https://lkml.org/lkml/2014/12/2/771

Just unnecessary?
