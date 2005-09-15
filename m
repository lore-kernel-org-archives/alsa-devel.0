From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001427]: Some of the hardware volume controls have incorrect ranges
Date: Thu, 15 Sep 2005 22:45:35 +0200
Message-ID: <e09906ecbb29fc3753a001b60b83bac4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4031185
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 22:45:35 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1427> 
======================================================================
Reported By:                xolsonalsa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1427
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-15-2005 22:45 CEST
Last Modified:              09-15-2005 22:45 CEST
======================================================================
Summary:                    Some of the hardware volume controls have incorrect
ranges
Description: 
line, CD, mic, and aux controls work but have incorrect volume ranges for
the hardware codec.
alsa-driver-1.0.10rc1
snd-intel8x0 driver
my hardware Asus P4SE m/b, SiS 7012 onboard card, C-Media CMI9738 codec
my kernel is redhat linux 9, 2.4.20-31.9
excerpts below are from the output of amixer command, my comments after
the ***
-----------------------------
Simple mixer control 'Master',0
Limits: Playback 0 - 31 *** (this one is correct)

Simple mixer control 'PCM',0 *** (this one is correct, no range, no
hardware volume control, mute/unmute only)

Simple mixer control 'Line',0
Limits: Playback 0 - 31 *** (incorrect, hardware only supports 0 - 15)

Simple mixer control 'CD',0
Limits: Playback 0 - 31 *** (incorrect, hardware only supports 0 - 15)

Simple mixer control 'Mic',0
Limits: Playback 0 - 31 *** (incorrect, hardware only supports 0 - 15)

Simple mixer control 'PC Speaker',0
Limits: Playback 0 - 15 *** (probably correct, haven't tested)

Simple mixer control 'Aux',0
Limits: Playback 0 - 31 *** (incorrect, hardware only supports 0 - 15)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 22:45 xolsonalsa     New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
