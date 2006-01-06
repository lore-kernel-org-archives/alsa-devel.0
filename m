From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001483]: PCM.C errors: Using modem drivers.
Date: Fri, 6 Jan 2006 16:39:05 +0100
Message-ID: <018a9ad4b5138bfc67ca9bda024c0d73@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1AFE143
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2006 16:39:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1483> 
======================================================================
Reported By:                GPLed
Assigned To:                sashak
======================================================================
Project:                    ALSA - lib
Issue ID:                   1483
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             10-18-2005 13:01 CEST
Last Modified:              01-06-2006 16:39 CET
======================================================================
Summary:                    PCM.C errors: Using modem drivers.
Description: 
snd-intel-8x0m driver. I have successfully loaded the driver and ran
slmodemd --alsa but it gives me the following output:

error: mixer setup: attach hw:1 error: No such file or directory
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM modem:1
definition (id: modem, value: cards.pcm.modem)
error: alsa setup: cannot open playback device 'modem:1': Invalid
argument
error: cannot setup device `modem:1'

Some other people also get the very same problem on FC4. Is there anything
that can be done? Please help.
======================================================================

----------------------------------------------------------------------
 sashak - 11-22-05 00:26 
----------------------------------------------------------------------
It is likely not updated configuration on FC4. Which card/driver you are
using and which version of alsa-lib?

----------------------------------------------------------------------
 sashak - 01-06-06 16:39 
----------------------------------------------------------------------
Reporter, any news with it? Does alsa-lib upgrade help?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-18-05 13:01 GPLed          New Issue                                    
11-22-05 00:24 sashak         Status                   new => assigned     
11-22-05 00:24 sashak         Assigned To               => sashak          
11-22-05 00:26 sashak         Note Added: 0006782                          
01-06-06 16:39 sashak         Note Added: 0007487                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
