From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002287]: Segfaults all functions after
	snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t
	*) & val);
Date: Wed, 19 Jul 2006 17:43:54 +0200
Message-ID: <16c03ad92ca5a6e44a934289e94f4d70@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85E7DD2
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 17:43:54 +0200 (MEST)
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
Last Modified:              07-19-2006 17:43 CEST
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
 Raymond - 07-19-06 06:21 
----------------------------------------------------------------------
Audiophile Delta 192 seem not supported

Can you playback/capture any stereo sound ?

You have to idenify the sound chip 

http://www.via.com.tw/en/products/audio/controllers/

and those AK4xxx ADC/DAC on your card

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=file;file=pci/ice1712/ak4xxx.c;filenode=d9808d13fa5fa018617ba56852cdc6473a7a35af;style=raw

Find out the specification of your card and compare the specification of
other ice1724 cards.

Find out the specification of those ADC/DAC on your card.

Study those ice1724 driver code (e.g. aureon.c, ... ) and see whether you
can find any cards have similar features/architecture (e.g. same ADC/DAC,
...) with your card.

It is impossible to write a new driver by using the control 'multi track
peak' which is only an abstract control.

----------------------------------------------------------------------
 cruiseoveride - 07-19-06 17:43 
----------------------------------------------------------------------
thats great, only one problem I have no idea how to write a driver, but let
see if ALSA will  help. So help!

the card is ..
05:07.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)

now we look at the VIA website,..
The Max sample rate on the card is 192KHz

So this would make it more a 24HT than a 24PT, but the number of channels
on the card would blend it with a 24MT too.

So then...Acording to VIA this should have the following capabilities...

24HT
------------------------
Max Output Channels - 8
Max Input Channels - 4
24bit on either Analog or Digital I/O
and 192Khz ||

the 24MT however matches the M-Audio Delta Audiophile 192 closest with the
following 

24MT (according to VIA) --- (according to physik)
Max Output Channels - 2  ---  (2x RCA OUT (Main Out L/R, Mon Out L/R)
Max Input Channels - 2  -----  (1x RCA IN (In L/R) + 1x S/PDIF IN )
24bit on either Analog or Digital I/O ----- (true)
and 192Khz || ---- (true)

So then wat do we do, is the linux pci ID incorrect?
Ok lets believe its true and stick to a 24HT


I have no idea wat ur talking about with the AKxx and the ADC/DAC

So wat do WE do?

I have enough C and C++ knowledge to write a driver however, i do not have
to knowledge to hack an existing ALSA driver. I could write a new driver
from scracth but I cant until the ALSA API is properly documented.

So was to I do?

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
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
