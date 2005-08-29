From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001376]: ens1370 gameport module stupidity
Date: Mon, 29 Aug 2005 11:59:13 +0200
Message-ID: <a633c51a2acaf4b8438046eea8656bf4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3ECEC231
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2005 11:59:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1376> 
======================================================================
Reported By:                Hetfield
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1376
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-29-2005 11:59 CEST
Last Modified:              08-29-2005 11:59 CEST
======================================================================
Summary:                    ens1370 gameport module stupidity
Description: 
hi.

situation:
i have ens1370 built-in kernel and gameport too.
i have the lilo cmd line snd_ens1370.joystick=1 to enable gameport.
works perfectly.

the problem is if i add gameport as module.
the gameport command fails, and i can't use gameport.
this can be even normal..but the problem is i can't no more enable
gameport on audio card.

i checked the /sys and /proc fs to check a settable value. no luck
this forces gameport to be a module, only if snd is module (i can pass
values via modprobe)
and forces to be built-in if snd is built-in.

can be gameport init added via proc/sys or a specific alsa tool?

Thanks




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-29-05 11:59 Hetfield       New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
