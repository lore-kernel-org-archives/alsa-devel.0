From: Tim Goetze <tim@quitte.de>
Subject: snd_pcm_unlink -> EINVAL?
Date: Mon, 26 Jan 2004 15:40:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401261529240.562@autumn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from natsmtp00.webmailer.de (natsmtp00.rzone.de [81.169.145.165])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA12861
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2004 15:45:52 +0100
Received: from autumn (p508B94B1.dip.t-dialin.net [80.139.148.177])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i0QEjiOg015271
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2004 15:45:45 +0100 (MET)
Received: from autumn
	([127.0.0.1] helo=localhost ident=tim)
	by autumn with esmtp (Exim 3.35 #1 (Debian))
	id 1Al7uj-0000RR-00
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2004 15:40:33 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

when calling snd_pcm_unlink (stream) after an xrun occurred, it
returns EINVAL (hw: device, duplex, mmap'd IO, stop_threshold = ~0),
even though 'stream' is a valid PCM stream handle.

the snd_pcm_unlink code path seems to return EINVAL only if the stream
isn't linked to another.

but EINVAL misses the point, since the stream handle is valid.
if one tries to unlink a stream that isn't linked to another, EALREADY
is correct imo.

and my question for today: does the kernel layer unlink PCM streams
when an xrun occurs?

tim


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
