From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001644]: Endless Pulsing/repeating sound clip emitting from speakers
Date: Mon, 12 Dec 2005 18:56:33 +0100
Message-ID: <db960a43e11b6874f8f96ea3e3731628@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 492A7192
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2005 18:56:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1644> 
======================================================================
Reported By:                snipepod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1644
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               SUSE 10 direct from Novell
Kernel Version:             
======================================================================
Date Submitted:             12-12-2005 18:56 CET
Last Modified:              12-12-2005 18:56 CET
======================================================================
Summary:                    Endless Pulsing/repeating sound clip emitting from
speakers
Description: 
As soon as SUSE pops-up a window or dialog box that includes anytype of
sound (ding, pop, boop, etc), a small piece of the sound gets repeated
through the ES1968 sound hardware in a repeating patter (typically about
14 times per 10 seconds). This repeating sound can only be terminated by
restarting ALSA, via booting, or configurint via YAST2 (which restarts the
ALSA). 
I searched the internet and found a SUSE-RPM for ALSA 1.0.10 and installed
it, but the problem did not get fixed.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-05 18:56 snipepod       New Issue                                    
12-12-05 18:56 snipepod       Distribution              => SUSE 10 direct from
Novell
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
