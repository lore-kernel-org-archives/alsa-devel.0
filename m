From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Fri, 30 Nov 2007 18:07:27 +0100
Message-ID: <4750434F.2080603@keyaccess.nl>
References: <474E1189.9030701@keyaccess.nl>	<200711290920.05010.bjorn.helgaas@hp.com>	<474EF871.7090400@gmail.com>	<200711291230.24323.bjorn.helgaas@hp.com>	<474F5DFC.6040507@keyaccess.nl>
	<s5h7ik0f6eq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030501030706070908040202"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 69E9E1037FD
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 18:08:14 +0100 (CET)
In-Reply-To: <s5h7ik0f6eq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, "yakui.zhao" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030501030706070908040202
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 30-11-07 10:07, Takashi Iwai wrote:

> At Fri, 30 Nov 2007 01:49:00 +0100,
> Rene Herman wrote:

>> Actually, the ALSA drivers with PnPBIOS support (snd-cs4232, snd-es18xx and 
>> snd-opl3sa2) do not in fact loose any parameters and the few known trouble 
>> spots there are using
>>
>> 	modprobe snd-foo isapnp=0 port=...
>>
>> as their workaround, bypassing all of PnP, and this still works completely 
>> the same as before.
>>
>> I do not expect any trouble. A few users might have _mistakingly_ added 
>> parameters to an ISAPnP only (as in, not also PnPBIOS) driver due to 
>> googling up your generic bad-advice webforum that said that worked for 
>> someone with a heavy sounding nickname, but we can deal with that.
>>
>> Moreover, as I've been experiencing on the ALSA list for a while now (where 
>> I've been somewhat responsive to ISA related issues) basically anything but 
>> PnPBIOS/ACPI ISA is mostly dead and as said, with an isapnp=0 in the drivers 
>> there which known issues are using, there's no difference.
>>
>> Advice is always good, but I'd not put in the ALSA documentation (wrong 
>> place) and even in the changelog it sounds a bit overly alarming in my own 
>> opinion. The expected fall-out is... <crickets>...
> 
> Hm, but still some notes are needed for ALSA-Configuration.txt
> mentioning that the resource parameters like port, io, etc can be used
> only when isapnp=no on some drivers.  The parameters are still there,
> so people may wonder if it has no use.

Okay, something like this? Incremental...

By the way, eventually I'd in fact probably like to move some of the drivers 
that now still support legacy ISA over to PnP only. After all, chips such as 
the CMI8330, CS4232+, ES1869+ and OPL3SA2 _are_ PnP only chips.

Certainly for CS4232+ and ES1869+ that can't be done currently as we know 
people are in fact using isapnp=0 to work around PnPBIOS issues but from the 
previous report there it seemed that might actually just consist of the BIOS 
claiming no resource change is possible, which pnp_activate_dev (through 
pnp_autoconfig_dev) insist on anyway. This would be something to fix inside 
PnP instead...

Anyways, here's just a further Documentation update. You once told me to 
start new threads for patches, but that seems clumsy now... :-|

Rene.


--------------030501030706070908040202
Content-Type: text/plain;
 name="alsa-kernel_isapnp_documentation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-kernel_isapnp_documentation.diff"

diff --git a/Documentation/ALSA-Configuration.txt b/Documentation/ALSA-Configuration.txt
--- a/Documentation/ALSA-Configuration.txt
+++ b/Documentation/ALSA-Configuration.txt
@@ -328,6 +328,10 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on C-Media CMI8330 ISA chips.
 
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     wssport	- port # for CMI8330 chip (WSS)
     wssirq	- IRQ # for CMI8330 chip (WSS)
     wssdma	- first DMA # for CMI8330 chip (WSS)
@@ -382,6 +386,10 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on CS4232/CS4232A ISA chips.
 
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     port	- port # for CS4232 chip (PnP setup - 0x534)
     cport	- control port # for CS4232 chip (PnP setup - 0x120,0x210,0xf00)
     mpu_port	- port # for MPU-401 UART (PnP setup - 0x300), -1 = disable
@@ -390,10 +398,10 @@ Prior to version 0.9.0rc4 options had a 
     mpu_irq	- IRQ # for MPU-401 UART (9,11,12,15)
     dma1	- first DMA # for CS4232 chip (0,1,3)
     dma2	- second DMA # for Yamaha CS4232 chip (0,1,3), -1 = disable
-    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
     
     This module supports multiple cards. This module does not support autoprobe
-    thus main port must be specified!!! Other ports are optional.
+    (if ISA PnP is not used) thus main port must be specified!!! Other ports are
+    optional.
 
     The power-management is supported.
     
@@ -402,6 +410,10 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on CS4235/CS4236/CS4236B/CS4237B/
                                    CS4238B/CS4239 ISA chips.
+
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
 
     port	- port # for CS4236 chip (PnP setup - 0x534)
     cport	- control port # for CS4236 chip (PnP setup - 0x120,0x210,0xf00)
@@ -411,7 +423,6 @@ Prior to version 0.9.0rc4 options had a 
     mpu_irq	- IRQ # for MPU-401 UART (9,11,12,15)
     dma1	- first DMA # for CS4236 chip (0,1,3)
     dma2	- second DMA # for CS4236 chip (0,1,3), -1 = disable
-    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
     
     This module supports multiple cards. This module does not support autoprobe
     (if ISA PnP is not used) thus main port and control port must be
@@ -600,13 +611,16 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for ESS AudioDrive ES-18xx sound cards.
 
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     port	- port # for ES-18xx chip (0x220,0x240,0x260)
     mpu_port	- port # for MPU-401 port (0x300,0x310,0x320,0x330), -1 = disable (default)
     fm_port	- port # for FM (optional, not used)
     irq		- IRQ # for ES-18xx chip (5,7,9,10)
     dma1	- first DMA # for ES-18xx chip (0,1,3)
     dma2	- first DMA # for ES-18xx chip (0,1,3)
-    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
 
     This module supports multiple cards, ISA PnP and autoprobe (without MPU-401
     port if native ISA PnP routines are not used).
@@ -1230,15 +1244,19 @@ Prior to version 0.9.0rc4 options had a 
     Module for Gravis UltraSound PnP, Dynasonic 3-D/Pro, STB Sound Rage 32
     and other sound cards based on AMD InterWave (tm) chip.
   
-    port	- port # for InterWave chip (0x210,0x220,0x230,0x240,0x250,0x260)
-    irq		- IRQ # for InterWave chip (3,5,9,11,12,15)
-    dma1	- DMA # for InterWave chip (0,1,3,5,6,7)
-    dma2	- DMA # for InterWave chip (0,1,3,5,6,7,-1=disable)
     joystick_dac - 0 to 31, (0.59V-4.52V or 0.389V-2.98V)
     midi	- 1 = MIDI UART enable, 0 = MIDI UART disable (default)
     pcm_voices	- reserved PCM voices for the synthesizer (default 2)
     effect	- 1 = InterWave effects enable (default 0);
                   requires 8 voices
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
+    port	- port # for InterWave chip (0x210,0x220,0x230,0x240,0x250,0x260)
+    irq		- IRQ # for InterWave chip (3,5,9,11,12,15)
+    dma1	- DMA # for InterWave chip (0,1,3,5,6,7)
+    dma2	- DMA # for InterWave chip (0,1,3,5,6,7,-1=disable)
 
     This module supports multiple cards, autoprobe and ISA PnP.
 
@@ -1249,16 +1267,20 @@ Prior to version 0.9.0rc4 options had a 
     and other sound cards based on AMD InterWave (tm) chip with TEA6330T
     circuit for extended control of bass, treble and master volume.
   
+    joystick_dac - 0 to 31, (0.59V-4.52V or 0.389V-2.98V)
+    midi	- 1 = MIDI UART enable, 0 = MIDI UART disable (default)
+    pcm_voices	- reserved PCM voices for the synthesizer (default 2)
+    effect	- 1 = InterWave effects enable (default 0);
+                  requires 8 voices
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     port	- port # for InterWave chip (0x210,0x220,0x230,0x240,0x250,0x260)
     port_tc	- tone control (i2c bus) port # for TEA6330T chip (0x350,0x360,0x370,0x380)
     irq		- IRQ # for InterWave chip (3,5,9,11,12,15)
     dma1	- DMA # for InterWave chip (0,1,3,5,6,7)
     dma2	- DMA # for InterWave chip (0,1,3,5,6,7,-1=disable)
-    joystick_dac - 0 to 31, (0.59V-4.52V or 0.389V-2.98V)
-    midi	- 1 = MIDI UART enable, 0 = MIDI UART disable (default)
-    pcm_voices	- reserved PCM voices for the synthesizer (default 2)
-    effect	- 1 = InterWave effects enable (default 0);
-                  requires 8 voices
 
     This module supports multiple cards, autoprobe and ISA PnP.
 
@@ -1446,6 +1468,10 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for Yamaha OPL3-SA2/SA3 sound cards.
 
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     port	- control port # for OPL3-SA chip (0x370)
     sb_port	- SB port # for OPL3-SA chip (0x220,0x240)
     wss_port	- WSS port # for OPL3-SA chip (0x530,0xe80,0xf40,0x604)
@@ -1454,7 +1480,6 @@ Prior to version 0.9.0rc4 options had a 
     irq		- IRQ # for OPL3-SA chip (5,7,9,10)
     dma1	- first DMA # for Yamaha OPL3-SA chip (0,1,3)
     dma2	- second DMA # for Yamaha OPL3-SA chip (0,1,3), -1 = disable
-    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
     
     This module supports multiple cards and ISA PnP.  It does not support
     autoprobe (if ISA PnP is not used) thus all ports must be specified!!!
@@ -1467,6 +1492,10 @@ Prior to version 0.9.0rc4 options had a 
     Module for sound cards based on OPTi 82c92x and Analog Devices AD1848 chips.
     Module works with OAK Mozart cards as well.
     
+    isapnp    - ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     port      - port # for WSS chip (0x530,0xe80,0xf40,0x604)
     mpu_port  - port # for MPU-401 UART (0x300,0x310,0x320,0x330)
     fm_port   - port # for OPL3 device (0x388)
@@ -1481,6 +1510,10 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on OPTi 82c92x and Crystal CS4231 chips.
     
+    isapnp    - ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     port      - port # for WSS chip (0x530,0xe80,0xf40,0x604)
     mpu_port  - port # for MPU-401 UART (0x300,0x310,0x320,0x330)
     fm_port   - port # for OPL3 device (0x388)
@@ -1496,6 +1529,10 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for sound cards based on OPTi 82c93x chips.
     
+    isapnp    - ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     port      - port # for WSS chip (0x530,0xe80,0xf40,0x604)
     mpu_port  - port # for MPU-401 UART (0x300,0x310,0x320,0x330)
     fm_port   - port # for OPL3 device (0x388)
@@ -1620,6 +1657,12 @@ Prior to version 0.9.0rc4 options had a 
 					  SoundBlaster AWE 32 (PnP),
 					  SoundBlaster AWE 64 PnP
 
+    mic_agc	- Mic Auto-Gain-Control - 0 = disable, 1 = enable (default)
+    csp		- ASP/CSP chip support - 0 = disable (default), 1 = enable
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     port	- port # for SB DSP 4.x chip (0x220,0x240,0x260)
     mpu_port	- port # for MPU-401 UART (0x300,0x330), -1 = disable
     awe_port	- base port # for EMU8000 synthesizer (0x620,0x640,0x660)
@@ -1627,9 +1670,6 @@ Prior to version 0.9.0rc4 options had a 
     irq		- IRQ # for SB DSP 4.x chip (5,7,9,10)
     dma8	- 8-bit DMA # for SB DSP 4.x chip (0,1,3)
     dma16	- 16-bit DMA # for SB DSP 4.x chip (5,6,7)
-    mic_agc	- Mic Auto-Gain-Control - 0 = disable, 1 = enable (default)
-    csp		- ASP/CSP chip support - 0 = disable (default), 1 = enable
-    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
     
     This module supports multiple cards, autoprobe and ISA PnP.
 
@@ -1712,18 +1752,21 @@ Prior to version 0.9.0rc4 options had a 
 
     Module for Turtle Beach Maui, Tropez and Tropez+ sound cards.
 
+    use_cs4232_midi - Use CS4232 MPU-401 interface
+                      (inaccessibly located inside your computer)
+    isapnp          - ISA PnP detection - 0 = disable, 1 = enable (default)
+
+    with isapnp=0, the following options are available:
+
     cs4232_pcm_port - Port # for CS4232 PCM interface.
     cs4232_pcm_irq  - IRQ # for CS4232 PCM interface (5,7,9,11,12,15).
     cs4232_mpu_port - Port # for CS4232 MPU-401 interface.
     cs4232_mpu_irq  - IRQ # for CS4232 MPU-401 interface (9,11,12,15).
-    use_cs4232_midi - Use CS4232 MPU-401 interface
-                      (inaccessibly located inside your computer)
     ics2115_port    - Port # for ICS2115
     ics2115_irq     - IRQ # for ICS2115
     fm_port         - FM OPL-3 Port #
     dma1            - DMA1 # for CS4232 PCM interface.
     dma2            - DMA2 # for CS4232 PCM interface.
-    isapnp          - ISA PnP detection - 0 = disable, 1 = enable (default)
 
     The below are options for wavefront_synth features:
     wf_raw	    - Assume that we need to boot the OS (default:no)

--------------030501030706070908040202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030501030706070908040202--
