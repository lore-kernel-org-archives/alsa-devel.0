From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001345]: microphone input does broken after upgrading from kernel 2.6.10 to 2.6.12
Date: Tue, 23 Aug 2005 16:50:12 +0200
Message-ID: <755dbbf0093966473806fcef7665acca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2D560261
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2005 16:50:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1345> 
======================================================================
Reported By:                kayosiii
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1345
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mepis
Kernel Version:             2.6.12 custom compiled
======================================================================
Date Submitted:             08-17-2005 08:13 CEST
Last Modified:              08-23-2005 16:50 CEST
======================================================================
Summary:                    microphone input does broken after upgrading from
kernel 2.6.10 to 2.6.12
Description: 
Basically When a boot using kernel 2.6.10 I can record using a microphone.
With 2.6.12 I get no input... I am running the latest alsa-base in debian
unstable. And have tried just about every setting in kmixer
======================================================================

----------------------------------------------------------------------
 tiwai - 08-23-05 16:50 
----------------------------------------------------------------------
Upload the contents of /etc/asound.state and /proc/asound/card0/codec97#0/*
files for debugging.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-05 08:13 kayosiii       New Issue                                    
08-17-05 08:13 kayosiii       Distribution              => Mepis           
08-17-05 08:13 kayosiii       Kernel Version            => 2.6.12 custom
compiled
08-22-05 12:20 perex          Assigned To              perex =>            
08-22-05 12:20 perex          Status                   assigned => new     
08-22-05 12:20 perex          Category                 0_compilation problem_!!!
=> PCI - intel8x0
08-23-05 16:50 tiwai          Note Added: 0005910                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
