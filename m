From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001341]: No volume control
Date: Thu, 18 Aug 2005 18:12:33 +0200
Message-ID: <fddf2387f26d5192c0af3a3e0eb6f157@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA9B01B8
	for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2005 18:12:33 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1341> 
======================================================================
Reported By:                chui101
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1341
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Arch
Kernel Version:             2.6.12-ARCH
======================================================================
Date Submitted:             08-16-2005 12:51 CEST
Last Modified:              08-18-2005 18:12 CEST
======================================================================
Summary:                    No volume control
Description: 
Initially, there was no sound, but to enable sound output the "IEC958
Capture Monitor" switch must be turned off.

Once there is sound, there is no way to control the volume. All the volume
sliders in the playback tab of the GNOME Volume Control are functionless.
PCM appears as a switch, perhaps it should be a slider?
======================================================================

----------------------------------------------------------------------
 chui101 - 08-16-05 12:54 
----------------------------------------------------------------------
The IEC958 switch only appears to affect sound streamed through OSS.

----------------------------------------------------------------------
 chui101 - 08-18-05 18:12 
----------------------------------------------------------------------
actually, i have no idea what the iec958 is doing anymore, it doesn't seem
to affect the mixer anymore. however, master slider still doesn't affect
volume.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-16-05 12:51 chui101        New Issue                                    
08-16-05 12:51 chui101        Distribution              => Arch            
08-16-05 12:51 chui101        Kernel Version            => 2.6.12-ARCH     
08-16-05 12:54 chui101        Note Added: 0005827                          
08-16-05 12:58 chui101        Issue Monitored: chui101                     
08-18-05 18:12 chui101        Note Added: 0005849                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
