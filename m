From: Timur Tabi <timur@freescale.com>
Subject: Will ALSA ever call _prepare or _hw_params while it's
	playing?
Date: Wed, 21 May 2008 10:45:14 -0500
Message-ID: <4834438A.4060702@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 907A42437A
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 17:45:19 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4LFjEPR018490
	for <alsa-devel@alsa-project.org>; Wed, 21 May 2008 08:45:15 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4LFjE97027636
	for <alsa-devel@alsa-project.org>; Wed, 21 May 2008 10:45:14 -0500 (CDT)
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

I have an ASoC driver with a _hw_params, _prepare, and _trigger functions.  I've
recently discovered that I need to keep one of my devices disabled until
playback starts.

So I would like to know if ALSA will ever call _hw_params, _prepare, or _startup
if playback or capture is currently in process, or will ALSA first call the
_trigger to stop/pause the driver.

If ALSA does stop/pause the driver before changing parameters, then I can safely
assume the device is always disabled during those functions.

-- 
Timur Tabi
Linux kernel developer at Freescale
