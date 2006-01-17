From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001366]: 3D control, EQ peaks and EQ controls appear in capture view of alsamixer and they also have capture channels in amixer
Date: Tue, 17 Jan 2006 12:55:37 +0100
Message-ID: <8481ed4dc460770b125e82334fd9d41a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F398815D
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2006 12:55:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1366> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1366
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-24-2005 09:26 CEST
Last Modified:              01-17-2006 12:55 CET
======================================================================
Summary:                    3D control, EQ peaks and EQ controls appear in
capture view of alsamixer and they also have capture channels in amixer
Description: 
3D control (Depth and Rear Depth) appear in capture view of alsamixer.

amixer display these controls have capture channels.



EQ peaks

alsamixer cannot display 10-bands EQ peaks properly.

amixer display the wrong channel name for EQ peaks (Feature request).

Refer to 5.2.3.4.2.6 Graphical Equalizer Controls in USB audio
http://www.usb.org/developers/devclass_docs/audio10.pdf

Is it feasible to adopt the naming convention of the EQ center frequency
in amixer/alsamixer ?



10-bands stereo EQ controls

alsamixer display 10-bands stereo EQ controls in capture view.

amixer display the 10 EQ controls have capture channels.

In theory, the EQ controls can be connected to regulate the capture audio
from AC97, but this will need a rewrite of the existing driver to support
dynamic disconnect of the equalizer from the playback device and connect
the capture device and vice versa.

Most au8810/au8830 users perfer to use the Equalizer to control playback
only.
======================================================================

----------------------------------------------------------------------
 Raymond - 12-22-05 15:44 
----------------------------------------------------------------------
amixer 

Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono   <--------------------------
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono   <--------------------------
  Limits: 0 - 15
  Mono: 0 [0%]

----------------------------------------------------------------------
 Raymond - 01-17-06 12:55 
----------------------------------------------------------------------
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono <----------------------
  Limits: 0 - 3
  Mono: 1 [33%]


cat   /proc/asound/I82801BAICH2/codec97#0/ac97#0-0
0-0/0: Realtek ALC200,200P rev 0
 
 
Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement
 
Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=7/8 VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 09:26 Raymond        New Issue                                    
09-05-05 15:18 Raymond        File Added: Capture.png                      
09-05-05 15:19 Raymond        File Added: alsamixer.png                    
11-03-05 14:17 Raymond        Note Added: 0006603                          
11-08-05 13:50 Raymond        Note Added: 0006620                          
12-22-05 15:44 Raymond        Note Added: 0007127                          
01-17-06 12:55 Raymond        Note Added: 0007698                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
