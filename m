From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001534]: Mixer channel problems
Date: Mon, 28 Nov 2005 18:51:04 +0100
Message-ID: <c31e327da4f8208b9aa7cc6b8df0c5e0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1821B1DA
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2005 18:51:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1534> 
======================================================================
Reported By:                mrblur
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1534
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.14
======================================================================
Date Submitted:             11-08-2005 08:41 CET
Last Modified:              11-28-2005 18:51 CET
======================================================================
Summary:                    Mixer channel problems
Description: 
I'm using Acer AS5002WLMi with SiS 7012 soundcard. It works quite good,
but... unfortunately if I would like to change sound volume I have to do
it on headphones channel, master channel stereo/mona are not working.
======================================================================

----------------------------------------------------------------------
 mrblur - 11-28-05 13:48 
----------------------------------------------------------------------
root@Turion:~# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC203 rev 0

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 7/8
Extended ID      : codec=0 rev=2 AMAP DSA=0 SPDIF DRA VRA
Extended status  : SPCV SPDIF=10/11 SPDIF VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

                    Gain     Inverted  Buffer delay  Location
Master Out       :   0.0 dBV    -      23/fs         Rear I/O Panel
AUX Out          :   0.0 dBV    -      23/fs         Rear I/O Panel
Center/LFE Out   :   0.0 dBV    -      23/fs         Rear I/O Panel
SPDIF Out        :   0.0 dBV    -      23/fs         Rear I/O Panel
Phone In         :   0.0 dBV    -      23/fs         Rear I/O Panel
Mic 1            :   0.0 dBV    -      23/fs         Rear I/O Panel
Mic 2            :   0.0 dBV    -      23/fs         Rear I/O Panel
Line In          :   0.0 dBV    -      23/fs         Rear I/O Panel
CD In            :   0.0 dBV    -      23/fs         Rear I/O Panel
Video In         :   0.0 dBV    -      23/fs         Rear I/O Panel
Aux In           :   0.0 dBV    -      23/fs         Rear I/O Panel
Mono Out         :   0.0 dBV    -      23/fs         Rear I/O Panel
root@Turion:~#

----------------------------------------------------------------------
 tiwai - 11-28-05 18:51 
----------------------------------------------------------------------
Try ac97_quirk=hp_only option for snd-intel8x0 module.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 08:41 mrblur         New Issue                                    
11-08-05 08:41 mrblur         Kernel Version            => 2.6.14          
11-08-05 17:48 tiwai          Note Added: 0006628                          
11-28-05 13:48 mrblur         Note Added: 0006859                          
11-28-05 18:51 tiwai          Note Added: 0006863                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
