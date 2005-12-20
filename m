From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001429]: hda_codec: Unknown model for ALC880
Date: Tue, 20 Dec 2005 01:08:16 +0100
Message-ID: <77d238ecc77439fe2d34299d9068b3ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF43019C
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 01:08:16 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1429> 
======================================================================
Reported By:                crimsunkg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1429
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.12-8-686
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-17-2005 00:54 CEST
Last Modified:              12-20-2005 01:08 CET
======================================================================
Summary:                    hda_codec: Unknown model for ALC880
Description: 
Please refer to http://bugzilla.ubuntu.com/show_bug.cgi?id=15031

Using ALSA shipped with kernel 2.6.12 (~1.0.9+cvs), a kernel OOPS occurs.

Using ALSA 1.0.10rc1 and cvs (with alsa-lib 1.0.9), no OOPS occurs, but
hda_codec does not recognize the model with the ALC880 codec
(http://bugzilla.ubuntu.com/attachment.cgi?id=3808).

''lspci -nvv'' output is at
http://bugzilla.ubuntu.com/attachment.cgi?id=3848
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001453 2.6.14-rc2 &quot;Unknown model for ALC8...
has duplicate       0001316 can't run mixer to adjusting volumes / ...
has duplicate       0001460 no sound on Clevo 400a
======================================================================

----------------------------------------------------------------------
 crimsunkg - 09-24-05 20:55 
----------------------------------------------------------------------
This issue is duplicated in bug #1453.

----------------------------------------------------------------------
 rlrevell - 11-23-05 20:30 
----------------------------------------------------------------------
Possibly fixed in CVS.  See the patch from bug #1563.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-17-05 00:54 crimsunkg      New Issue                                    
09-17-05 00:54 crimsunkg      Distribution              => Ubuntu Breezy   
09-17-05 00:54 crimsunkg      Kernel Version            => 2.6.12-8-686    
09-24-05 20:55 crimsunkg      Note Added: 0006377                          
09-24-05 22:06 rlrevell       Relationship added       has duplicate 0001453
09-26-05 19:14 rlrevell       Relationship added       has duplicate 0001316
09-26-05 19:14 rlrevell       Relationship added       has duplicate 0001460
11-23-05 20:30 rlrevell       Note Added: 0006827                          
12-20-05 01:08 rlrevell       Status                   assigned => resolved
12-20-05 01:08 rlrevell       Resolution               open => fixed       
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
