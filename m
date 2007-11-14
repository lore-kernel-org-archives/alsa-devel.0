From: Timur Tabi <timur@freescale.com>
Subject: Is there a function I can call from my ISR to tell
 ALSA to abort playback?
Date: Wed, 14 Nov 2007 14:41:39 -0600
Message-ID: <473B5D83.2020408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id F1278103817
	for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2007 09:29:23 +0100 (CET)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lAEKfeco026997
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 13:44:02 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAEKfdeD011769
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 14:41:40 -0600 (CST)
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

In my ISR, I call snd_pcm_period_elapsed() to tell it that a period has elapsed. 
  I can also detect if playback has aborted for some reason (e.g. DMA controller 
has died).  Is there a function I can call in my ISR to tell ALSA to abort 
playback or capture?

-- 
Timur Tabi
Linux kernel developer at Freescale
