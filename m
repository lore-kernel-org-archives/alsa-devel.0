From: Timur Tabi <timur@freescale.com>
Subject: How does ALSA detect underrun in OSS emulation?
Date: Mon, 25 Feb 2008 09:22:41 -0600
Message-ID: <47C2DD41.9070408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 5912C2417B
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 16:22:45 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m1PFMfp5006678
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 08:22:42 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1PFMf2x028523
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 09:22:41 -0600 (CST)
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

Can someone explain to me the exact method that ALSA uses to detect underrun 
with OSS emulation?  I have a driver that reports underrun on almost every 
period when I use OSS emulation and I'm playing with a non-supported sample 
rate.  So I'm assuming that maybe my hardware is playing the audio too fast or 
too slow, and the driver is returning periods before ALSA expects them.  What I 
don't understand is: how does ALSA know that a period was finished too early. 
Does it use a timer, or is it purely application driven?

-- 
Timur Tabi
Linux kernel developer at Freescale
