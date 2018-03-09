From: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Subject: Cirrus CS4207 not working on 4.14.24
Date: Fri, 9 Mar 2018 07:56:08 +0000
Message-ID: <DB5PR0701MB2007E6A97934EB7DC869DEA6A1DE0@DB5PR0701MB2007.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0100.outbound.protection.outlook.com [104.47.2.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C38A26742D
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 08:56:12 +0100 (CET)
Content-Language: es-ES
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all!


I've updated my system from a 3.16.7 kernel to a 4.14.24 kernel and sound stops working.

I have a Cirrus logic CS4207 codec. I've tracked down the problem using the '/proc/asound/card0/codec\#0'

info. With the 3.16.7 kernel all nodes power states are:


Node 0x03: Power: setting=D0, actual=D0
Node 0x0a: Power: setting=D0, actual=D0

and with 4.14.24 they are on


Node 0x03: Power: setting=D0, actual=D3
Node 0x0a: Power: setting=D3, actual=D3

Once in this situation I'm able to go to D0 again and make the sound works. I've used
hda-verb 0.4 to SET_POWER_STATE to 0 with no luck. Finally, I've patched the 4.14.24
to avoid changing to D3 and now the sound is working again. I know it's not the way to go
but I need the sound...

--- a/linux-4.14.24/sound/hda/hdac_device.c    2018-03-08 14:12:44.263575493 +0100
+++ b/linux-4.14.24/sound/hda/hdac_device.c    2018-03-08 14:12:44.263575493 +0100
@@ -1061,6 +1061,9 @@
 int snd_hdac_codec_write(struct hdac_device *hdac, hda_nid_t nid,
             int flags, unsigned int verb, unsigned int parm)
 {
+    /* Ugly patch to avoid going to low power state!! */
+    if (verb == 0x705 && parm == 0x3)
+        return 0;
     return codec_write(hdac, nid, flags, verb, parm);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_codec_write);

I've patched both kernels to show all the codec writes to show all the sequence in both

kernels. Maybe it can help to fix the problem in the correct way.


kernel 3.16.7


[   28.685789] snd_hda_intel: probe of 0000:00:01.1 failed with error -2
[   28.697622]  -- snd_hda_codec_write: nid 0x2, verb:0x705, parm:0x0
[   28.697681]  -- snd_hda_codec_write: nid 0x3, verb:0x705, parm:0x0
[   28.697726]  -- snd_hda_codec_write: nid 0x4, verb:0x705, parm:0x0
[   28.697762]  -- snd_hda_codec_write: nid 0x5, verb:0x705, parm:0x0
[   28.697807]  -- snd_hda_codec_write: nid 0x6, verb:0x705, parm:0x0
[   28.697851]  -- snd_hda_codec_write: nid 0x7, verb:0x705, parm:0x0
[   28.697887]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x0
[   28.697932]  -- snd_hda_codec_write: nid 0x9, verb:0x705, parm:0x0
[   28.697977]  -- snd_hda_codec_write: nid 0xA, verb:0x705, parm:0x0
[   28.698013]  -- snd_hda_codec_write: nid 0xC, verb:0x705, parm:0x0
[   28.698058]  -- snd_hda_codec_write: nid 0xD, verb:0x705, parm:0x0
[   28.698102]  -- snd_hda_codec_write: nid 0xF, verb:0x705, parm:0x0
[   28.698138]  -- snd_hda_codec_write: nid 0x14, verb:0x705, parm:0x0
[   28.698669] sound hdaudioC0D0: autoconfig: line_outs=1 (0xa/0x0/0x0/0x0/0x0) type:line
[   28.698673] sound hdaudioC0D0:    speaker_outs=1 (0xb/0x0/0x0/0x0/0x0)
[   28.698676] sound hdaudioC0D0:    hp_outs=1 (0x9/0x0/0x0/0x0/0x0)
[   28.698678] sound hdaudioC0D0:    mono: mono_out=0x0
[   28.698681] sound hdaudioC0D0:    dig-out=0x10/0x15
[   28.698683] sound hdaudioC0D0:    inputs:
[   28.698687] sound hdaudioC0D0:      Mic=0xd
[   28.698689] sound hdaudioC0D0:      Line=0xc
[   28.698691] sound hdaudioC0D0:    dig-in=0x12
[   28.699332]  -- snd_hda_codec_write: nid 0x9, verb:0x708, parm:0x81
[   28.699370]  -- snd_hda_codec_write: nid 0xA, verb:0x708, parm:0x82
[   28.700249]  -- snd_hda_codec_write: nid 0x1, verb:0x705, parm:0x0
[   28.700285]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x1
[   28.700330]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x8
[   28.700376]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x9999
[   28.700411]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x17
[   28.700456]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0xA412
[   28.700501]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   28.700537]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x9
[   28.700582]  -- snd_hda_codec_write: nid 0x7, verb:0x705, parm:0x0
[   28.700626]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x0
[   28.700662]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x17
[   28.700706]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x2412
[   28.700751]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x8
[   28.700785]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x0
[   28.700830]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   28.700874]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x8
[   28.700911]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x0
[   28.700956]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x1
[   28.701001]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x3
[   28.701038]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x146A
[   28.701083]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x2
[   28.701124]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0xA
[   28.701169]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   28.701226]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x7
[   28.702188]  -- snd_hda_codec_write: nid 0x3, verb:0x300, parm:0xA080
[   28.702235]  -- snd_hda_codec_write: nid 0x3, verb:0x300, parm:0x9080
[   28.702295]  -- snd_hda_codec_write: nid 0x2, verb:0x300, parm:0xA080
[   28.702330]  -- snd_hda_codec_write: nid 0x2, verb:0x300, parm:0x9080
[   28.702379]  -- snd_hda_codec_write: nid 0x4, verb:0x300, parm:0xA080
[   28.702414]  -- snd_hda_codec_write: nid 0x4, verb:0x300, parm:0x9080
[   28.702459]  -- snd_hda_codec_write: nid 0x6, verb:0x300, parm:0x6080
[   28.702497]  -- snd_hda_codec_write: nid 0x6, verb:0x300, parm:0x5080
[   28.702542]  -- snd_hda_codec_write: nid 0x5, verb:0x300, parm:0x6080
[   28.702586]  -- snd_hda_codec_write: nid 0x5, verb:0x300, parm:0x5080
[   28.702621]  -- snd_hda_codec_write: nid 0x6, verb:0x300, parm:0x6180
[   28.702666]  -- snd_hda_codec_write: nid 0x6, verb:0x300, parm:0x5180
[   28.702710]  -- snd_hda_codec_write: nid 0x5, verb:0x300, parm:0x6180
[   28.702745]  -- snd_hda_codec_write: nid 0x5, verb:0x300, parm:0x5180
[   28.702791]  -- snd_hda_codec_write: nid 0xA, verb:0x707, parm:0x40
[   28.702836]  -- snd_hda_codec_write: nid 0x9, verb:0x707, parm:0xC0
[   28.702872]  -- snd_hda_codec_write: nid 0xB, verb:0x707, parm:0x40
[   28.702917]  -- snd_hda_codec_write: nid 0xD, verb:0x707, parm:0x24
[   28.702962]  -- snd_hda_codec_write: nid 0xC, verb:0x707, parm:0x20
[   28.702998]  -- snd_hda_codec_write: nid 0x6, verb:0x701, parm:0x0
[   28.703044]  -- snd_hda_codec_write: nid 0x10, verb:0x707, parm:0x40
[   28.703081]  -- snd_hda_codec_write: nid 0x15, verb:0x707, parm:0x40
[   28.703130]  -- snd_hda_codec_write: nid 0x12, verb:0x707, parm:0x0
[   28.703185]  -- snd_hda_codec_write: nid 0xC, verb:0x708, parm:0x0
[   28.703230]  -- snd_hda_codec_write: nid 0xD, verb:0x708, parm:0x0
[   28.703275]  -- snd_hda_codec_write: nid 0xF, verb:0x708, parm:0x0
[   28.703311]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   28.703398]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   28.703434]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x1F
[   28.703479]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   28.703517]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x400A
[   28.704045]  -- snd_hda_codec_write: nid 0xD, verb:0x708, parm:0x83
[   28.704148]  -- snd_hda_codec_write: nid 0xC, verb:0x708, parm:0x84
[   28.917726]  -- snd_hda_codec_write: nid 0xB, verb:0x707, parm:0x0
[   28.917797]  -- snd_hda_codec_write: nid 0xA, verb:0x707, parm:0x0
[   29.746841]  -- snd_hda_codec_write: nid 0x3, verb:0x300, parm:0xA000
[   29.746893]  -- snd_hda_codec_write: nid 0x3, verb:0x300, parm:0x9000
[   29.746940]  -- snd_hda_codec_write: nid 0x2, verb:0x300, parm:0xA000
[   29.746991]  -- snd_hda_codec_write: nid 0x2, verb:0x300, parm:0x9000
[   29.747037]  -- snd_hda_codec_write: nid 0x4, verb:0x300, parm:0xA000
[   29.747074]  -- snd_hda_codec_write: nid 0x4, verb:0x300, parm:0x9000
[   29.761263]  -- snd_hda_codec_write: nid 0x8, verb:0x70D, parm:0x1
[   29.761322]  -- snd_hda_codec_write: nid 0x14, verb:0x70D, parm:0x1
[   29.773546]  -- snd_hda_codec_write: nid 0x3, verb:0x300, parm:0xA073
[   29.773601]  -- snd_hda_codec_write: nid 0x3, verb:0x300, parm:0x9073
[   29.773648]  -- snd_hda_codec_write: nid 0x2, verb:0x300, parm:0xA073
[   29.773693]  -- snd_hda_codec_write: nid 0x2, verb:0x300, parm:0x9073
[   29.773749]  -- snd_hda_codec_write: nid 0x4, verb:0x300, parm:0xA073
[   29.773793]  -- snd_hda_codec_write: nid 0x4, verb:0x300, parm:0x9073
[   29.779742]  -- snd_hda_codec_write: nid 0x3, verb:0x300, parm:0xA062
[   29.779829]  -- snd_hda_codec_write: nid 0x3, verb:0x300, parm:0x9062
[   29.794831]  -- snd_hda_codec_write: nid 0x8, verb:0x706, parm:0x50
[   29.796917]  -- snd_hda_codec_write: nid 0x8, verb:0x200, parm:0x31
[   29.797021]  -- snd_hda_codec_write: nid 0x14, verb:0x706, parm:0x50
[   29.798923]  -- snd_hda_codec_write: nid 0x14, verb:0x200, parm:0x31
[   29.799030]  -- snd_hda_codec_write: nid 0x3, verb:0x706, parm:0x50
[   29.800919]  -- snd_hda_codec_write: nid 0x3, verb:0x200, parm:0x31
[   29.801005]  -- snd_hda_codec_write: nid 0x2, verb:0x706, parm:0x50
[   29.802960]  -- snd_hda_codec_write: nid 0x2, verb:0x200, parm:0x31
[   29.803053]  -- snd_hda_codec_write: nid 0x4, verb:0x706, parm:0x50
[   29.804932]  -- snd_hda_codec_write: nid 0x4, verb:0x200, parm:0x31
[   33.323243] systemd-udevd[1441]: starting version 215

kernel 4.14.24


[   33.942455] snd_hda_intel: probe of 0000:00:01.1 failed with error -2
[   33.949069]  -- snd_hda_codec_write: nid 0x2, verb:0x705, parm:0x0
[   33.949105]  -- snd_hda_codec_write: nid 0x3, verb:0x705, parm:0x0
[   33.949149]  -- snd_hda_codec_write: nid 0x4, verb:0x705, parm:0x0
[   33.949196]  -- snd_hda_codec_write: nid 0x5, verb:0x705, parm:0x0
[   33.949231]  -- snd_hda_codec_write: nid 0x6, verb:0x705, parm:0x0
[   33.949275]  -- snd_hda_codec_write: nid 0x7, verb:0x705, parm:0x0
[   33.949318]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x0
[   33.949363]  -- snd_hda_codec_write: nid 0x9, verb:0x705, parm:0x0
[   33.949397]  -- snd_hda_codec_write: nid 0xA, verb:0x705, parm:0x0
[   33.949441]  -- snd_hda_codec_write: nid 0xC, verb:0x705, parm:0x0
[   33.949484]  -- snd_hda_codec_write: nid 0xD, verb:0x705, parm:0x0
[   33.949522]  -- snd_hda_codec_write: nid 0xF, verb:0x705, parm:0x0
[   33.949566]  -- snd_hda_codec_write: nid 0x14, verb:0x705, parm:0x0
[   33.950243] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4207: line_outs=1 (0xa/0x0/0x0/0x0/0x0) type:line
[   33.950245] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=1 (0xb/0x0/0x0/0x0/0x0)
[   33.950251] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=1 (0x9/0x0/0x0/0x0/0x0)
[   33.950252] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=0x0
[   33.950253] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=0x10/0x15
[   33.950254] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[   33.950256] snd_hda_codec_cirrus hdaudioC0D0:      Mic=0xd
[   33.950257] snd_hda_codec_cirrus hdaudioC0D0:      Line=0xc
[   33.950258] snd_hda_codec_cirrus hdaudioC0D0:    dig-in=0x12
[   33.951210]  -- snd_hda_codec_write: nid 0x4, verb:0x705, parm:0x3
[   33.952301]  -- snd_hda_codec_write: nid 0x1, verb:0x705, parm:0x0
[   33.952336]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x1
[   33.952381]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x8
[   33.952420]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x9999
[   33.952464]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x17
[   33.952502]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0xA412
[   33.952547]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   33.952586]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x9
[   33.952629]  -- snd_hda_codec_write: nid 0x7, verb:0x705, parm:0x0
[   33.952669]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x0
[   33.952713]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x17
[   33.952752]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x2412
[   33.952796]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x8
[   33.952835]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x0
[   33.952879]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   33.952918]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x8
[   33.952962]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x0
[   33.953006]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x1
[   33.953045]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x3
[   33.953087]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x146A
[   33.953132]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x2
[   33.953178]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0xA
[   33.953234]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   33.953273]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x7
[   33.953421]  -- snd_hda_codec_write: nid 0x3, verb:0x705, parm:0x3
[   33.953504]  -- snd_hda_codec_write: nid 0xA, verb:0x705, parm:0x3
[   33.953796]  -- snd_hda_codec_write: nid 0x2, verb:0x705, parm:0x3
[   33.953879]  -- snd_hda_codec_write: nid 0x9, verb:0x705, parm:0x3
[   33.954468]  -- snd_hda_codec_write: nid 0xD, verb:0x705, parm:0x3
[   33.955253]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x3
[   33.955378]  -- snd_hda_codec_write: nid 0x14, verb:0x705, parm:0x3
[   33.955924]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   33.956026]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   33.956065]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x1F
[   33.956109]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   33.956149]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x400A
[   33.956587]  -- snd_hda_codec_write: nid 0x7, verb:0x705, parm:0x3
[   33.956796]  -- snd_hda_codec_write: nid 0xC, verb:0x705, parm:0x3
[   33.956919]  -- snd_hda_codec_write: nid 0xF, verb:0x705, parm:0x3
[   33.957382] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:09.2/sound/card0/input5
[   33.957430] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:09.2/sound/card0/input6
[   33.957476] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:09.2/sound/card0/input7
[   33.957518] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:09.2/sound/card0/input8
[   33.970031]  -- snd_hda_codec_write: nid 0x2, verb:0x705, parm:0x3
[   33.970091]  -- snd_hda_codec_write: nid 0x3, verb:0x705, parm:0x3
[   33.970127]  -- snd_hda_codec_write: nid 0x4, verb:0x705, parm:0x3
[   33.970170]  -- snd_hda_codec_write: nid 0x5, verb:0x705, parm:0x3
[   33.970214]  -- snd_hda_codec_write: nid 0x6, verb:0x705, parm:0x3
[   33.970253]  -- snd_hda_codec_write: nid 0x7, verb:0x705, parm:0x3
[   33.970297]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x3
[   33.970336]  -- snd_hda_codec_write: nid 0x9, verb:0x705, parm:0x3
[   33.970380]  -- snd_hda_codec_write: nid 0xA, verb:0x705, parm:0x3
[   33.970420]  -- snd_hda_codec_write: nid 0xC, verb:0x705, parm:0x3
[   33.970463]  -- snd_hda_codec_write: nid 0xD, verb:0x705, parm:0x3
[   33.970502]  -- snd_hda_codec_write: nid 0xF, verb:0x705, parm:0x3
[   33.970546]  -- snd_hda_codec_write: nid 0x14, verb:0x705, parm:0x3
[   33.970693]  -- snd_hda_codec_write: nid 0x2, verb:0x705, parm:0x3
[   33.970732]  -- snd_hda_codec_write: nid 0x3, verb:0x705, parm:0x3
[   33.970775]  -- snd_hda_codec_write: nid 0x4, verb:0x705, parm:0x3
[   33.970815]  -- snd_hda_codec_write: nid 0x5, verb:0x705, parm:0x0
[   33.970858]  -- snd_hda_codec_write: nid 0x6, verb:0x705, parm:0x0
[   33.970903]  -- snd_hda_codec_write: nid 0x7, verb:0x705, parm:0x3
[   33.970942]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x3
[   33.970987]  -- snd_hda_codec_write: nid 0x9, verb:0x705, parm:0x3
[   33.971025]  -- snd_hda_codec_write: nid 0xA, verb:0x705, parm:0x3
[   33.971065]  -- snd_hda_codec_write: nid 0xC, verb:0x705, parm:0x3
[   33.971109]  -- snd_hda_codec_write: nid 0xD, verb:0x705, parm:0x3
[   33.971153]  -- snd_hda_codec_write: nid 0xF, verb:0x705, parm:0x3
[   33.971191]  -- snd_hda_codec_write: nid 0x14, verb:0x705, parm:0x3
[   33.971276]  -- snd_hda_codec_write: nid 0x1, verb:0x705, parm:0x0
[   33.971314]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x1
[   33.971358]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x8
[   33.971402]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x9999
[   33.971441]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x17
[   33.971485]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0xA412
[   33.971524]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   33.971569]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x9
[   33.971608]  -- snd_hda_codec_write: nid 0x7, verb:0x705, parm:0x0
[   33.971652]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x0
[   33.971691]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x17
[   33.971735]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x2412
[   33.971781]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x8
[   33.971815]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x0
[   33.971864]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   33.971898]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x8
[   33.971942]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x0
[   33.971987]  -- snd_hda_codec_write: nid 0x11, verb:0x703, parm:0x1
[   33.972023]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x3
[   33.972068]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x146A
[   33.972107]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x2
[   33.972151]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0xA
[   33.972189]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   33.972234]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x7
[   33.972815]  -- snd_hda_codec_write: nid 0x6, verb:0x705, parm:0x0
[   33.973004]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x3
[   33.974881]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   33.974962]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x4
[   33.975002]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x1F
[   33.975046]  -- snd_hda_codec_write: nid 0x11, verb:0x500, parm:0x1
[   33.975086]  -- snd_hda_codec_write: nid 0x11, verb:0x400, parm:0x400A
[   35.029721]  -- snd_hda_codec_write: nid 0x8, verb:0x705, parm:0x0
[   35.029816]  -- snd_hda_codec_write: nid 0x8, verb:0x706, parm:0x50
[   35.032018]  -- snd_hda_codec_write: nid 0x8, verb:0x200, parm:0x31
[   35.032108]  -- snd_hda_codec_write: nid 0x14, verb:0x705, parm:0x0
[   35.032192]  -- snd_hda_codec_write: nid 0x14, verb:0x706, parm:0x50
[   35.036014]  -- snd_hda_codec_write: nid 0x14, verb:0x200, parm:0x31
[   35.036130]  -- snd_hda_codec_write: nid 0x3, verb:0x705, parm:0x0
[   35.036253]  -- snd_hda_codec_write: nid 0x3, verb:0x706, parm:0x50
[   35.039063]  -- snd_hda_codec_write: nid 0x3, verb:0x200, parm:0x31
[   35.039155]  -- snd_hda_codec_write: nid 0x2, verb:0x705, parm:0x0
[   35.039275]  -- snd_hda_codec_write: nid 0x2, verb:0x706, parm:0x50
[   35.042023]  -- snd_hda_codec_write: nid 0x2, verb:0x200, parm:0x31
[   35.042109]  -- snd_hda_codec_write: nid 0x4, verb:0x705, parm:0x0
[   35.042192]  -- snd_hda_codec_write: nid 0x4, verb:0x706, parm:0x50
[   35.045006]  -- snd_hda_codec_write: nid 0x4, verb:0x200, parm:0x31
[   38.553348] systemd-udevd[1465]: starting version 215
