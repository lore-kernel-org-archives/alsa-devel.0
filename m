From: Timur Tabi <timur@freescale.com>
Subject: How do I use SNDRV_PCM_INFO_JOINT_DUPLEX?
Date: Tue, 18 Dec 2007 13:50:42 -0600
Message-ID: <47682492.7050500@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DE92010380F
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 20:50:52 +0100 (CET)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lBIJohsc016206
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 12:50:43 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lBIJogcn027753
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 13:50:42 -0600 (CST)
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

I'm working on an ASoC driver.  I have a limitation in my hardware that if I 
have an active substream, I cannot re-program the hardware registers that 
control the sample size.

This means, for example, if I'm playing 16-bit audio, and I want to start 
capture, I cannot program the sample size into the hardware.  My only choice is 
to have already programmed the capture sample size *before* I started playback.

The easiest way to implement this is to make sure that the second stream has the 
same sample size as the first.  That way, I won't need to reprogram the 
registers, because they'll already be programmed correctly.

I discovered the SNDRV_PCM_INFO_JOINT_DUPLEX option, but I can't figure out how 
to use it.  I know it needs to be set in my snd_pcm_hardware.info, but then 
what?  How do I tell ALSA that the "joint" part is just that the sample sizes 
must be the same?

-- 
Timur Tabi
Linux kernel developer at Freescale
