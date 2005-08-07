From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001310]: Driver cant find firmware for Layla24
Date: Sun, 7 Aug 2005 18:27:47 +0200
Message-ID: <399dcd330466554345fc4b021c557546@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D0431E0
	for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2005 18:27:50 +0200 (MEST)
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
Last Modified:              08-07-2005 18:27 CEST
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
 pochini - 08-07-05 09:46 
----------------------------------------------------------------------
I didn't know I'm not the official maintainer anymore :))

The driver simply does:

	if ((err = request_firmware(fw_entry, name, pci_device(chip))) < 0)
		snd_printk(KERN_ERR "get_firmware(): Firmware not available (%d)\n",
err);
	return err;

So I don't think there is something wrong there. Btw an other user had a
similar problem some days ago. I quote the relevant part:

----------------------------------------
From: indigo@bitglue.com (Phil Frost)
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
Subject: [Alsa-devel] Re: [Alsa-user] need help getting echo indigo io to
work
Date: Tue, 19 Jul 2005 19:14:44 -0400

> Error -2 is -ENOENT (No such file or directory). request_firmware()
returns
> that error code if the file has zero size of if the script aborted the
> operation. Please check if /usr/lib/hotplug/firmware/ea/indigo_io_dsp.fw
is
> empty.

It's 17 kb away from empty. Also, firmware.agent seems to complete
successfuly from what I can tell. Lee Revell suggested on alsa-devel
that I should try with 2.6.12 since there have been changes in the
driver model since 2.6.10 (what i'm using). Indeed that seems to have
been the cause of the problem. With 2.6.12 I was able to play audio
nicely.
----------------------------------------

P.S.: my email is pochini@shiny.it

----------------------------------------------------------------------
 oxi - 08-07-05 18:27 
----------------------------------------------------------------------
Hey thank you all for your replies!

My mistake, Pochini! I saw "Discontinued" in the notes field in ALSA
soundcard matrix and thus concluded you were not supporting them anymore!
:D

Anyways, I already have kernel version 2.6.12.3. So I dont have a clue if
im missing something somehow, since im just a newbie linux user. If you
think of something obvious i might be missing please let me know!

Again, thank you all for your support and patience. :)

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
