From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001607]: SB Audigy 2 ZS Video Editor doesn't work with other sample rates than 48000 and 96000
Date: Fri, 13 Jan 2006 19:04:45 +0100
Message-ID: <186409f019bf6ebde9902dadbbf382bd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EFE7012B
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 19:04:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1607> 
======================================================================
Reported By:                dvalin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1607
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Mandriva Linux (cooker)
Kernel Version:             2.6.14.3 (vanilla)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-30-2005 16:44 CET
Last Modified:              01-13-2006 19:04 CET
======================================================================
Summary:                    SB Audigy 2 ZS Video Editor doesn't work with other
sample rates than 48000 and 96000
Description: 
This seems to be same bug as 1050 which seems to be resolved for Audigy 2
NX, unfortunately this bug seems to still exist for the SB Audigy 2 ZS
Video Editor (note: SB Audigy2 ZS Video Editor is a usb2 card, it's NOT
the SB Audigy2 ZS pcmcia card).

Also when changing sample rate to 48000 or 96000 the sound chops every now
and then.
======================================================================

----------------------------------------------------------------------
 dvalin - 01-13-06 17:08 
----------------------------------------------------------------------
here ya go :)

----------------------------------------------------------------------
 Clemens Ladisch - 01-13-06 19:04 
----------------------------------------------------------------------
Thank you.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-30-05 16:44 dvalin         New Issue                                    
11-30-05 16:44 dvalin         Distribution              => Mandriva Linux
(cooker)
11-30-05 16:44 dvalin         Kernel Version            => 2.6.14.3 (vanilla)
11-30-05 17:07 dvalin         Note Added: 0006877                          
11-30-05 17:07 dvalin         Note Deleted: 0006877                        
11-30-05 17:07 dvalin         File Added:
alsa-driver-1.0.10-audigy2-nz-force-samplerate.patch                    
11-30-05 17:08 dvalin         Note Added: 0006878                          
11-30-05 17:09 dvalin         Note Edited: 0006878                         
11-30-05 17:22 dvalin         Note Edited: 0006878                         
12-01-05 03:13 dvalin         Note Added: 0006882                          
12-01-05 16:58 Clemens LadischNote Added: 0006886                          
12-01-05 18:15 dvalin         Note Added: 0006887                          
12-06-05 07:36 dvalin         Note Added: 0006920                          
12-11-05 19:05 dvalin         Note Added: 0006977                          
12-11-05 20:20 rlrevell       Note Added: 0006979                          
12-11-05 22:34 dvalin         Note Added: 0006980                          
01-05-06 19:12 dvalin         Note Added: 0007472                          
01-13-06 09:12 Clemens LadischNote Added: 0007633                          
01-13-06 17:07 dvalin         File Added: lsusb-audigy.txt                    
01-13-06 17:08 dvalin         Note Added: 0007643                          
01-13-06 19:04 Clemens LadischStatus                   assigned => resolved
01-13-06 19:04 Clemens LadischResolution               open => fixed       
01-13-06 19:04 Clemens LadischNote Added: 0007649                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
