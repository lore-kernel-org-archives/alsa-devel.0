From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001475]: Support for M Audio
	Audiophile 192
Date: Thu, 20 Jul 2006 15:56:08 +0200
Message-ID: <0e234f0c33a79056e40d5e4c0cfbef4e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 716B6193
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 15:56:08 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Last Modified:              07-20-2006 15:56 CEST
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

----------------------------------------------------------------------
 cruiseoveride - 07-20-06 15:56 
----------------------------------------------------------------------
I too have the card and would like support, 
I have put verbose diagnostic info about the card at

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2293

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
03-19-06 18:53 paule          Issue Monitored: paule                       
06-08-06 16:50 drycellbattery Issue Monitored: drycellbattery                   

07-20-06 15:56 cruiseoveride  Note Added: 0011128                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
