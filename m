From: Paul Davis <pbd@op.net>
Subject: h-dsp news
Date: Thu, 9 May 2002 19:31:10 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205092331.g49NVA901580@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA04505
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 01:30:49 +0200
Received: from op.net (maxtnt06-52.phlpa.fast.net [209.92.102.52])
	by post2.fast.net (8.11.2/8.9.3) with ESMTP id g49NUd922782
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 19:30:39 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

i'm happy to report that the Hammerfall DSP driver is now
operational. it appears that a full power cycle was needed to clear
some wierd state i had induced in the hardware that stopped audio i/o
and midi i/o from working. i was quite amazed when i had to reboot for
a different reason (external hardware reconfiguration), and all of
sudden the audio loop i've been piping into the h-dsp for 2 days
showed up on the monitors!

i need to tidy up the MIDI handling, add the 64 bit RMS meter r/o
"controls", and possibly a control for ADAT Sync/timecode, and then
i'll submit it to Jaroslav.

its a great day! i'm not going to spoil it by trying to do these right
now :)

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
