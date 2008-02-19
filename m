From: Timur Tabi <timur@freescale.com>
Subject: Moving X Window windows causes audio stuttering
Date: Tue, 19 Feb 2008 12:00:04 -0600
Message-ID: <47BB1924.2050303@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id B2209103886
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 19:00:08 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m1JI05It022446
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 11:00:06 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1JI048e013182
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 12:00:05 -0600 (CST)
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

On our system, using mplayer to play a movie that has 44.1KHz audio (hardware 
only supports 48KHz) can cause audio stuttering if we're using OSS emulation, 
but not if we're using native ALSA.  Is this a known problem?  Does OSS 
emulation hog the CPU?

-- 
Timur Tabi
Linux kernel developer at Freescale
