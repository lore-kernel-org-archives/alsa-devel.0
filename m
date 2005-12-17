From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001655]: Headphone jack sense and Line jack sense come up on -- need to be off for laptop speaker sound
Date: Sat, 17 Dec 2005 03:37:33 +0100
Message-ID: <ac04eebdb76c45ec6f431c84c415d0cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CB75147
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2005 03:37:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1655> 
======================================================================
Reported By:                mdmarmer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1655
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mepis, Ubuntu, Fedora FC3 (probably all)
Kernel Version:             2.6.10, 2.6.11.14, 2.6.12 (probably all)
======================================================================
Date Submitted:             12-17-2005 03:37 CET
Last Modified:              12-17-2005 03:37 CET
======================================================================
Summary:                    Headphone jack sense and Line jack sense come up on
-- need to be off for laptop speaker sound
Description: 
This problem is encountered very frequently when installing any version of
Linux on a laptop with AC'97 Intel8x0 sound.  On installation, headphone
sound will work, but the internal speakers will not.  The solution to this
problem is not apparent to the user.  Sometimes users find the answer to
this problem by posting their problem in a forum or by a diligent search. 


Current solution:

The user opens KMix or a similar interface and finds switches marked
Headphone Jack Sense and Line Jack Sense.  These switches are on, though
the jack(s) are not plugged in.  When the user turns them off and saves
the configuration, sound works fine.

This affects Toshiba M45-S331, Toshiba Tecra M3, E-Machines M5310, Gateway
M675PRR, IBM Thinkpad T40, T41, T42, R51, Compaq Presario X1000, Dell
Dimension 2400, 2350, Sony Vaio FR130 and quite a few other laptop models.
 The problem occurs regardless of the Linux diustro -- I have seen it with
Ubuntu, Mepis, and Fedora FC3.

Here are bug reports : 
http://lists.debian.org/debian-kernel/2005/04/msg00655.html

Bug#303311: 2.6.11 Kernel, intel8x0 card and Headphone Jack Sense
(http://bugs.debian.org

http://www.ces.clemson.edu/linux/alsa.shtml

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144742
===>>>>
This is the only report on alsa bugtrack, claims fixed as of 4 Feb 05 -- I
continue to see this problem regardless of alsa version
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=852

Reports (not specifically bug reports):

http://dancorkill.home.comcast.net/tecra-m3-on-fc4.html

http://ccrma-mail.stanford.edu/pipermail/planetccrma/2005-May/009305.html

http://www.mepis.org/node/6557

http://lists.debian.org/debian-laptop/2005/10/msg00203.html

http://www.mepislovers.org/modules/newbb/viewtopic.php?topic_id=11362&forum=28&post_id=79808#forumpost79808








======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-17-05 03:37 mdmarmer       New Issue                                    
12-17-05 03:37 mdmarmer       Distribution              => Mepis, Ubuntu, Fedora
FC3 (probably all)
12-17-05 03:37 mdmarmer       Kernel Version            => 2.6.10, 2.6.11.14,
2.6.12 (probably all)
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
