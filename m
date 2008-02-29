From: Timur Tabi <timur@freescale.com>
Subject: Driver recovers from underrun in plain ALSA mode,
 but not in OSS emulation
Date: Fri, 29 Feb 2008 17:56:43 -0600
Message-ID: <47C89BBB.7040706@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C825103810
	for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2008 00:56:47 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m1TNui0n006618
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 16:56:44 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1TNuhTi011478
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 17:56:43 -0600 (CST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm stress-testing my sound driver using mplayer to see how it handles underrun
during jumps in CPU loads.  That is, I start playing a movie, and then I cause
the CPU to jump to 100%, and then I drop the CPU back to normal.  During the
times when the CPU is at 100%, I get underruns and other problems.  That's normal.

When I tell mplayer to use the ALSA API, my driver recovers nicely from an
underrun situation when the CPU load drops back to normal.  However, if I tell
mplayer to use the OSS API (i.e. ALSA's OSS emulation), it does not recover from
an underrun situation.  The audio and video playback remains distorted.  I need
to tell mplayer to pause and resume to get it to recover.

Is this normal for ALSA drivers?  Before I try to debug this problem the hard
way, I want to know if this could be the result of a common programming mistake
in my driver or something like similar.

(FYI, the source code for my driver is in sound/soc/fsl/)

-- 
Timur Tabi
Linux kernel developer at Freescale
