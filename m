From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001876]: I/O hang during MIDI file sequencing on EMU10K1
Date: Sat, 25 Feb 2006 07:16:50 +0100
Message-ID: <74ce582ae16cf34d2cd1cd818e177b7a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A742B1D5
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2006 07:16:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1876> 
======================================================================
Reported By:                phorn
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1876
Category:                   CORE - sequencer
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian testing (etch)
Kernel Version:             2.6.15 - custom built
======================================================================
Date Submitted:             02-25-2006 07:07 CET
Last Modified:              02-25-2006 07:16 CET
======================================================================
Summary:                    I/O hang during MIDI file sequencing on EMU10K1
Description: 
When playing a MIDI file, at certain points in the file, the operating
system will hang (leaving notes constantly on in the background).  X.org
will basically completely freeze within a few seconds of the crash.

I have a Sound Blaster Live (emu10k1) and I use the MIDI driver included. 
I have not had a single sound or midi-related crash in kernel versions
prior to 2.6.15, so the bug must be new.

Also note that I have the two-line patch from
http://bugzilla.kernel.org/show_bug.cgi?id=5850
in order to fix a gameport-related crash in 2.6.15.
======================================================================

----------------------------------------------------------------------
 phorn - 02-25-06 07:16 
----------------------------------------------------------------------
May be related to bug 1860, though in the last kernel I used (2.6.12.3) and
lower versions I did not ever experience a sound-related crash.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-25-06 07:07 phorn          New Issue                                    
02-25-06 07:07 phorn          File Added: system-info-2.6.15.tgz                
   
02-25-06 07:07 phorn          Distribution              => Debian testing (etch)
02-25-06 07:07 phorn          Kernel Version            => 2.6.15 - custom built
02-25-06 07:16 phorn          Note Added: 0008184                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
