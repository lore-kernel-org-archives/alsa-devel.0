From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001695]: device have some options wich wrong configured or not yet aveilable
Date: Fri, 30 Dec 2005 12:32:18 +0100
Message-ID: <a412e1d841b8658e5fe108d1cb89f327@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B99D51A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 12:32:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1695> 
======================================================================
Reported By:                fishor
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1695
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.14
======================================================================
Date Submitted:             12-30-2005 12:32 CET
Last Modified:              12-30-2005 12:32 CET
======================================================================
Summary:                    device have some options wich wrong configured or
not yet aveilable
Description: 
This device have some options wich wrong configured or not yet aveilable:
SUBVENOR_ID = 1043; SUBDEVICE_ID = 8138
It's possible to cheng Headphone Playback Volume but this module provide
only
"Headphone Playback Switch"  (- 1.0.10, with wertion 1.0.11rc1 there is no
swithc at all) and mixed with "Front Playback Volume" but they must
be independ.  
It's looks like you working with multi-playback (great!!! :-) if i can
prowide
you some more information ore tests i will do it):

lex@zwerg:~/Desktop$ cat /proc/asound/pcm
00-00: ALC882 Analog : ALC882 Analog : playback 1 : capture 2
00-01: ALC882 Digital : ALC882 Digital : playback 1 : capture 1

This device must privide two Analog. , one for back Rear and one for Front
Rear.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-05 12:32 fishor         New Issue                                    
12-30-05 12:32 fishor         Kernel Version            => 2.6.14          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
