From: Paul Davis <pbd@op.net>
Subject: Re: playing samples in parallel
Date: Mon, 25 Feb 2002 18:28:54 -0500
Message-ID: <200202252329.SAA18935@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA06122
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2002 00:29:53 +0100
In-reply-to: Your message of "Tue, 26 Feb 2002 00:59:17 +0100."
             <200202252359.g1PNxH004293@schleim.qwe.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Torsten Mohr <tmohr@s.netic.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>i don't know, is my question off-topic?

its more of a general audio programming question than something ALSA
specific. 

>Where can i get some help?
>Would it help to mail the sources?
>Is it an obvious mistake i make?
>I really tried to describe the problem in detail, are there
>any important points missing?

i couldn't even really get my head around your problem description,
because it takes such a fundamentally different approach to even
describing what you're trying to do.

if all you want to do is to play two samples at the same time, then

   system ("aplay -D some_share_PCM_device some_sample_file &");

should be enough. presumably you have more exacting needs than this,
and/or have discovered that the share device does not work.

typically programs that have multiple independent audio streams that
need to be heard simultaneously mix them internally before delivering
them to the audio API. in your case, you'd probably have a buffer that
was zero-filled most of the time, and when you wanted to play samples,
you'd additively store them in that buffer. then you just repeatedly
deliver the buffer to ALSA over and over and over. when there is data
in it, you'll hear it, when there isn't, you'll have silence.

with some audio hardware, you can open the device multiple times with
no effort. however, this is not a portable approach since most
hardware does not allow this.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
