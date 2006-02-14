From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH] Transparent network support through
 polypaudio
Date: Tue, 14 Feb 2006 10:47:41 +0100
Message-ID: <20060214094741.GA8943@turing.informatik.uni-halle.de>
References: <43F09D76.9060004@cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF560194
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2006 10:48:06 +0100 (MET)
In-reply-to: <43F09D76.9060004@cendio.se>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pierre Ossman <ossman@cendio.se>
Cc: alsa-devel@alsa-project.org, mzcbylcnhqvb@0pointer.de
List-Id: alsa-devel@alsa-project.org

Pierre Ossman wrote:
> I've implemented an ALSA plugin that allows any well-behaved ALSA 
> application transparently use the Polypaudio network protocol.
> 
> It is my desire to have this included in ALSA (-lib preferably) so that 
> it will be included in most dists.

It's dependent on polypaudio, so it should better go into the
alsa-plugins package.

> Some comments on the design. Polypaudio's lib requires a decent mainloop 
> abstraction. But ALSA does not force, or even allow, applications to 
> provide one (nothing wrong with that, it keeps the API simple).

A basic assumptions is that a PCM device runs 'by itself'.

> The solution is a design borrowed from the Avahi project. A second 
> thread is started that does the poll() call. Communication with the main 
> thread is done through a socket pair, and that file descriptor is fed to 
> the application to poll.

The dmix plugin does it in a similar way.

> Since some applications do not use these in a sane manner

Nothing in the ALSA API requires applications to use poll() (or to use
blocking writes).

> (I'm looking at you mplayer)

And you're speaking with mplayer's ALSA driver maintainer.
Is there anything wrong with mplayer?  ;-)

> the mainloop abstraction is also run on most of the ALSA plugin
> callbacks.

When an applicatioh disables the stop_threshold, the device is supposed
to continue playing with the current buffer contents (which _is_ a
rather extreme case).

I think you may be required to use a timer for the mainloop.  What does
polypaudio actually do in this callback?  How often must it be called?


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
