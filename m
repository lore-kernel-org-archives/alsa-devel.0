From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000301]: No sound though everything looks fine
Date: Fri, 30 Dec 2005 04:40:45 +0100
Message-ID: <267d4e4c3c3e17fc10d01eb6dba54173@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 093281A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:40:46 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=301> 
======================================================================
Reported By:                kevkim55
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   301
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.22-14
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-24-2004 13:05 CEST
Last Modified:              12-30-2005 04:40 CET
======================================================================
Summary:                    No sound though everything looks fine
Description: 
I installed Mandrake Linux 9.2 on my BenQ JoyBook 3000 Laptop. The setup
program detected the soundcard correctly as ALi M5455 with AC'97 codecs
and installed the intel8x0 as the driver. The settings are allright, the
driver and other sound core modules load properly without any problem and
at boot time I can see the lines 
 * Loading intel8x0 sound module ..
 * Using alsactl to restore mixer settings..
 * Loading mixer settings ...
 The output of dmesg looks fine with absolutely no errrors. I set all of
the mixer settings at 100% and unmuted by using amix/alsamixer. The
utilities like Kaboodle, mpeg123 etc play without complaining, BUT THERE'S
NO SOUND. 
 I just don't understand what's wrong with my settings as everything seems
allright. The output of asound files in /proc directory shows the
settings, which seem allright to me, except the out put pcm0C0D1c and
pcm0C0D1p, which out -> :closed
  Catting sound files to pcm0C0D0c and pcm0C0D0p or to /dev/dsp,
/dev/audio result in nothing as the I hear no sound nor I get the command
prompt back, Ihave to hit Ctrl-C to terminate 'cat'. When I try the same
thing with pcm0C0D1c and pcm0C0D1p I get an error message like invalid
operation.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 16:07 
----------------------------------------------------------------------
Please send the output of

   lsmod
   uname -a
   lspci
   cat /proc/asound/version
   cat /proc/asound/cards

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:40 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-04 13:05 kevkim55       New Issue                                    
05-24-04 13:05 kevkim55       Kernel Version            => 2.4.22-14       
03-23-05 16:07 jdthood        Note Added: 0004174                          
12-30-05 04:40 rlrevell       Status                   new => closed       
12-30-05 04:40 rlrevell       Note Added: 0007217                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
