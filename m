From: Eric Dantan Rzewnicki <eric@zhevny.com>
Subject: CARD-STATUS
Date: Sat, 20 Apr 2002 16:57:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CC1D64D.F0F4E177@zhevny.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CDE500703E32792B876524B9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------CDE500703E32792B876524B9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch against CVS corrects the module names in the
alsa-driver/CARD_STATUS file removing the -card.

-Eric Rz.
--------------CDE500703E32792B876524B9
Content-Type: text/plain; charset=us-ascii;
 name="CARDS-STATUS.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CARDS-STATUS.diff"

--- CARDS-STATUS.orig	Sat Apr 20 16:48:36 2002
+++ CARDS-STATUS	Sat Apr 20 16:50:43 2002
@@ -9,18 +9,18 @@
 
 check date format: yymmaa
 
-- snd-card-ad1816a
+- snd-ad1816a
 Highscreen Sound-Boostar 16 3D
 Analog Devices AD1815
 Analog Devices AD1816A:ti
 TerraTec Base 64
 
-- snd-card-ad1848
+- snd-ad1848
 Analog Devices AD1848
 Analog Devices AD1847
 Crystal Semiconductors CS4248
 
-- snd-card-als100
+- snd-als100
 Avance Logic ALS100 - PRO16PNP
 Avance Logic ALS110
 3D Melody MF1000
@@ -28,30 +28,30 @@
 Avance Logic ALS120
 RTL RTL3000
 
-- snd-card-azt2320
+- snd-azt2320
 Aztech Systems PRO16V
 Aztech Systems AZT2320
 Aztech Systems AT3300
 Aztech Systems AZT3000
 
-- snd-card-cmi8330
+- snd-cmi8330
 C-Media CMI8330:ab
 
-- snd-card-cmipci
+- snd-cmipci
 C-Media CMI8738:ti
 C-Media CMI8338A
 C-Media CMI8338B
 
-- snd-card-cs4231
+- snd-cs4231
 Crystal Semiconductors CS4231
 
-- snd-card-cs4232
+- snd-cs4232
 Turtle Beach TBS-2000
 Turtle Beach Tropez Plus
 AudioSystem EWS64
 SIC CrystalWave 32
 
-- snd-card-cs4236
+- snd-cs4236
 Genius Sound Maker 3DJ
 Crystal Semiconductors CS4235:jk
 Crystal Semiconductors CS4236B
@@ -68,22 +68,22 @@
 Acer AW37/Pro
 Acer AW35/Pro
 
-- snd-card-cs461x
+- snd-cs461x
 Cirrus Logic Sound Fusion (CS4280/CS4610/CS4612):jk
 Cirrus Logic Sound Fusion (CS4612)
 Cirrus Logic Sound Fusion (CS4615)
 
-- snd-card-dt0197h
+- snd-dt0197h
 Diamond Technologies DT-0197H
 
-- snd-card-emu10k1
+- snd-emu10k1
 Creative Labs SB Live!/PCI512/E-mu APS:ti,jk
 
-- snd-card-ens1370
+- snd-ens1370
 Ensoniq AudioPCI-97 ES1370:jk
 Creative Labs SB PCI64/128 (ES1370)
 
-- snd-card-ens1371
+- snd-ens1371
 Ensoniq AudioPCI ES1371/73:ti,jk
 Ensoniq AudioPCI ES1373
 Creative Labs Ectiva EV1938
@@ -91,13 +91,13 @@
 Creative Labs Vibra PCI128
 Ectiva EV1938
 
-- snd-card-es1688
+- snd-es1688
 ESS ES688 PnP AudioDrive
 ESS ES1688 PnP AudioDrive
 ESS ES688 AudioDrive
 ESS ES1688 AudioDrive
 
-- snd-card-es18xx
+- snd-es18xx
 ESS ES1868 PnP AudioDrive:ab:000628:
 ESS ES1869 PnP AudioDrive:ab,jk:000628:Incomplete 16 bit dma support
 ESS ES1878 PnP AudioDrive:(ab):U:Incomplete 16 bit dma support
@@ -107,32 +107,32 @@
 ESS ES1887 AudioDrive:(ab):U:Incomplete 16 bit dma support
 ESS ES1888 AudioDrive:(ab):U:Incomplete 16 bit dma support
 
-- snd-card-es1938
+- snd-es1938
 ESS ES1938:ab:000715:See notes inside driver
 TerraTec 128i PCI
 
-- snd-card-es1968
+- snd-es1968
 ESS Maestro 2e
 ESS Maestro 2
 ESS Maestro 1
 TerraTec DMX
 
-- snd-card-es968
+- snd-es968
 ESS AudioDrive ES968
 
-- snd-card-fm801
+- snd-fm801
 ForteMedia FM801:ab,jk
 
-- snd-card-gusclassic
+- snd-gusclassic
 Gravis UltraSound Classic:jk
 
-- snd-card-gusextreme
+- snd-gusextreme
 Gravis UltraSound Extreme:jk
 
-- snd-card-gusmax
+- snd-gusmax
 Gravis UltraSound MAX:jk
 
-- snd-card-ice1712
+- snd-ice1712
 MidiMan M Audio Audiophile:jk:
 MidiMan M Audio Delta 1010:jk:
 MidiMan M Audio Delta DiO 2496
@@ -143,80 +143,80 @@
 ICEnsemble Generic ICE1712
 ICEnsemble Generic Envy24
 
-- snd-card-intel8x0
+- snd-intel8x0
 Intel 82801AA:jk
 Intel 82901AB
 Intel MX440
 
-- snd-card-interwave-stb
+- snd-interwave-stb
 AMD InterWave STB with TEA6330T:jk
 
-- snd-card-interwave
+- snd-interwave
 Gravis UltraSound Plug & Play:jk
 STB SoundRage32
 MED MED3210
 Dynasonix Dynasonix Pro
 Panasonic PCA761AW
 
-- snd-card-mtpav
+- snd-mtpav
 MOTU MidiTimePiece AV multiport MIDI
 
-- snd-card-opl3sa2
+- snd-opl3sa2
 Yamaha YMF719E-S
 Genius Sound Maker 3DX
 Yamaha OPL3SA3
 Intel AL440LX sound
 
-- snd-card-opti92x-ad1848
+- snd-opti92x-ad1848
 OPTi 82C924 (AD1848):ti
 OPTi 82C925 (AD1848):ti
 
-- snd-card-opti92x-cs4231
+- snd-opti92x-cs4231
 OPTi 82C924 (CS4231)
 OPTi 82C925 (CS4231)
 
-- snd-card-opti93x:ti
+- snd-opti93x:ti
 OPTi 82C931/3
 
-- snd-card-pdplus
+- snd-pdplus
 SMarian Prodif Plus
 
-- snd-card-rme96
+- snd-rme96
 RME Digi96
 RME Digi96/8
 RME Digi96/8 PRO
 RME Digi96/8 PST
 RME Digi96/8 PAD
 
-- snd-card-rme9652
+- snd-rme9652
 RME Hammerfall
 RME Hammerfall-Light:ab,jk:000715:
 
-- snd-card-sb16
+- snd-sb16
 Creative Labs SB 16:ti
 Creative Labs SB Vibra16S
 Creative Labs SB Vibra16C
 Creative Labs SB Vibra16CL
 Creative Labs SB Vibra16X
 
-- snd-card-sb8
+- snd-sb8
 Creative Labs SB 1.0/SB 2.0/SB Pro
 
-- snd-card-sbawe
+- snd-sbawe
 Creative Labs SB AWE 32
 Creative Labs SB AWE 64:ti,jk
 Creative Labs SB AWE 64 Gold
 
-- snd-card-serial
+- snd-serial
 ALSA MIDI serial
 
-- snd-card-sgalaxy
+- snd-sgalaxy
 Aztech Systems Sound Galaxy
 
-- snd-card-sonicvibes
+- snd-sonicvibes
 S3 SonicVibes PCI
 
-- snd-card-trident
+- snd-trident
 Trident 4DWave DX
 Trident 4DWave NX:ti,jk
 SiS 7018 PCI Audio:jk
@@ -230,13 +230,13 @@
 Jaton SonicWave 4D
 Hoontech SoundTrack Digital 4DWave NX
 
-- snd-card-via686a
+- snd-via686a
 VIA VT82C686A:jk,ti
 
-- snd-card-wavefront
+- snd-wavefront
 Turtle Beach Maui/Tropez/Tropez+
 
-- snd-card-ymfpci
+- snd-ymfpci
 Yamaha YMF724
 Yamaha YMF724F
 Yamaha YMF740

--------------CDE500703E32792B876524B9--
