From: Marcus Hall <mhall@coraccess.com>
Subject: Re: Odd contents of .cvsignore files
Date: Fri, 10 Dec 2004 13:58:45 -0700
Message-ID: <20041210205845.GB11880@splunge.coraccess.com>
References: <41B9E30B.3080109@coraccess.com> <s5h4qiu822b.wl@alsa2.suse.de>
Reply-To: mhall@coraccess.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4qiu822b.wl@alsa2.suse.de>
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

On Fri, Dec 10, 2004 at 07:01:48PM +0100, Takashi Iwai wrote:
> At Fri, 10 Dec 2004 10:55:23 -0700,
> Marcus Hall wrote:
> > 
> > I was working with the 1.0.7 release and noticed that some files were
> > listed in .cvsignore that I found surprising:
> > 
> > 	acinclude.m4
> > 	acore/pcm_lib.c
> > 	alsa-kernel
> > 	include/config1.h.in
> > 	include/linux
> > 	toplevel.config.in
> > 
> > were all listed there.  Is this intentional?
> 
> Yes.  They are all dynamically created files.
> 
> 
> Takashi

That's what I considered at first, but I couldn't find where they were
generated from.  Of course toplevel.config.in => toplevel.config and
such, but I didn't see where they otherwise came from.  I also note
that these (and other, clearly derived files) *are* checked into
the alsa CVS.

Marcus Hall
CorAccess Systems


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
