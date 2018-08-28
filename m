From: Nikhil <nik2087@gmail.com>
Subject: i.Mx35 SGTL5000 - audio hangs only on system reboot.
Date: Tue, 28 Aug 2018 13:52:18 +0530
Message-ID: <CALY=dtJpZ3vg4rYA6xct--eri7WLOAc1RZHURSYVqUKh7pgqsA@mail.gmail.com>
References: <CALY=dt+ouTPSYS+vW2bwwDQhVduG8-0AUzALk8z5S2tKdoSm8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id DA08E2676BD
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 10:22:32 +0200 (CEST)
Received: by mail-it0-f45.google.com with SMTP id t67-v6so905766ita.4
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 01:22:32 -0700 (PDT)
In-Reply-To: <CALY=dt+ouTPSYS+vW2bwwDQhVduG8-0AUzALk8z5S2tKdoSm8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am facing an issue with SGTL5000 codec which happens only on reboot.
Below are the details.

On doing a power cycle audio works fine, but if I do a "reboot", I
could see that driver probe is success, but on playing a file using
ogg, it hangs. At the moment, I am not sure where the issue is. I did
some search in Freescale/NXP forums and found there are issues related
to SGTL5000 and i2c bus on reboot, but in my case, on reboot the probe
itself is success, so I believe , its not the I2c reboot issue. Any
help as to how I can debug further or solutions is much appreciated.
Thanks in advance.

Regards
Nikhil

System details:
chip : i.Mx35
Kernel : 4.14 linux-fslc
DeviceTree :
sound {
        compatible = "fsl,imx-audio-sgtl5000";
        model = "ebox-sgtl5000";
        ssi-controller = <&ssi1>;
        audio-codec = <&codec>;
        audio-routing =
            "MIC_IN", "Mic Jack",
            "Mic Jack", "Mic Bias",
            "Headphone Jack", "HP_OUT",
            "Ext Spk", "LINE_OUT";
        mux-int-port = <1>;
        mux-ext-port = <4>;
    };
    codec: sgtl5000@0a {
           compatible = "fsl,sgtl5000";
           pinctrl-names = "default";
           pinctrl-0 = <&pinctrl_sgtl5000>;
           reg = <0x0a>;
           clocks = <&clks 86>;
           VDDA-supply = <&vcam_reg>;
           VDDIO-supply = <&reg_sgtl5000_vddd>;
    };

sgtl output:
$ dmesg | grep sgtl
[    2.416167] sgtl5000 1-000a: sgtl5000 revision 0x11
[    2.425204] sgtl5000 1-000a: Using internal LDO instead of VDDD: check ER1
[    2.562911] imx-sgtl5000 sound: sgtl5000 <-> 43fa0000.ssi mapping ok
[    3.247742]   #0: ebox-sgtl5000


dma output on reboot:
$ dmesg | grep -i dma
[    0.049859] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.710313] i2c i2c-1: can't use DMA, using PIO instead.
[    0.712794] i2c i2c-3: can't use DMA, using PIO instead.
[    0.818858] ipu-core ipu-core: private_candidate: dma0chan0 filter said false
[    0.818918] ipu-core ipu-core: private_candidate: dma0chan1 filter said false
[    0.818945] ipu-core ipu-core: private_candidate: dma0chan2 filter said false
[    0.818972] ipu-core ipu-core: private_candidate: dma0chan3 filter said false
[    0.818997] ipu-core ipu-core: private_candidate: dma0chan4 filter said false
[    0.819022] ipu-core ipu-core: private_candidate: dma0chan5 filter said false
[    0.819047] ipu-core ipu-core: private_candidate: dma0chan6 filter said false
[    0.819072] ipu-core ipu-core: private_candidate: dma0chan7 filter said false
[    0.819098] ipu-core ipu-core: private_candidate: dma0chan8 filter said false
[    0.819123] ipu-core ipu-core: private_candidate: dma0chan9 filter said false
[    0.819148] ipu-core ipu-core: private_candidate: dma0chan10 filter
said false
[    0.819174] ipu-core ipu-core: private_candidate: dma0chan11 filter
said false
[    0.819199] ipu-core ipu-core: private_candidate: dma0chan12 filter
said false
[    0.819224] ipu-core ipu-core: private_candidate: dma0chan13 filter
said false
[    0.961113] ipu-core ipu-core: IDMAC_CONF 0x70, IC_CONF 0x0,
IDMAC_CHA_EN 0x0, IDMAC_CHA_PRI 0x0, IDMAC_CHA_BUSY 0x0
[    0.961409] dma dma0chan14: Found channel 0xe, irq 176
[    0.961442] dmaengine: __dma_request_channel: success (dma0chan14)
[    0.988705] dma dma0chan14: Submitting sg d79f3b94
[    0.988776] dma dma0chan14: Updated sg d79f3b94 on channel 0xe buffer 0
[    0.988827] ipu-core ipu-core: IDMAC_CONF 0x70, IC_CONF 0x0,
IDMAC_CHA_EN 0x0, IDMAC_CHA_PRI 0x4000, IDMAC_CHA_BUSY 0x0
[    0.988885] ipu-core ipu-core: IDMAC_CONF 0x70, IC_CONF 0x0,
IDMAC_CHA_EN 0x4000, IDMAC_CHA_PRI 0x4000, IDMAC_CHA_BUSY 0x0
[    1.084868] imx-sdma 53fd4000.sdma: no event needs to be remapped
[    1.085941] imx-sdma 53fd4000.sdma: loaded firmware 1.0
[    1.934535] spi_imx 43fa4000.cspi: dma setup error -19, use pio
[    2.401179] mmc0: SDHCI controller on 53fb4000.esdhc
[53fb4000.esdhc] using DMA
[    2.472063] dmaengine: __dma_request_channel: success (dma1chan0)
[    2.472236] imx-sdma 53fd4000.sdma: private_candidate: dma1chan0 busy
[    2.472374] dmaengine: __dma_request_channel: success (dma1chan1)


sgtl5000 registers on reboot , but before playing sound file:
$ cat /sys/kernel/debug/regmap/1-000a/registers
000: a011
002: 0060
004: 0008
006: 0080
00a: 0010
00e: 020c
010: 3c3c
014: 015f
020: 0000
022: 1818
024: 0022
026: 0008
028: 01c1
02a: 0200
02c: 031c
02e: 0f0f
030: 7a60
032: 5000
034: 0800
036: 0017
03a: 0000
03c: 0000
100: 0000
102: 0000
104: 8040
106: 051f
108: 0000
10a: 0040
10c: 0000
10e: 0000
110: 0000
116: 002f
118: 002f
11a: 002f
11c: 002f
11e: 002f
120: 8000
122: 0000
124: 5100
126: 1473
128: 0028
12a: 0050
12c: 0000
12e: 0000
130: 0000
132: 0000
134: 0000
136: 0000
138: 0000
13a: 0000

ssi registers on reboot , but before playing sound file:
$ cat /sys/kernel/debug/regmap/43fa0000.ssi/registers
00: 00000000
04: 00000000
10: 00001058
18: 00003003
1c: 0000020d
20: 0000020d
24: 00040100
28: 00040100
2c: 00880088
30: 00001111
34: 00000000
38: 00000000
48: 00000000
4c: 00000000
50: 00000000
54: 00000000
58: 00000000

sgtl5000 registers on reboot , after playing sound file:
$ cat /sys/kernel/debug/regmap/1-000a/registers
000: a011
002: 0061
004: 0007
006: 0090
00a: 0010
00e: 0200
010: 3c3c
014: 015f
020: 0000
022: 1818
024: 0022
026: 0008
028: 01c1
02a: 0200
02c: 031c
02e: 0f0f
030: 7ff9
032: 786c
034: 0808
036: 0017
03a: 0000
03c: 0000
100: 0000
102: 0000
104: 8040
106: 051f
108: 0000
10a: 0040
10c: 0000
10e: 0000
110: 0000
116: 002f
118: 002f
11a: 002f
11c: 002f
11e: 002f
120: 8000
122: 0000
124: 5100
126: 1473
128: 0028
12a: 0050
12c: 0000
12e: 0000
130: 0000
132: 0000
134: 0000
136: 0000
138: 0000
13a: 0000

ssi registers on reboot ,  after playing sound file:
$ cat /sys/kernel/debug/regmap/43fa0000.ssi/registers
00: 00ffff00
04: 00000000
10: 0000105b
18: 01d035f7
1c: 0000028d
20: 0000028d
24: 00056100
28: 00040100
2c: 00880888
30: 00001111
34: 00000000
38: 00000000
48: 00000000
4c: 00000000
50: 00000000
54: 00000000
58: 00000000

dma output after playing a sound file:
[  115.626358] imx-sdma 53fd4000.sdma: load_address = 834
[  115.626482] imx-sdma 53fd4000.sdma: wml = 0x00000020
[  115.626512] imx-sdma 53fd4000.sdma: shp_addr = 0x43fa0000
[  115.626537] imx-sdma 53fd4000.sdma: per_addr = 0x00000000
[  115.626563] imx-sdma 53fd4000.sdma: event_mask0 = 0x20000000
[  115.626588] imx-sdma 53fd4000.sdma: event_mask1 = 0x00000000
[  116.072831] imx-sdma 53fd4000.sdma: sdma_prep_dma_cyclic channel: 1
[  116.072956] imx-sdma 53fd4000.sdma: load_address = 834
[  116.072984] imx-sdma 53fd4000.sdma: wml = 0x00000020
[  116.073009] imx-sdma 53fd4000.sdma: shp_addr = 0x43fa0000
[  116.073032] imx-sdma 53fd4000.sdma: per_addr = 0x00000000
[  116.073055] imx-sdma 53fd4000.sdma: event_mask0 = 0x20000000
[  116.073077] imx-sdma 53fd4000.sdma: event_mask1 = 0x00000000
[  116.073160] imx-sdma 53fd4000.sdma: entry 0: count: 1768 dma:
0x97b80000  intr
[  116.073191] imx-sdma 53fd4000.sdma: entry 1: count: 1768 dma:
0x97b806e8  intr
[  116.073219] imx-sdma 53fd4000.sdma: entry 2: count: 1768 dma:
0x97b80dd0  intr
[  116.073247] imx-sdma 53fd4000.sdma: entry 3: count: 1768 dma:
0x97b814b8 wrap int
