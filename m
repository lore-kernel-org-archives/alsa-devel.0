From: Timur Tabi <timur@freescale.com>
Subject: Any issues with GETOSPACE OSS ioctl?
Date: Wed, 05 Nov 2008 09:41:16 -0600
Message-ID: <4911BE9C.8010607@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A88F010382F
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 16:41:20 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mA5FfHaj025520
	for <alsa-devel@alsa-project.org>; Wed, 5 Nov 2008 08:41:18 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mA5FfGWg003966
	for <alsa-devel@alsa-project.org>; Wed, 5 Nov 2008 09:41:17 -0600 (CST)
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

I have a customer who reports that when his OSS application makes several
write() followed by SNDCTL_DSP_GETOSPACE, the returned value is not decreasing,
which implies that the write() commands are not going through.

I've looked at the OSS documentation for this ioctl
(http://manuals.opensound.com/developer/SNDCTL_DSP_GETOSPACE.html), and it
implies that it is not reliable.  But since the customer is using ALSA (i.e.
ALSA's OSS emulation), I don't know if that applies.

So I'd like to know how the 'bytes' return value is calculate in ALSA.

-- 
Timur Tabi
Linux kernel developer at Freescale
