From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001672]: openal not working
Date: Thu, 22 Dec 2005 03:13:47 +0100
Message-ID: <8dcae387b58fbea6937f028203053866@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F2EA2199
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 03:13:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1672> 
======================================================================
Reported By:                ilikejam
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1672
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.14.x (hand rolled)
======================================================================
Date Submitted:             12-22-2005 03:13 CET
Last Modified:              12-22-2005 03:13 CET
======================================================================
Summary:                    openal not working
Description: 
The version of ALSA in the latest (2.6.14) kernel doesn't output sound from
openal. There are no errors (from Unreal Tournament 2004, and from the
openal-test utilities in the fedora openal-test package), but no sound is
output.

Rolling back the kernel to 2.6.11 solves the problem - sound works fine
with that kernel version.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 03:13 ilikejam       New Issue                                    
12-22-05 03:13 ilikejam       Distribution              => Fedora Core 4   
12-22-05 03:13 ilikejam       Kernel Version            => 2.6.14.x (hand
rolled)
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
