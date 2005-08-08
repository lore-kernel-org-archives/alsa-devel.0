From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001310]: Driver cant find firmware for Layla24
Date: Mon, 8 Aug 2005 21:40:05 +0200
Message-ID: <0efff3c191f2c437f23d066c81ab968c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6BCD91C3
	for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2005 21:40:06 +0200 (MEST)
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
Last Modified:              08-08-2005 21:40 CEST
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
 pochini - 08-08-05 09:22 
----------------------------------------------------------------------
The patch is against the official hotplug scripts. You have to look at the
system logs, eg. /var/log/messages or /var/log/syslog (look in
/etc/syslog.conf for details).

----------------------------------------------------------------------
 oxi - 08-08-05 21:40 
----------------------------------------------------------------------
Hi there!

I downloaded hotplug scripts form their site in sf and added changes
manually.
These are in my opinion the relevant parts of log files:

   --- /var/log/syslog: ---

Aug  8 21:13:00 localhost hal.dev[6198]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6200]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6202]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6204]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6206]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6217]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6218]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6219]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6220]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6225]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6235]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6239]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6247]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6254]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6259]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6263]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6275]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6276]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6277]: DEVNAME is not set
Aug  8 21:13:14 localhost kernel: ACPI: PCI Interrupt 0000:00:0e.0[A] ->
GSI 19 (level, low) -> IRQ 19
Aug  8 21:13:14 localhost hal.dev[6282]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6285]: DEVNAME is not set
Aug  8 21:13:24 localhost kernel: ALSA
/usr/src/alsa-driver-1.0.9b/pci/echoaudio/echoaudio.c:41: get_firmware():
Firmware not available (-2)
Aug  8 21:13:24 localhost kernel: Echoaudio Layla24: probe of 0000:00:0e.0
failed with error -2


   --- /var/log/messages: ---

Aug  8 21:13:14 localhost kernel: ACPI: PCI Interrupt 0000:00:0e.0[A] ->
GSI 19 (level, low) -> IRQ 19
Aug  8 21:13:24 localhost kernel: Echoaudio Layla24: probe of 0000:00:0e.0
failed with error -2


   --- /var/log/kern.log: ---

Aug  8 21:13:14 localhost kernel: ACPI: PCI Interrupt 0000:00:0e.0[A] ->
GSI 19 (level, low) -> IRQ 19
Aug  8 21:13:24 localhost kernel: ALSA
/usr/src/alsa-driver-1.0.9b/pci/echoaudio/echoaudio.c:41: get_firmware():
Firmware not available (-2)
Aug  8 21:13:24 localhost kernel: Echoaudio Layla24: probe of 0000:00:0e.0
failed with error -2


   --- /var/log/user.log: ---

Aug  8 21:13:00 localhost hal.dev[6198]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6200]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6202]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6204]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6206]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6217]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6218]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6219]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6220]: DEVNAME is not set
Aug  8 21:13:00 localhost hal.dev[6225]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6235]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6239]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6247]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6254]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6259]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6263]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6275]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6276]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6277]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6282]: DEVNAME is not set
Aug  8 21:13:14 localhost hal.dev[6285]: DEVNAME is not set

Hope this is of any help to find out the bug.
Greets

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
08-08-05 09:22 pochini        Note Added: 0005703                          
08-08-05 21:40 oxi            Note Added: 0005712                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
