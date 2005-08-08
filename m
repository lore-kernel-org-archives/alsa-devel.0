From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001310]: Driver cant find firmware for Layla24
Date: Mon, 8 Aug 2005 04:32:09 +0200
Message-ID: <b4ea8ad8a1774209104a0ea97a2d120f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 701C019D
	for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2005 04:32:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1310> 
======================================================================
Reported By:                oxi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1310
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge AMD64
Kernel Version:             2.6.12.3
======================================================================
Date Submitted:             08-04-2005 22:50 CEST
Last Modified:              08-08-2005 04:32 CEST
======================================================================
Summary:                    Driver cant find firmware for Layla24
Description: 
Hello,

After modprobe snd-layla24 ,
in dmesg|tail:

ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
ALSA /usr/src/alsa-driver-1.0.9b/pci/echoaudio/echoaudio.c:41:
get_firmware(): Firmware not available (-2)
Echoaudio Layla24: probe of 0000:00:0e.0 failed with error -2

Same issue that another guy is experiencing with a Layla20:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1244
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001244 error with firmware with echo layla20
======================================================================

----------------------------------------------------------------------
 pochini - 08-08-05 00:06 
----------------------------------------------------------------------
The *card* is discontinued, not the driver.
I'm using the same kernel, SMP. Just to be sure the hotplug scripts find
the files, try this patch and look in the system logs:

--- /etc/hotplug/firmware.agent__orig	Sun Aug  7 23:48:59 2005
+++ /etc/hotplug/firmware.agent	Sun Aug  7 23:48:51 2005
@@ -41,10 +41,12 @@
     fi
 
     if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
+        mesg $FIRMWARE_DIR/$FIRMWARE loading...
         echo 1 > $SYSFS/$DEVPATH/loading
         cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
         echo 0 > $SYSFS/$DEVPATH/loading
     else
+        mesg $FIRMWARE_DIR/$FIRMWARE not found.
         echo -1 > $SYSFS/$DEVPATH/loading
     fi
 
If the BTS screws up spacing, add the two lines manually.
Then unload and reload the module. Also, check if FIRMWARE_DIR (inside
/etc/hotplug/firmware.agent) actually points to the directory where the
firmwares are stored.

----------------------------------------------------------------------
 oxi - 08-08-05 04:32 
----------------------------------------------------------------------
Oh I see

Well I dont have a clue on applying patches... however I search for some
info about it but i guess i didnt succeed at it :(

So I added both lines manually but noticed my file was using a
FIRMWARE_DIRS variable with several directories linked to it rather than a
FIRMWARE_DIR var with a single dir bound to it... So i managed to add them
both modifying them a bit to fit there, but i think the second line wont
fit in context very well(well, probably none of them xD)... I did a
/etc/init.d/alsasound stop ; modprobe -r snd ; modprobe snd-layla24 but
didnt notice anything different in dmesg|tail.

Note that im a newbie Linux user, and dont have the knowledge to perform
such patches correctly; however im willing to learn :) Therefore i have
uploaded my firmware.agent file so you can see for yourself how it looks
like now.

I should mention also that one of the dirs in the variable is empty, but i
dont think its important for the slight glimpse ive had from the script(i
cant write linux scripts yet!), that is the one in the middle:
/usr/local/lib/firmware

Willing to hear from you and thank you again for helping me on this even
when its starting to look like its not related to the driver at all :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-05 22:50 oxi            New Issue                                    
08-04-05 22:50 oxi            Distribution              => Debian Sarge AMD64
08-04-05 22:50 oxi            Kernel Version            => 2.6.12.3        
08-04-05 23:48 rlrevell       Note Added: 0005653                          
08-05-05 04:57 oxi            Note Added: 0005656                          
08-05-05 04:59 oxi            Issue Monitored: oxi                         
08-05-05 05:00 rlrevell       Note Added: 0005657                          
08-05-05 05:20 oxi            Note Added: 0005658                          
08-05-05 05:25 oxi            Note Added: 0005659                          
08-05-05 06:03 rlrevell       Note Added: 0005660                          
08-05-05 08:48 perex          Relationship added       related to 0001244  
08-05-05 13:26 oxi            Note Added: 0005666                          
08-05-05 15:09 hennewou       Note Added: 0005668                          
08-05-05 19:43 oxi            Note Added: 0005671                          
08-05-05 19:46 oxi            Note Edited: 0005671                         
08-05-05 20:36 rlrevell       Note Added: 0005675                          
08-05-05 23:10 hennewou       Note Added: 0005677                          
08-07-05 09:46 pochini        Note Added: 0005688                          
08-07-05 18:27 oxi            Note Added: 0005695                          
08-07-05 18:31 oxi            Note Added: 0005696                          
08-08-05 00:06 pochini        Note Added: 0005698                          
08-08-05 04:12 oxi            File Added: firmware.agent                    
08-08-05 04:32 oxi            Note Added: 0005700                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
