From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [RFC] re-queuing usx2y-fw
Date: Thu, 31 Mar 2005 18:03:41 +0200
Message-ID: <m2acoj950i.fsf@vador.mandrakesoft.com>
References: <20050328155151.GA3552@tuba> <s5hfyyeijh8.wl@alsa2.suse.de>
	<20050329165816.GA2696@tuba> <s5h7jjqidv3.wl@alsa2.suse.de>
	<20050331115848.GA13462@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandrakesoft.com (134.106-14-84.ripe.coltfrance.com [84.14.106.134])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 38F2021D
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 18:03:42 +0200 (MEST)
In-Reply-To: <20050331115848.GA13462@tuba> (Martin Langer's message of "Thu,
 31 Mar 2005 13:58:48 +0200")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Langer <martin-langer@gmx.de> writes:

> > > > > The code still depends on as31 (8031/8051 crosss-assembler)
> > > > > which still isn't available as .rpm or .deb, at least newer
> > > > > versions since 2.1. Should we care about it?
> > > > 
> > > > For convenience, we may include both the firmware source and
> > > > binary in the CVS repository, so that one can install even
> > > > without as31.
> > > 
> > > Yep. I will try to introduce a new configure option like
> > > '--enable-buildfw' for it, or any similar solution.
> > 
> > That'll be nice.
> 
> Here it is. The new configure option for alsa-firmware is called
> '--enable-buildfw'. If you want to build it from source you have to
> install one of the latest versions of as31, which you can find at
> 
> http://wiki.erazor-zone.de/doku.php?id=wiki:projects:linux:as31

why not auto enabling it if we detect the non free as31 rather than
just providing such flag?



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
