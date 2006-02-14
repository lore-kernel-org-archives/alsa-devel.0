From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH] Transparent network support through
 polypaudio
Date: Tue, 14 Feb 2006 15:35:40 +0100
Message-ID: <20060214143540.GB11753@turing.informatik.uni-halle.de>
References: <43F09D76.9060004@cendio.se>
 <20060214094741.GA8943@turing.informatik.uni-halle.de> <43F1B26E.5@cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7AC7192
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2006 15:36:07 +0100 (MET)
In-reply-to: <43F1B26E.5@cendio.se>
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
> Clemens Ladisch wrote:
> >Pierre Ossman wrote:
> Btw, mplayer seems to call snd_pcm_prepare() twice.

Not anymore.

> Not sure if that's valid behaviour.

It is.

> >When an applicatioh disables the stop_threshold, the device is supposed
> >to continue playing with the current buffer contents (which _is_ a
> >rather extreme case).
> 
> The ring buffer design is very difficult to emulate when you have a 
> simple queue. Since few (if any) application will rely on this 
> behaviour, I've decided to ignore it for now.

I don't know of any application that actually relies on this.

> >I think you may be required to use a timer for the mainloop.  What does
> >polypaudio actually do in this callback?  How often must it be called?
> 
> Primarily updates to available buffer space on the server.

Shouldn't the data be sent as early as possible, i.e., directly after
the snd_pcm_write() or snd_mmap_commit()?


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
