From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: firewire-motu: add support for MOTU Audio Express
Date: Sun, 20 Aug 2017 21:25:04 +0900
Message-ID: <20170820122504.24486-3-o-takashi@sakamocchi.jp>
References: <20170820122504.24486-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20170820122504.24486-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux1394-devel>,
 <mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
 <mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

MOTU Audio Express is one of third generation in MOTU FireWire
series, produced in 2011. This model consists of three chips:
 * TI TSB41AB2 (Physical layer for IEEE 1394 bus)
 * Microchip USB3300 (Hi-Speed USB Device with ULPI interface)
 * Xilinx Spartan-3A FPGA, XC3S400A (Link layer for IEEE 1394 bus, packet
   processing and data block processing layer)

This commit adds support for this model. As I expected, it works with
current implementaion of protocol version 3. On the other hand, the unit
has a quirk to request subaction originated by any driver.

11:45:51.287643 firewire_ohci 0000:03:00.0: AT spd 2 tl 1f, ffc1 -> ffc0, -reserved-, QW req, fffff0000b14 = 02000200
11:45:51.289193 firewire_ohci 0000:03:00.0: AR spd 2 tl 1f, ffc0 -> ffc1, ack_complete, W resp
11:45:51.289381 fireire_core 0000:03:00.0: unsolicited response (source ffc0, tlabel 1f)
11:45:51.313071 firewire_ohci 0000:03:00.0: AT spd 2 tl 20, ffc1 -> ffc0, ack_pending , QW req, fffff0000b14 = 02000200
11:45:51.314539 firewire_ohci 0000:03:00.0: AR spd 2 tl 20, ffc0 -> ffc1, ack_complete, W resp

In 1394 OHCI (rev.1.1), after OUTPUT_LAST* descriptors is processed,
'xferStaus' field is filled with 'ContextControl[0:15]' (see clause 7.1.3).
5 bits in LSB side of the field has ack code in acknowledge from the unit
(see clause 7.2.2). A list of the code is shown in Table 3-2.

As long as I investigated, in a case of the '-reserved-' acknowledge
message from the unit, the field has 0x10. On the table, this value is
'Reserved for definition by future 1394 standards'. As long as I know,
any specifications of IEEE 1394 has no such extensions, thus the unit is
out of specification. Besides, I note that the unit does not always
acknowledge with the invalid code. I guess this is a bug of firmware. I
confirmed the bug in firmware version 1.04 and this is the latest one.

$ cd linux-firewire-utils
$ python2 ./src/crpp < /sys/bus/firewire/devices/fw1/config_rom
               ROM header and bus information block
               -----------------------------------------------------------------
400  0410a756  bus_info_length 4, crc_length 16, crc 42838
404  31333934  bus_name "1394"
408  20ff7000  irmc 0, cmc 0, isc 1, bmc 0, cyc_clk_acc 255, max_rec 7 (256)
40c  0001f200  company_id 0001f2     |
410  000a8a7b  device_id 00000a8a7b  | EUI-64 0001f200000a8a7b

               root directory
               -----------------------------------------------------------------
414  0004ef04  directory_length 4, crc 61188
418  030001f2  vendor
41c  0c0083c0  node capabilities per IEEE 1394
420  d1000002  --> unit directory at 428
424  8d000005  --> eui-64 leaf at 438

               unit directory at 428
               -----------------------------------------------------------------
428  00031680  directory_length 3, crc 5760
42c  120001f2  specifier id
430  13000033  version
434  17104800  model

               eui-64 leaf at 438
               -----------------------------------------------------------------
438  00025ef3  leaf_length 2, crc 24307
43c  0001f200  company_id 0001f2     |
440  000a8a7b  device_id 00000a8a7b  | EUI-64 0001f200000a8a7b

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 13d26e36fe00..fddeb11283c3 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -224,6 +224,18 @@ static struct snd_motu_spec motu_828mk3 = {
 	.analog_out_ports = 8,
 };
 
+static struct snd_motu_spec motu_audio_express = {
+	.name = "AudioExpress",
+	.protocol = &snd_motu_protocol_v3,
+	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
+		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
+		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
+		 SND_MOTU_SPEC_RX_MIDI_2ND_Q |
+		 SND_MOTU_SPEC_TX_MIDI_3RD_Q,
+	.analog_in_ports = 2,
+	.analog_out_ports = 4,
+};
+
 #define SND_MOTU_DEV_ENTRY(model, data)			\
 {							\
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID |	\
@@ -239,6 +251,7 @@ static const struct ieee1394_device_id motu_id_table[] = {
 	SND_MOTU_DEV_ENTRY(0x101800, &motu_828mk2),
 	SND_MOTU_DEV_ENTRY(0x106800, &motu_828mk3),	/* FireWire only. */
 	SND_MOTU_DEV_ENTRY(0x100800, &motu_828mk3),	/* Hybrid. */
+	SND_MOTU_DEV_ENTRY(0x104800, &motu_audio_express),
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, motu_id_table);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
