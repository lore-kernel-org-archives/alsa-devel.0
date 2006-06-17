From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002038]: Microphone is not working on
	Sigmatel STAC9200
Date: Sun, 18 Jun 2006 00:37:19 +0200
Message-ID: <5dd28fbeccf1743d08bf659bcc00cb80@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0696161
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Jun 2006 00:37:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2038> 
======================================================================
Reported By:                telles
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2038
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva 2006
Kernel Version:             2.6.12-18mdk
======================================================================
Date Submitted:             04-19-2006 20:58 CEST
Last Modified:              06-18-2006 00:37 CEST
======================================================================
Summary:                    Microphone is not working on Sigmatel STAC9200
Description: 
I have a laptop Dell Latitude 120L with a HDA Intel Sound Board:
Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition
Audio Controller (rev 03)
that is recognized as Sigmatel STAC9200.
Sound is working great but the microphone is not working at all.
I think that is missing some control on alsamixer about Mic, because there
is no Mic's volume or sound control, only "Input Source" is present
(Line|Mic) and seems that it doesn't change anything about Microphone.
======================================================================

----------------------------------------------------------------------
 MACHINE - 06-03-06 03:56 
----------------------------------------------------------------------
Same problem on Acer TravelMate 3000 Series.
However I can only record by using 'arecord' tool, and it only works when
I turn 'capture volume' on in PLAYBACK, instead of CAPTURE.

I'm using ALSA 1.0.11.

----------------------------------------------------------------------
 maiquel - 06-18-06 00:37 
----------------------------------------------------------------------
I can reproduce this on a Dell Latitude 120L laptop (Sigmatel 9200 chip),
with Mandriva Linux 2006, kernels: 2.6.12-18mdk (rpm from 'cooker'
repository), 2.6.12.18 (compiled by me) and 2.6.12-18mdk (rpm from de
official DVD).

I have compiled the alsa 1.0.11 with the kernel 2.6.12.18.

The command:
cat /proc/asound/version

Returned:
Advanced Linux Sound Architecture Driver Version 1.0.11.
Compiled on May 30 2006 for kernel 2.6.16.18.

One interesting thing is that with 1.0.11 there is some noise when I
unmute line-in (external microphone, because there isn't a internal
one in this model) and try to record something. The amplitude response is
ok and actualy
I'm able to hear my voice (when a speak loud) but there is a lot of
noise.

I had tested like this:

1 - I had configured the alsamixer controle INPUT SOURCE to the LINE
value. Any sound isn't recorded when I change this value to MIC.

2 - I started the 'arecord' program like this:  
   arecord -f cd test-2038.wav

3 - I say "A..B..C..D..E..F".

4 - The 'aplay' command  returned:
[maiquel@dell tmp]$ aplay test-2038.wav
Playing WAVE 'test-2038.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo

5 - The output is atached here.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-06 20:58 telles         New Issue                                    
04-19-06 20:58 telles         Distribution              => Mandriva 2006   
04-19-06 20:58 telles         Kernel Version            => 2.6.12-18mdk    
04-19-06 22:09 rlrevell       Note Added: 0009358                          
04-19-06 22:50 telles         Note Added: 0009359                          
04-19-06 23:21 rlrevell       Note Added: 0009361                          
04-20-06 14:30 tiwai          Note Added: 0009373                          
04-20-06 15:59 telles         File Added: codec#0.txt                      
04-20-06 15:59 telles         File Added: codec#1.txt                      
04-20-06 16:01 telles         Note Added: 0009393                          
04-20-06 16:04 telles         Note Edited: 0009393                         
06-03-06 03:56 MACHINE        Note Added: 0010060                          
06-17-06 23:52 maiquel        Issue Monitored: maiquel                     
06-18-06 00:37 maiquel        Note Added: 0010294                          
======================================================================
