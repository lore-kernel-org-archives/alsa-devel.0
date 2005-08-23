From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001358]: 1.0.10rc1 ALSA driver doesn't have PC Speaker support in hda-intel (Uniwill)
Date: Tue, 23 Aug 2005 16:38:27 +0200
Message-ID: <3a232da199650f792cd37122e0ecb83d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 191D9255
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2005 16:38:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1358> 
======================================================================
Reported By:                quetzyg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1358
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10.1
Kernel Version:             2.6.12.5
======================================================================
Date Submitted:             08-22-2005 20:53 CEST
Last Modified:              08-23-2005 16:38 CEST
======================================================================
Summary:                    1.0.10rc1 ALSA driver doesn't have PC Speaker
support in hda-intel (Uniwill)
Description: 
My laptop is equiped with an Intel (IHC6M) integrated audio controller. The
chipset is a Realtek ALC880 with a Uniwill subsystem.

With the previous version of ALSA (1.0.9b), I had the LineIn/Speakers
mixup issue. That problem is now fixed with the 1.0.10rc1 version (and
previously with a CVS), but now the PC Speaker is muted and doesn't apear
on AlsaMixer.

I'm using ALSA 1.0.10rc1 drivers + libs + oss + utils.

Another thing! Does this sound card support multiplexing? Either by
hardware, or if ALSA can achieve that by software. I'm having trouble
playing more than one sound at the same time, and all the things I've read
until now, didn't help me :-\

If more information is needed, just let me know :-)

Cheers,
Quetzy Garcia
======================================================================

----------------------------------------------------------------------
 tiwai - 08-23-05 16:38 
----------------------------------------------------------------------
Do you mean "PC Speaker" = "internal speaker on laptop"?
The "PC Speaker" mixer controls are for beep, so it's likely unrelated.

Does the attached patch change the behavior?

About the multi-play: ALSA native apps use dmix as default, so they should
work as they are.  For OSS apps, use aoss wrapper instead.  It's not a
bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 20:53 quetzyg        New Issue                                    
08-22-05 20:53 quetzyg        Distribution              => Slackware 10.1  
08-22-05 20:53 quetzyg        Kernel Version            => 2.6.12.5        
08-23-05 00:19 quetzyg        Issue Monitored: quetzyg                     
08-23-05 16:38 tiwai          Note Added: 0005907                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
