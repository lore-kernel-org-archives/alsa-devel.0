From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002115]: No Sound, No Error Message, Unmuted
Date: Fri, 12 May 2006 16:12:56 +0200
Message-ID: <100865ae5014431c9c1b7ee4821006b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33A5A175
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2006 16:12:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2115> 
======================================================================
Reported By:                bthomas
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2115
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian/GNU Linux (Sarge) 3.1r2
Kernel Version:             2.6.16.13 or 2.6.16.15 or 2.6.15.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-11-2006 23:12 CEST
Last Modified:              05-12-2006 16:12 CEST
======================================================================
Summary:                    No Sound, No Error Message, Unmuted
Description: 
No application is able to produce any sound on Dell Inspiron 9400 using
Debian GNU Linux (Sarge) 3.1r2 with Kernel 2.6.16.15 (or 2.6.16.13 or
2.6.15.7). Alsa drivers have been build into the kernel. Listed below is
some of the relevant information (Do let me know if anything else is
required).

lspci :
--------
0000:00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 01)

cat /proc/asound/cards :
-------------------------
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xdfffc000 irq 20

cat /proc/asound/oss/sndstat :
-------------------------------
Sound Driver:3.8.1a-980706 (ALSA v1.0.11rc2 emulation code)
Kernel: Linux darwin 2.6.16.13 #1 SMP PREEMPT Sat May 6 00:52:39 EDT 2006
i686
Config options: 0

Installed drivers: 
Type 10: ALSA emulation

Card config: 
HDA Intel at 0xdfffc000 irq 20

Audio devices:
0: STAC92xx Analog (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: SigmaTel STAC9200

dmesg :
--------
ALSA device list:
  #0: HDA Intel at 0xdfffc000 irq 20

Kernel Config (cat .config | grep SND) :
-----------------------------------------

CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=m

I have tried playing around with alsamixer but it was of no help. I can
confirm that it is not muted. I did try muting IEC958 too. It may be
pertinent that I have built the alsa drivers into the kernel and not as a
module.


======================================================================

----------------------------------------------------------------------
 tiwai - 05-12-06 16:12 
----------------------------------------------------------------------
Already fixed in 2.6.17rc4 kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-06 23:12 bthomas        New Issue                                    
05-11-06 23:12 bthomas        Distribution              => Debian/GNU Linux
(Sarge) 3.1r2
05-11-06 23:12 bthomas        Kernel Version            => 2.6.16.13 or
2.6.16.15 or 2.6.15.7
05-12-06 16:12 tiwai          Status                   assigned => resolved
05-12-06 16:12 tiwai          Resolution               open => fixed       
05-12-06 16:12 tiwai          Note Added: 0009779                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
