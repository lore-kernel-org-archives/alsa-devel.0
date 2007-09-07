From: Timur Tabi <timur@freescale.com>
Subject: Why is ALSA sending STOP/START commands to my driver
	during MP3 playback?
Date: Fri, 07 Sep 2007 10:09:38 -0500
Message-ID: <46E169B2.3010509@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 789C42444A
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 17:09:43 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l87F9dgp011818
	for <alsa-devel@alsa-project.org>; Fri, 7 Sep 2007 08:09:40 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l87F9cMQ008866
	for <alsa-devel@alsa-project.org>; Fri, 7 Sep 2007 10:09:39 -0500 (CDT)
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

I'm developing an ASoC driver, and when I play an MP3 with mpg123, my driver's 
trigger() function is called with the SNDRV_PCM_TRIGGER_STOP command and then 
is immediately called again with SNDRV_PCM_TRIGGER_START.

Can someone tell me why ALSA would do this?

This only happens when playing an MP3.  When I use aplay to play a regular 
Wave file, I don't see this behavior.

My driver does not have the SNDRV_PCM_INFO_PAUSE bit set, because I haven't 
gotten around to testing that capability.  I suspect that if I did have that 
bit set, I would be getting SNDRV_PCM_TRIGGER_PAUSE_PUSH and 
SNDRV_PCM_TRIGGER_PAUSE_RELEASE calls instead.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
