From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001631]: Audiophile USB will not capture.
Date: Thu, 8 Dec 2005 17:38:01 +0100
Message-ID: <2cc37f71bff4e78596f7a295fbe04cf6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22AF5173
	for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2005 17:38:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1631> 
======================================================================
Reported By:                smithbone
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1631
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               1.0.10
Kernel Version:             2.6.15-rc5-git1
======================================================================
Date Submitted:             12-08-2005 17:38 CET
Last Modified:              12-08-2005 17:38 CET
======================================================================
Summary:                    Audiophile USB will not capture.
Description: 
If I try to capure audio from my Audiophile USB I get the following.

 $ arecord -vv -D hw:1,1 -f S24_3BE -t raw -c 2 -r48000 test.raw
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S24_3BE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 24
buffer_size  : 24000
period_size  : 6000
period_time  : 125000
tick_time    : 4000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 1
stop_threshold   : 24000
silence_threshold: 0
silence_size : 0
boundary     : 1572864000
arecord: pcm_read:1303: read error: Input/output error
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-08-05 17:38 smithbone      New Issue                                    
12-08-05 17:38 smithbone      Distribution              => 1.0.10          
12-08-05 17:38 smithbone      Kernel Version            => 2.6.15-rc5-git1 
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
