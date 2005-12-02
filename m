From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001602]: No OSS emulation on second PCM device
Date: Fri, 2 Dec 2005 14:50:50 +0100
Message-ID: <4631f8e06e38132bc862f2702702b220@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 933F716A
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2005 14:50:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1602> 
======================================================================
Reported By:                Arca
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1602
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-26-2005 20:25 CET
Last Modified:              12-02-2005 14:50 CET
======================================================================
Summary:                    No OSS emulation on second PCM device
Description: 
/proc/asound/card0/pcm2p exists, but /proc/asound/card0/pcm2p/oss does not.
This is necessary to use this device for Enemy Territory among other
programs I require to use that need playback devices of their own.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-02-05 14:50 
----------------------------------------------------------------------
It's a feature.  OSS can have at most two PCM devices per card, /dev/dsp*
and /dev/adsp*.
You can reassign the PCM devices via dsp_map option of snd-pcm-oss module.
 See OSS-Emulation.txt.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-26-05 20:25 Arca           New Issue                                    
12-02-05 14:50 tiwai          Status                   new => resolved     
12-02-05 14:50 tiwai          Resolution               open => not an issue
12-02-05 14:50 tiwai          Assigned To               => tiwai           
12-02-05 14:50 tiwai          Note Added: 0006894                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
