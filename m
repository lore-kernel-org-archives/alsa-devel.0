From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001607]: SB Audigy 2 ZS Video Editor doesn't work with other sample rates than 48000 and 96000
Date: Tue, 6 Dec 2005 07:36:11 +0100
Message-ID: <779ab9ff44916a0f01d3baa896cdcebd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 29307174
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 07:36:11 +0100 (MET)
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
Status:                     assigned
Distribution:               Mandriva Linux (cooker)
Kernel Version:             2.6.14.3 (vanilla)
======================================================================
Date Submitted:             11-30-2005 16:44 CET
Last Modified:              12-06-2005 07:36 CET
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
 dvalin - 12-01-05 18:15 
----------------------------------------------------------------------
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 004: ID 041e:3070 Creative Technology, Ltd
Bus 001 Device 003: ID 041e:3061 Creative Technology, Ltd
Bus 001 Device 002: ID 041e:3050 Creative Technology, Ltd
Bus 001 Device 001: ID 0000:0000

Here ya go, as implied by the patch, 041e:3061 is the dsp device&#248;

----------------------------------------------------------------------
 dvalin - 12-06-05 07:36 
----------------------------------------------------------------------
seems like sound only stutters when using acpi, when booting with acpi=off
it no longer stutters..

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
