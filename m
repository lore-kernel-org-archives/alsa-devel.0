From: David Lloyd <dmlloyd@tds.net>
Subject: Re: DMIX and capture stream
Date: Mon, 5 Jan 2004 10:29:01 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401051020560.8705@tomservo.workpc.tds.net>
References: <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 4 Jan 2004, Paul Davis wrote:

> >I'm working on changing DMIX to allow clients to open the capture stream.  
> 
> i don't get it. dmix is for playback, not capture. what would be the
> semantics of this?

That is exactly the problem!  DMIX is for playback.  DSNOOP is for 
capture.  Where is the module that is for both?  Why, oh why, did they not 
simply make ONE MODULE in the first place??

The semantics would be (rather would have been) that if someone tries to
open the capture stream through the dmix plugin, it will "pass through" to
the slave.  This means that while many apps can open playback stream, only 
one would be able to open capture without blocking.

It would have been ideal to integrate dsnoop functionality, but I deemed 
that this was a bit too complicated for an initial implementation.

Of course at this point, I'm ready to forget it.  I've got too many things 
going on to justify not just buying a new sound card, much as that 
irritates me.

- D


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
