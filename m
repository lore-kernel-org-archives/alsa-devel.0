From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001475]: Support for M Audio Audiophile 192
Date: Sun, 19 Mar 2006 18:53:28 +0100
Message-ID: <a109762499d813093db6f18a6d4e6c08@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8A001DD
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 18:53:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1475> 
======================================================================
Reported By:                Dazed
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1475
Category:                   PCI - ice1724
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               FC3
Kernel Version:             2.6.*
======================================================================
Date Submitted:             10-14-2005 13:41 CEST
Last Modified:              03-19-2006 18:53 CET
======================================================================
Summary:                    Support for M Audio Audiophile 192
Description: 
Is it possible to add support for the M Audio Audiophile 192 sound card? It
looks to me like it's based on the ICE1724 chipset. I'd settle for simple
CD playback for starters. ;-)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001646 Wish for M-Audio AudioPhile 192 (AP192K...
======================================================================

----------------------------------------------------------------------
 jorx - 11-14-05 23:00 
----------------------------------------------------------------------
I am also requesting a driver for this card. As Dazed states OSS has a
driver for this card. It is working like anything. ALSA should also have
one. I hope someone could start with this. I would love to myself, but I
know way to little to even think about it.

----------------------------------------------------------------------
 paule - 03-19-06 18:53 
----------------------------------------------------------------------
Hello!
I'm also not able to run my AP192 under Linux (Knoppix,Debian, Fedora). 
The people from M Audio Support means this Card is based on the Envy24HT
Chipset. 
Here my boot kernelmessage (loading snd_ice1724 module)

-->
ice1724: No matching model found for ID 0x12143236
<-- 

Here the output from "lspci" on my box:

-->
0000:02:0c.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
<---

With snd_ice1724 module I only hear "audio sludge" when I play mp3 files.

Here the output from "lsmod". It is a 2.6 Standardkernel from
backports.org

-->
Module                  Size  Used by
shpchp                 43360  0
pci_hotplug            26940  1 shpchp
snd_ice1724            62948  1
snd_ice17xx_ak4xxx      4192  1 snd_ice1724
snd_ac97_codec         83840  1 snd_ice1724
snd_ac97_bus            2432  1 snd_ac97_codec
snd_ak4114              9408  1 snd_ice1724
snd_pcm_oss            47200  0
snd_mixer_oss          16768  1 snd_pcm_oss
snd_pcm                81508  4
snd_ice1724,snd_ac97_codec,snd_ak4114,snd_pcm_oss
snd_timer              23364  1 snd_pcm
snd_page_alloc         10568  1 snd_pcm
snd_ak4xxx_adda         6208  2 snd_ice1724,snd_ice17xx_ak4xxx
snd_mpu401_uart         7520  1 snd_ice1724
snd_rawmidi            23808  1 snd_mpu401_uart
snd_seq_device          8524  1 snd_rawmidi
snd                    52804  13
snd_ice1724,snd_ac97_codec,snd_ak4114,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_ak4xxx_adda,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               9728  1 snd
~~~

Hope this helps.

klaus

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-14-05 13:41 Dazed          New Issue                                    
10-14-05 13:41 Dazed          Distribution              => FC3             
10-14-05 13:41 Dazed          Kernel Version            => 2.6.*           
10-14-05 13:56 Dazed          Note Added: 0006480                          
10-14-05 15:05 Dazed          Note Edited: 0006480                         
11-14-05 23:00 jorx           Note Added: 0006728                          
11-14-05 23:02 jorx           Issue Monitored: jorx                        
01-10-06 15:25 Dazed          Issue Monitored: Dazed                       
03-14-06 17:30 rlrevell       Relationship added       related to 0001646  
03-19-06 18:53 paule          Note Added: 0008694                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
