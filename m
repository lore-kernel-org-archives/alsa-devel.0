From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000535]: via82xx: "codec 0 is not valid..."
Date: Sat, 9 Apr 2005 17:29:11 +0200
Message-ID: <e307849a2e324e06e7e9a2d1e08952af@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6E9D4225
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 17:29:11 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0000331.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=535> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   535
Category:                   PCI - via82xx
Reproducibility:            have not tried
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-24-2004 14:29 CEST
Last Modified:              04-09-2005 17:26 CEST
======================================================================
Summary:                    via82xx: "codec 0 is not valid..."
Description: 
Trying to play any sound at all generates lines like this in the syslog:

kernel: ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/via82xx.c:588:
codec_read: codec 0 is not valid [0xfe0000]
kernel: ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/via82xx.c:727:
invalid via82xx_cur_ptr, using last valid pointer


with no sound ever being produced.  I don't know anything about sound
hardware, so don't know what other information you need.  It's an onboard
chip, listed in the debconf data below.



======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000331 possible incompatibility with cpu-freq
======================================================================

----------------------------------------------------------------------
 tiwai - 09-24-04 14:54 
----------------------------------------------------------------------
Try to turn off ACPI?

----------------------------------------------------------------------
 jdthood - 11-05-04 11:53 
----------------------------------------------------------------------
In reply to the "turn off ACPI" suggestion the submitter replies "No
change".

----------------------------------------------------------------------
 tiwai - 11-09-04 18:34 
----------------------------------------------------------------------
The first message (codec 0...) is likely harmless.  I know other devices 
show the same message but working.

The second one (using last ptr) is more serious, but the system should
still work, at least produce some sounds.
The fact that he doesn't get any sound implies that the mixer
configuration is not properly done.

----------------------------------------------------------------------
 flapointe - 11-18-04 06:17 
----------------------------------------------------------------------
I have a similar issue here on a amd64 computer. When I try to play a sound
after a fresh boot, it plays a few seconds (sometimes with sound, but most
of the time without) and then it spits lots of "codec_ready: codec 0 is
not ready [0x124fff0]
codec_read: codec 0 is not valid [0x1a40000]
codec_read: codec 0 is not valid [0x1a40000]
codec_read: codec 0 is not valid [0x1a40000]" and the player stops playing
like it's paused. Afterward, it's impossible to play any file again until
a reboot. I am using a 2.6.9-gentoo-r1 kernel (ALSA 1.0.6 compiled as
modules) but I had the same problem with previous releases and ALSA
compiled in the kernel. The computer does not seem to be able to boot
without ACPI enabled so it's there to stay.

----------------------------------------------------------------------
 flapointe - 04-09-05 17:26 
----------------------------------------------------------------------
The sound works normally when I stop using CPU frequency stepping.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 14:29 jdthood        New Issue                                    
09-24-04 14:54 tiwai          Note Added: 0001889                          
11-05-04 11:53 jdthood        Note Added: 0002306                          
11-09-04 18:34 tiwai          Note Added: 0002330                          
11-18-04 05:49 flapointe      Issue Monitored: flapointe                    
11-18-04 05:50 flapointe      Issue End Monitor: flapointe                    
11-18-04 06:10 flapointe      File Added: lsmod                            
11-18-04 06:11 flapointe      File Added: lspci                            
11-18-04 06:11 flapointe      File Added: dmesg                            
11-18-04 06:17 flapointe      Note Added: 0002444                          
11-18-04 06:18 flapointe      Issue Monitored: flapointe                    
04-09-05 17:04 jdthood        Status                   new => acknowledged 
04-09-05 17:26 flapointe      Note Added: 0004424                          
04-09-05 17:29 jdthood        Relationship added       related to 0000331  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
