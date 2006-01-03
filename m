From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001706]: Audigy 2 Value [SB0400] AC3 pass-through does not work
Date: Tue, 3 Jan 2006 22:39:44 +0100
Message-ID: <a6eac137eee8827d3b2909f2a0a3d7b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F33F7181
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2006 22:39:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1706> 
======================================================================
Reported By:                simokivimaki
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1706
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r5
======================================================================
Date Submitted:             01-03-2006 22:39 CET
Last Modified:              01-03-2006 22:39 CET
======================================================================
Summary:                    Audigy 2 Value [SB0400] AC3 pass-through does not
work
Description: 
With Audigy 2 Value [SB0400] AC3 pass-through does not work with current
emu10k1 alsa-driver.

I noticed that this is also documented to the emu10k1_main.c:
/* Audigy 2 Value AC3 out does not work yet. Need to find out how to turn
off interpolators.*/

Is there coming a fix for the problem? Please, ask for more information if
needed.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 22:39 simokivimaki   New Issue                                    
01-03-06 22:39 simokivimaki   Distribution              => Gentoo          
01-03-06 22:39 simokivimaki   Kernel Version            => 2.6.14-gentoo-r5
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
