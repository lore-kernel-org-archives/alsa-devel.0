From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001341]: No volume control
Date: Fri, 26 Aug 2005 14:49:59 +0200
Message-ID: <d57348cad64ce2d71fcd686ff401d2f9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF614175
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 14:49:59 +0200 (MEST)
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
Last Modified:              08-26-2005 14:49 CEST
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
 rlrevell - 08-19-05 02:35 
----------------------------------------------------------------------
Try the uploaded patch.  You can apply it (as root of course) against your
existing /usr/share/alsa/cards/ATIIXP.conf, no need to recompile or
reinstall anything, just restart the affected app(s).

----------------------------------------------------------------------
 tiwai - 08-26-05 14:49 
----------------------------------------------------------------------
First show the contents of /proc/asound/card0/codec97#0/* files.
If it's a C-Media codec, it really has no PCM/Master volume controls.
The solution with softvol as Lee proposed is the only way to go.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-16-05 12:51 chui101        New Issue                                    
08-16-05 12:51 chui101        Distribution              => Arch            
08-16-05 12:51 chui101        Kernel Version            => 2.6.12-ARCH     
08-16-05 12:54 chui101        Note Added: 0005827                          
08-16-05 12:58 chui101        Issue Monitored: chui101                     
08-18-05 18:12 chui101        Note Added: 0005849                          
08-19-05 02:33 rlrevell       File Added: atiixp-softvol.patch                  
 
08-19-05 02:35 rlrevell       Note Added: 0005862                          
08-26-05 14:49 tiwai          Note Added: 0005950                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
