From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [RFC] re-queuing usx2y-fw
Date: Fri, 1 Apr 2005 12:33:48 +0200
Message-ID: <20050401103348.GB7037@tuba>
References: <20050328155151.GA3552@tuba> <s5hfyyeijh8.wl@alsa2.suse.de> <20050329165816.GA2696@tuba> <s5h7jjqidv3.wl@alsa2.suse.de> <20050331115848.GA13462@tuba> <m2acoj950i.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 8C6EB213
	for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2005 12:33:05 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <m2acoj950i.fsf@vador.mandrakesoft.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 31, 2005 at 06:03:41PM +0200, Thierry Vignaud wrote:
> Martin Langer <martin-langer@gmx.de> writes:
> 
> > > > > > The code still depends on as31 (8031/8051 crosss-assembler)
> > > > > > which still isn't available as .rpm or .deb, at least newer
> > > > > > versions since 2.1. Should we care about it?
> > > > > 
> > > > > For convenience, we may include both the firmware source and
> > > > > binary in the CVS repository, so that one can install even
> > > > > without as31.
> > > > 
> > > > Yep. I will try to introduce a new configure option like
> > > > '--enable-buildfw' for it, or any similar solution.
> > > 
> > > That'll be nice.
> > 
> > Here it is. The new configure option for alsa-firmware is called
> > '--enable-buildfw'. If you want to build it from source you have to
> > install one of the latest versions of as31, which you can find at
> > 
> > http://wiki.erazor-zone.de/doku.php?id=wiki:projects:linux:as31
> 
> why not auto enabling it if we detect the non free as31 rather than
> just providing such flag?
> 

BSD license is non free?

Is it really necessary to build it by default? I see a lot of trouble at 
the horizon due to version mismatches of as31. An as31 version check 
could solve it, though.

martin


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
