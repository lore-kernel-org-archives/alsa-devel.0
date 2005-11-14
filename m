From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001549]: Any chance for SPDIF support soon with the ALC880?
Date: Mon, 14 Nov 2005 11:07:50 +0100
Message-ID: <d98ae00ab9401668cf91553069627685@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 000EA1A0
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 11:07:50 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1549> 
======================================================================
Reported By:                dvlierop
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1549
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-12-2005 11:05 CET
Last Modified:              11-14-2005 11:07 CET
======================================================================
Summary:                    Any chance for SPDIF support soon with the ALC880?
Description: 
On my Shuttle ST20G5 I don't get any digital output at all so I guess It's
not supported. Any outlook for SPDIF support? (or is it already included
and is something wrong with my system?)

Specs: Shuttle ST20G5 barebone with Realtek ALC880, AMD Athlon 64 3000+
======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 11:07 
----------------------------------------------------------------------
SPDIF is supported with ALC880. Try these options for snd-hda-codec
module:

model="5stack-digout"
model="3stack-digout"

Please, report also contents from /proc/asound/card0/codec#0 file.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 11:05 dvlierop       New Issue                                    
11-14-05 11:07 perex          Note Added: 0006715                          
11-14-05 11:07 perex          Assigned To              tiwai => perex      
11-14-05 11:07 perex          Status                   assigned => feedback
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
