From: Michael Collard <quadfour@iinet.net.au>
Subject: Re: snd-ioctl32 and hard lockups
Date: Thu, 09 Dec 2004 08:51:33 +0800
Message-ID: <1102553493.1459.0.camel@natalie>
References: <1102515405.28595.7.camel@natalie>
	 <s5hy8g8akif.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8g8akif.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-12-08 at 16:15 +0100, Takashi Iwai wrote:
> At Wed, 08 Dec 2004 22:16:45 +0800,
> Michael Collard wrote:
> > 
> > After modprobing the snd-ioctl32 module from Alsa 1.0.7, then next
> > attempt to play _any_ audio causes the machine to hard lock, not even
> > the SysRq commands do anything. I've had no luck with a response form
> > alsa-users or #alsa on freenode, hence emailing the devel list.
> > 
> > 1.0.7 compiled, not from kernel.
> > Custom x86_64 2.6.8.1 kernel
> > Vibra16 card (es1371 driver)
> > 
> > Alsa sound works quite OK in every other respect. Any hints on how to
> > diagnose/fix the problem appreciated.
> 
> Try the CVS version.  The ioctl32 wrapper was rewritten in large
> parts.

Thank you, the CVS version functions correctly :)

Wish I'd done that before.

Regards
Michael Collard




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
