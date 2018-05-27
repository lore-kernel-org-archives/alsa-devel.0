From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: dice: fix stream format parameters
	for TC Electronic Studio Konnekt 48
Date: Sun, 27 May 2018 10:13:29 +0900
Message-ID: <20180527011330.9817-2-o-takashi@sakamocchi.jp>
References: <20180527011330.9817-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF352267172
 for <alsa-devel@alsa-project.org>; Sun, 27 May 2018 03:14:03 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id a22-v6so4233391pfn.6
 for <alsa-devel@alsa-project.org>; Sat, 26 May 2018 18:14:03 -0700 (PDT)
In-Reply-To: <20180527011330.9817-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

TC Electronic Studio Konnekt 48 is an application of combination of
WaveFront Dice II STD and TC Applied Technologies (TCAT) TCD2210 (Dice
Mini). The latter is on a board with BNC and optical interfaces, thus
used for signal processing for word clock, S/PDIF and ADAT. This model
doesn't support TCAT extended application protocol. For such devices,
ALSA dice driver needs to have hard-coded parameters for stream formats.

This commit fixes stream format parameters for this model. Unfortunately, at
sampling transmission frequencies over 48.0kHz, I confirmed that current
ALSA dice driver doesn't drive the device appropriately to generate sounds
(silence). I guess that this comes from timestamping quirk of Dice-based
devices, which I reported.

[alsa-devel] Dice packet sequence quirk and ALSA firewire stack in Linux 4.6
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107715.html

$ cd linux-firewire-utils/src
$ python2 crpp < /sys/bus/firewire/devices/fw1/config_rom
               ROM header and bus information block
               -----------------------------------------------------------------
400  04044a26  bus_info_length 4, crc_length 4, crc 18982
404  31333934  bus_name "1394"
408  e0ff8112  irmc 1, cmc 1, isc 1, bmc 0, pmc 0, cyc_clk_acc 255,
               max_rec 8 (512), max_rom 1, gen 1, spd 2 (S400)
40c  00016604  company_id 000166     |
410  08a65810  device_id 0408a65810  | EUI-64 0001660408a65810

               root directory
               -----------------------------------------------------------------
414  00062ab9  directory_length 6, crc 10937
418  03000166  vendor
41c  8100000a  --> descriptor leaf at 444
420  17000022  model
424  8100000f  --> descriptor leaf at 460
428  0c0087c0  node capabilities per IEEE 1394
42c  d1000001  --> unit directory at 430

               unit directory at 430
               -----------------------------------------------------------------
430  0004d5c5  directory_length 4, crc 54725
434  12000166  specifier id
438  13000001  version
43c  17000022  model
440  8100000f  --> descriptor leaf at 47c

               descriptor leaf at 444
               -----------------------------------------------------------------
444  0006c490  leaf_length 6, crc 50320
448  00000000  textual descriptor
44c  00000000  minimal ASCII
450  54432045  "TC E"
454  6c656374  "lect"
458  726f6e69  "roni"
45c  63000000  "c"

               descriptor leaf at 460
               -----------------------------------------------------------------
460  0006e08e  leaf_length 6, crc 57486
464  00000000  textual descriptor
468  00000000  minimal ASCII
46c  53747564  "Stud"
470  696f4b6f  "ioKo"
474  6e6e656b  "nnek"
478  74343800  "t48"

               descriptor leaf at 47c
               -----------------------------------------------------------------
47c  0006e08e  leaf_length 6, crc 57486
480  00000000  textual descriptor
484  00000000  minimal ASCII
488  53747564  "Stud"
48c  696f4b6f  "ioKo"
490  6e6e656b  "nnek"
494  74343800  "t48"

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-tcelectronic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice/dice-tcelectronic.c b/sound/firewire/dice/dice-tcelectronic.c
index f9e0072deb81..a4cbe2da8c15 100644
--- a/sound/firewire/dice/dice-tcelectronic.c
+++ b/sound/firewire/dice/dice-tcelectronic.c
@@ -44,8 +44,8 @@ static const struct dice_tc_spec konnekt_live = {
 };
 
 static const struct dice_tc_spec studio_konnekt_48 = {
-	.tx_pcm_chs = {{16, 16, 16}, {16, 16, 0} },
-	.rx_pcm_chs = {{16, 16, 16}, {16, 16, 0} },
+	.tx_pcm_chs = {{16, 16, 8}, {16, 16, 7} },
+	.rx_pcm_chs = {{16, 16, 8}, {14, 14, 7} },
 	.has_midi = true,
 };
 
-- 
2.14.1
