From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001345]: microphone input does broken after upgrading from kernel 2.6.10 to 2.6.12
Date: Sun, 11 Sep 2005 07:07:45 +0200
Message-ID: <c169e95c2f39746163a052def9cb8b88@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 99846186
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2005 07:07:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1345> 
======================================================================
Reported By:                kayosiii
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1345
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mepis
Kernel Version:             2.6.12 custom compiled
======================================================================
Date Submitted:             08-17-2005 08:13 CEST
Last Modified:              09-11-2005 07:07 CEST
======================================================================
Summary:                    microphone input does broken after upgrading from
kernel 2.6.10 to 2.6.12
Description: 
Basically When a boot using kernel 2.6.10 I can record using a microphone.
With 2.6.12 I get no input... I am running the latest alsa-base in debian
unstable. And have tried just about every setting in kmixer
======================================================================

----------------------------------------------------------------------
 kayosiii - 08-25-05 03:59 
----------------------------------------------------------------------
System does not have an /etc/asound.state file ???

output of cat /proc/asound/card0/codec97#0/* 

0-0/0: Realtek ALC650F

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x22 Generation=1
Rate=48kHz
SPDIF In Status  : Not Locked
0:00 = 5980
0:02 = 1919
0:04 = 0000
0:06 = 801f
0:08 = 0000
0:0a = 0018
0:0c = 801f
0:0e = 0047
0:10 = 9f1f
0:12 = 8303
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0303
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 05c7
0:2a = 05c1
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 9f9f
0:38 = 9f9f
0:3a = 2a20
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 8000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 1004
0:6c = 0000
0:6e = 0025
0:70 = 0231
0:72 = 00a0
0:74 = 0043
0:76 = 0001
0:78 = 8102
0:7a = 57c3
0:7c = 414c
0:7e = 4720

----------------------------------------------------------------------
 kayosiii - 09-11-05 07:07 
----------------------------------------------------------------------
ok upgraded to 2.6.13 - sound has returned (for the front port at least)..
I can hear myself through the speakers but I cannot get a recording
happening...

I have tried Creox,Ardour,krec,Audacity,reZound none of them register any
input

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-05 08:13 kayosiii       New Issue                                    
08-17-05 08:13 kayosiii       Distribution              => Mepis           
08-17-05 08:13 kayosiii       Kernel Version            => 2.6.12 custom
compiled
08-22-05 12:20 perex          Assigned To              perex =>            
08-22-05 12:20 perex          Status                   assigned => new     
08-22-05 12:20 perex          Category                 0_compilation problem_!!!
=> PCI - intel8x0
08-23-05 16:50 tiwai          Note Added: 0005910                          
08-25-05 03:59 kayosiii       Note Added: 0005936                          
09-11-05 07:07 kayosiii       Note Added: 0006138                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
