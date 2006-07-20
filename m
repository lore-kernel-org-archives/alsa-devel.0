From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002287]: Segfaults all functions after
	snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t
	*) & val);
Date: Thu, 20 Jul 2006 08:05:49 +0200
Message-ID: <7a219b9389dffb50bd590f59ae010106@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 673B024E
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 08:05:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2287> 
======================================================================
Reported By:                cruiseoveride
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2287
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-16-2006 18:03 CEST
Last Modified:              07-20-2006 08:05 CEST
======================================================================
Summary:                    Segfaults all functions after
snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t *) & val);
Description: 
I am new to Alsa and am not happy at all at the state of documentation
available.
You guys seriously need to do something about this.

I have an M-Audio Audiophile Delta 192 (ICE1724) and I want to port
envy24control for this chip, However I first need to familiar myself with
the ALSA API. So I began by looking for simple examples on how to use ALSA
API and came accross the followinf prog (Attached file test.c).

The program compiles cleanly with gcc-4.1 and runs, however after it
prints out the ..."buffer size = 8192 frames"
It segfaults.

If you slash out line 104, it resolves the issue.

My question is,

Is there a bug in this function?
Code was obtained from http://www.linuxjournal.com/article/6735
======================================================================

----------------------------------------------------------------------
 Raymond - 07-20-06 05:01 
----------------------------------------------------------------------
You should find out the label of the "envy24xx" on the largest chip, the
label of 48-pins ac97 chip if the chip use AC-link) or the label of the
ADC/DAC (black ic) if the chip use I2S link)

lspci -vn

Your card should have different PCI Subsystem vendor id and device id 

You don't need to write from scratch, search the alsa-devel mailing
archive and find out those topic about 'patch to add support for
particular iec1724 card'.

alsa-driver

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html





  Module snd-ice1724
  ------------------

    Module for Envy24HT (VT/ICE1724), Envy24PT (VT1720) based PCI sound
cards.
			* MidiMan M Audio Revolution 5.1
			* MidiMan M Audio Revolution 7.1
			* AMP Ltd AUDIO2000
			* TerraTec Aureon 5.1 Sky
			* TerraTec Aureon 7.1 Space
			* TerraTec Aureon 7.1 Universe
			* TerraTec Phase 22
			* TerraTec Phase 28
			* AudioTrak Prodigy 7.1
			* AudioTrak Prodigy 7.1LT
			* AudioTrak Prodigy 192
			* Pontis MS300
			* Albatron K8X800 Pro II 
			* Chaintech ZNF3-150
			* Chaintech ZNF3-250
			* Chaintech 9CJS
			* Chaintech AV-710
			* Shuttle SN25P

    model       - Use the given board model, one of the following:
		  revo51, revo71, amp2000, prodigy71, prodigy71lt,
		  prodigy192, aureon51, aureon71, universe,
		  k8x800, phase22, phase28, ms300, av710

    This module supports multiple cards and autoprobe.

    Note: The supported board is detected by reading EEPROM or PCI
	  SSID (if EEPROM isn't available).  You can override the
	  model by passing "model" module option in case that the
	  driver isn't configured properly or you want to try another
	  type for testing.



----------------------------------------------------------------------
 cruiseoveride - 07-20-06 08:05 
----------------------------------------------------------------------
i have no idea wat ur looking for, ill photograph the card and upload the
file.

u want me to compare this card to existing card's driver?
wat are these board models?

Bare with me pls,

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-06 18:03 cruiseoveride  New Issue                                    
07-16-06 18:03 cruiseoveride  File Added: test.c                           
07-16-06 20:38 cruiseoveride  Issue Monitored: cruiseoveride                    
07-17-06 02:44 Raymond        Note Added: 0011032                          
07-17-06 02:47 Raymond        Note Edited: 0011032                         
07-17-06 03:18 Raymond        Note Edited: 0011032                         
07-17-06 05:45 cruiseoveride  Note Added: 0011033                          
07-17-06 05:46 cruiseoveride  Note Edited: 0011033                         
07-17-06 07:31 Raymond        Note Added: 0011035                          
07-17-06 08:23 Raymond        Note Added: 0011036                          
07-17-06 08:26 Raymond        Note Edited: 0011036                         
07-17-06 14:48 cruiseoveride  Note Added: 0011039                          
07-17-06 14:59 cruiseoveride  Note Added: 0011040                          
07-17-06 16:07 Raymond        Note Added: 0011042                          
07-17-06 16:31 Raymond        Note Edited: 0011042                         
07-17-06 16:40 cruiseoveride  Note Added: 0011044                          
07-17-06 17:13 cruiseoveride  Note Added: 0011045                          
07-17-06 17:34 Raymond        Note Added: 0011046                          
07-17-06 17:56 cruiseoveride  Note Added: 0011047                          
07-18-06 07:44 Raymond        Note Added: 0011053                          
07-18-06 14:21 cruiseoveride  Note Added: 0011057                          
07-18-06 14:35 Raymond        Note Added: 0011060                          
07-19-06 02:52 cruiseoveride  Note Added: 0011075                          
07-19-06 03:27 Raymond        Note Added: 0011076                          
07-19-06 06:21 Raymond        Note Added: 0011080                          
07-19-06 17:43 cruiseoveride  Note Added: 0011090                          
07-19-06 17:50 cruiseoveride  File Added: chip.jpg                         
07-20-06 04:22 Raymond        Note Added: 0011107                          
07-20-06 05:01 Raymond        Note Edited: 0011107                         
07-20-06 08:05 cruiseoveride  Note Added: 0011112                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
