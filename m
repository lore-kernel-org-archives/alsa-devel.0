From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hdsp and midi problems
Date: Mon, 23 Jun 2003 18:46:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306231846200.1838-100000@pnote.perex-int.cz>
References: <s5h1xxk3ga4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xxk3ga4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Marcus Andersson <054185595@telia.com>, Mark Knecht <mknecht@controlnet.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Jun 2003, Takashi Iwai wrote:

> At Mon, 23 Jun 2003 17:53:07 +0200,
> Marcus Andersson wrote:
> > 
> > Mark Knecht wrote:
> > > 
> > > Marcus,
> > >    The HDSP 9652 MIDI interface has (for me under Linux) always dropped lots
> > > of notes. Mostly I find it interesting that it drops note off information
> > > and doesn't seem to drop note-on.
> > 
> > That is probably just a conincident depending on the read
> > pattern/processor load of your applications. Now it's just a matter of
> > convincing someone to debug it. I might even do it myself. If the ALSA
> > CVS would just compile. I have never experienced a project that cares so
> > little about code checked in being compilable. Frustrating.
> 
> hmm, i have no problem at all for compiling.  what problem do you
> have?
> 
> except for known compiler-check problem in the configure script, i've

The last issue should be fixed as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
