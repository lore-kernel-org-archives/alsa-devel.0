From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0001763]: How to provide patch for the soundcard matrix ?
Date: Fri, 10 Feb 2006 17:31:38 +0100
Message-ID: <fea3ec71495cd22a6a887c361e25155f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF5EB1A0
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 17:31:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1763> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   1763
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-20-2006 09:10 CET
Last Modified:              02-10-2006 17:31 CET
======================================================================
Summary:                    How to provide patch for the soundcard matrix ?
Description: 
How to provide patch for the soundcard matrix ?

http://www.alsa-project.org/alsa-doc/index.php?vendor=All#matrix

(e.g. Is there any description of the xml file submitted in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=938 ? )

1) Is mpu401 uart regarded as [MIDIio] ?

2) Is coaxial SPDIF in/out regarded as [RCAio] ?

3) Is optical SPDIF out classified as [TOSo] ?

4) Add "modem not support" to Note


======================================================================

----------------------------------------------------------------------
 Raymond - 02-03-06 18:48 
----------------------------------------------------------------------
Those Vortex chip on the motherboards are label as au8808 instead of au8820
(e.g. IWill LE370)

http://members.optusnet.com.au/kirben/soundcards.html



----------------------------------------------------------------------
 Raymond - 02-10-06 17:31 
----------------------------------------------------------------------
The following sound cards use the Aureal chipset: Vortex 1 chipset cards:
Aureal Vortex 1 PCI (OEM)
Aztech PCI 338 A3D
DCS S805
Diamond Sonic Impact S90
Gallant Audiostorm A3D
Genius Soundmaker 64
Hi-Val A3D PCI 338
Intresource TeraSound A3D PCI
I/O Magic MagicWave PCI A3D
Mediatek Sound Image Symphonic PCI-1
Multiwave AudioWave PCI DigitalSound
Orchid NuSound PCI
Samtek Rock'n98 A3D
Shark Predator PCI
Skywell Magic Sound
Techworks Power Vortex 1
Terratec Xlerate PCI
Turtle Beach Montego A3Dxstream
Xitel Storm VX

Vortex 2 chipset cards:
Aureal Vortex2 PCI (OEM)
Aureal Vortex2 SQ2500
Aureal Vortex2 SQ3500 Turbo
Aureal Vortex2 SuperQuad Digital PCI (OEM)
Absolute Multimedia Outrageous 3D Sound
Diamond Monster Sound MX300
Digital Research Thunderstorm Vortex2
Hi-Val PCI 576 A3D
I/O Magic MagicWaveV2
Techworks Power Vortex 2
Terratec XLerate Pro
Turtle Beach Montego II
Turtle Beach Montego II Home Studio
Turtle Beach Montego II Plus
Turtle Beach Montego II Quadzilla
Videologic SonicVortex2
Xitel Storm Platinum

Vortex Advantage chipset based sound cards:
Aureal Vortex SQ1500
Absolute Multimedia Outrageous 3D Sound Lite
Digital Research Thunderstorm Vortex Advantage
I/O Magic MagicWaveV1

These motherboards shipped with a Vortex Advantage chipset integrated on
them:
Abit WX6
Gigabyte GA-6CX
Gigabyte GA-6CXC
Soyo 6IWM
Soyo 6IWM/L
Soyo 7IWA
Soyo 7IWA-F

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-20-06 09:10 Raymond        New Issue                                    
01-22-06 17:34 pochini        Note Added: 0007749                          
01-23-06 05:19 Raymond        Note Added: 0007759                          
01-23-06 09:44 Raymond        Note Added: 0007760                          
01-24-06 08:58 Raymond        File Added: soundcardmatrix_au88x0.patch          
         
01-27-06 13:26 Raymond        Note Added: 0007799                          
01-27-06 13:34 lmike          Note Added: 0007800                          
01-30-06 06:11 Raymond        File Added: soundcardmatrix_aureal.patch          
         
02-01-06 17:29 Raymond        Note Added: 0007861                          
02-03-06 18:48 Raymond        Note Edited: 0007861                         
02-10-06 17:31 Raymond        Note Added: 0008007                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
