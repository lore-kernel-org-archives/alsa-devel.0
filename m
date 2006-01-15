From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001752]: Skippy sound when system is under load
Date: Sun, 15 Jan 2006 15:47:17 +0100
Message-ID: <56dfb1dd61482e684fc1c94601657f82@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CFA9A12B
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 15:47:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1752> 
======================================================================
Reported By:                wshtb
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1752
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-15-2006 15:46 CET
Last Modified:              01-15-2006 15:47 CET
======================================================================
Summary:                    Skippy sound when system is under load
Description: 
Ever since upgrade to kernel 2.6.14 and up, I have noticed that during
audio playback, whenever my system is under load, the sound becomes
skippy. By under load I mean for example, use firefox browser, or a image
viewer or any program that use lots of CPU.

The problem looks like the mp3 decoder doesn't have a high enough
priority. But how comes it never happen in kernel 2.6.13. In 2.6.13 even
if I push the CPU to 100%, the music player still manage to get enough CPU
cycle to keep a smooth playback.

My system has a 800Mhz P-III CPU and 640MB memory. Do you think this is a
sound driver issue?
======================================================================

----------------------------------------------------------------------
 wshtb - 01-15-06 15:47 
----------------------------------------------------------------------
Sorry I forgot to mention I'm using Audigy 2 NX in USB 1.1 mode.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-06 15:46 wshtb          New Issue                                    
01-15-06 15:46 wshtb          Kernel Version            => 2.6.15          
01-15-06 15:47 wshtb          Note Added: 0007666                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
