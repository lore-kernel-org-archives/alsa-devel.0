From: Timur Tabi <timur@freescale.com>
Subject: Playing silence instead of pausing during underrun
Date: Thu, 04 Sep 2008 10:04:32 -0500
Message-ID: <48BFF900.50002@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 86AB2243E6
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 17:04:35 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m84F4W2B025784
	for <alsa-devel@alsa-project.org>; Thu, 4 Sep 2008 08:04:33 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m84F4WmR000680
	for <alsa-devel@alsa-project.org>; Thu, 4 Sep 2008 10:04:32 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

If I understand it correctly, when ALSA detects an underrun during playback, it
throttles the driver by sending pause and resume commands.

It turns out that our hardware doesn't really like this.  We're looking at
various solutions, but one proposal would be to keep the hardware running during
a pause, but just have it play silence instead.  That is, ALSA keeps feeding
silence data during an underrun recovery.

Is there an easy way to do this in ALSA?  Is there another driver that does this?

-- 
Timur Tabi
Linux kernel developer at Freescale
