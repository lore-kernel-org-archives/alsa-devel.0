From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_wait()  More details required.
Date: Mon, 22 Mar 2004 11:10:40 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403221047040.4794-100000@studcom.urz.uni-halle.de>
References: <405DAB5C.5010106@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA31299
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 11:10:45 +0100
In-reply-to: <405DAB5C.5010106@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I need more details on exactly what snd_pcm_wait() is supposed to do.
> The documentation on the www.alsa-project.org gives: -
> Wait for a PCM to become ready.
> ...
> So, when is a PCM ready?

When you can read/write some data without blocking, i.e.,
avail >= avail_min.

> I have discovered a problem with xine when using it. I have done a work
> around in xine so that dmix now works in xine. I think that my
> assumptions regarding snd_pcm_wait() might have been wrong, so I want to
> get accurate details from yourselves.

I think the implementation of dmix is broken in this regard.  If I
read the code correctly, snd_pcm_direct_poll_revents() returns
POLLIN/OUT even if the pcm is empty.

Jaroslav, shouldn't this function reset the events variable when empty
is set?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
