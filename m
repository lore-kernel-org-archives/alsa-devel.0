From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002068]: No sound in headphones - A3H ASUS
Date: Wed, 26 Apr 2006 13:01:41 +0200
Message-ID: <a3c5364993eeec19b597e53f7024a156@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED646162
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2006 13:01:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2068> 
======================================================================
Reported By:                awisniewski
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2068
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-25-2006 12:03 CEST
Last Modified:              04-26-2006 13:01 CEST
======================================================================
Summary:                    No sound in headphones - A3H ASUS
Description: 
Hello

I have ASUS A3H model laptop. I've just compiled kernel 2.6.16.11 from
kernel.org (newest). I used CONFIG_SND_HDA_INTEL=y option in kernel config
and it seems to be working propertly till I'm not trying use headphone
(internal speaker from laptop is working propertly). When I plug in
headphones into the jack port in laptop, internal speaker is silent but I
can not hear anything in headphones. It seems like turned on MUTT option
in mixer but I can not find option for headphones in my mixer
application.
 
Few facts:

lapek:/proc/asound# cat version 
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).

andy@lapek:~/moje/instalki/Linux/kernele/linux-2.6.16.11$ uname -a
Linux lapek 2.6.16.11 #1 Tue Apr 25 10:07:45 CEST 2006 i686 GNU/Linux

lapek:/proc/asound# cat timers 
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-3: PCM capture 0-0-3 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE

lapek:/proc/asound# cat pcm 
00-01: ALC880 Digital : ALC880 Digital : playback 1
00-00: ALC880 Analog : ALC880 Analog : playback 1 : capture 2

lapek:/proc/asound# cat devices 
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

I will add /proc/asound/card0/codec#0 file also (as attachmets).

======================================================================

----------------------------------------------------------------------
 awisniewski - 04-26-06 12:49 
----------------------------------------------------------------------
:/ model=asus and model=test are not working :/

Apr 26 12:44:28 lapek kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI
16 (level, low) -> IRQ 17
Apr 26 12:44:28 lapek kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Apr 26 12:44:28 lapek kernel: ALSA
/home/andy/moje/instalki/Linux/alsa/alsa-driver-1.0.11/pci/hda/hda_codec.c:1704:
hda_codec: model 'test' is selected

--------
Apr 26 12:42:17 lapek kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Apr 26 12:42:18 lapek kernel: ALSA
/home/andy/moje/instalki/Linux/alsa/alsa-driver-1.0.11/pci/hda/hda_codec.c:1704:
hda_codec: model 'asus' is selected
--------

I' attaching new codec file. Do you need any other file(s) ?

----------------------------------------------------------------------
 tiwai - 04-26-06 13:01 
----------------------------------------------------------------------
Using "test" model, you can adjust all possible controls.  If it doesn't
work with any combinations, there is no hope.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 12:03 awisniewski    New Issue                                    
04-25-06 12:03 awisniewski    File Added: codec#0                          
04-25-06 12:08 awisniewski    File Added: codec.zip                        
04-25-06 18:16 tiwai          Note Added: 0009493                          
04-25-06 18:21 tiwai          Note Added: 0009494                          
04-26-06 12:49 awisniewski    Note Added: 0009506                          
04-26-06 12:54 awisniewski    File Added: codec_v2.zip                     
04-26-06 13:01 tiwai          Note Added: 0009507                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
