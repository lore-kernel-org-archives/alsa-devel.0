From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000311]: error messages: boot process, application start
Date: Thu, 13 Jan 2005 23:35:52 +0100
Message-ID: <733a438bd0388adc8497eccc2455e183@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D67D72F0
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 23:35:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=311> 
======================================================================
Reported By:                phil
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   311
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             vanilla 2.6.5
======================================================================
Date Submitted:             05-27-2004 15:00 CEST
Last Modified:              01-13-2005 23:35 CET
======================================================================
Summary:                    error messages: boot process, application start
Description: 
Everytime I boot my machine I get the following error code:

PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ALSA sound/pci/intel8x0.c:596: codec_semaphore: semaphore is not ready
[0x1][0x700300]
ALSA sound/pci/ac97/ac97_codec.c:1868: MC'97 1 converters and GPIO not
ready (0xff00)
ALSA sound/pci/intel8x0.c:596: codec_semaphore: semaphore is not ready
[0x1][0x700300]
intel8x0_measure_ac97_clock: measured 49475 usecs
intel8x0: clocking to 48000



And the following one after starting frozen-bubble:

ALSA sound/core/seq/oss/seq_oss_init.c:213: no device found
ALSA sound/pci/intel8x0.c:596: codec_semaphore: semaphore is not ready
[0x1][0x700300]
ALSA sound/pci/intel8x0.c:611: codec_write 0: semaphore is not ready for
register 0x2c


That's the only thing. Sound works fine - it's only the message I'm
concernd about...
======================================================================

----------------------------------------------------------------------
 tiwai - 06-30-04 16:35 
----------------------------------------------------------------------
Well, these messages are harmless, so you can ignore safely.

I'll disable the first message ("no device found" from seq_oss_init.c).
The messages about codec appear when the driver probes the secondary
codec, which is likely a modem codec.

----------------------------------------------------------------------
 nshmyrev - 01-13-05 23:35 
----------------------------------------------------------------------
Still have the same problems with kernel 2.6.10 when I load snd_intel8x0
and snd_intel8x0m. For me that message doesn't brake anything, but it's
still not so pleasure to see warnings in syslog.

codec_semaphore: semaphore is not ready [0x1][0x701300]
codec_write 1: semaphore is not ready for register 0x54


Moreower, David Gómez <dabisu@gmail.com> reported that such messages
brakes sound working:

It's broken, at least in 2.6.10. In my case, if i loaded the modem
driver, the sound one stopped working (with a lot of semaphore
errors...) My solution is not using the modem driver by now :(. I
think that Takashi said that there was a problem in common
initialization in both drivers, so i hope it gets fixed soon ;)

So, hope this problem will be fixed somehow ;)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-27-04 15:00 phil           New Issue                                    
05-27-04 15:00 phil           Distribution              => Debian sid      
05-27-04 15:00 phil           Kernel Version            => vanilla 2.6.5   
05-28-04 17:03 tiwai          Note Added: 0001266                          
06-21-04 10:15 phil           Note Added: 0001326                          
06-30-04 16:35 tiwai          Note Added: 0001357                          
01-13-05 23:35 nshmyrev       Note Added: 0003205                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
