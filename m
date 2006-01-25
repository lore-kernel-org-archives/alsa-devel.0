From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001781]: No digital sound output with snd-cs4236 driver and CS4237B chip.
Date: Wed, 25 Jan 2006 05:21:09 +0100
Message-ID: <46dd8323a17a5a3c69297c043c062e81@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D812316C
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 05:21:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1781> 
======================================================================
Reported By:                briand
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1781
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-25-2006 05:21 CET
Last Modified:              01-25-2006 05:21 CET
======================================================================
Summary:                    No digital sound output with snd-cs4236 driver and
CS4237B chip.
Description: 
See also:  0001748, 0001779, 0001780

Driver loads, producing no error, warning, or other messages in
/var/log/messages or in dmesg.  Audio CD plays fine, thru tinny laptop
speakers, or into headphones or external speakers.  No digital audio (wav,
au, mp3, etc) plays.

running `aplay somefile.wav` produces a file info banner:

"Playing WAVE 'tada.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo"

...but the file never actually plays, and I need to break out of the
program (Ctrl-C) to return to the prompt.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-06 05:21 briand         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
