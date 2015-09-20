From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: add Mackie Onyx Satellite quirk to
	inform wrong value in 'dbs' field in tx CIP header
Date: Sun, 20 Sep 2015 21:18:55 +0900
Message-ID: <1442751535-4175-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 443E5260502
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 14:19:00 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Mackie Onyx Satellite has two usage; standalone and with base station.

These two modes has different stream formats. In standalone mode, rx data
block includes 2 Multi Bit Linear Audio (MBLA) data channels and tx data
block includes 2. With base station, they're 6 and 2.

Although, with base station, the actual tx packet include wrong value in
'dbs' field in its CIP header. This quirk causes packet streaming layer to
detect packet discontinuity and to stop PCM substream.

This is a response of 'single' subfunction 'extended stream format
information' command in AV/C Stream Format Information Specification 1.1.
It means that a data block in tx packets includes 2 MBLA data channels.

$ ./firewire-request /dev/fw1 fcp 0x01ffbfc001000000ffffffff
response: 000: 0c ff bf c0 01 00 00 00 ff 00 90 40 03 02 01 02
response: 010: 06

Current OXFW driver parses the response and detects stream formats
correctly.

$ cat /proc/asound/card1/firewire/formation
...
Output Stream from device:
	Rate	PCM	MIDI
* 	48000	2	0
 	44100	2	0
 	88200	2	0
	96000	2	0

On the other hand, in actual tx CIP, the 'dbs' field has 6. But the number
of quadlets in CIP payload is not multiple of 6. Seeing the subtraction of
two successive payload quadlets, it should be multiple of 2.

payload  CIP      CIP
quadlets header0  header1
      24 00060052 9002ffff
      24 0006005e 9002ffff
      26 0006006a 9002ffff
      24 00060077 9002ffff
      24 00060083 9002ffff
      26 0006008f 9002ffff
      24 0006009c 9002ffff
      24 000600a8 9002ffff
      26 000600b4 9002ffff
      24 000600c1 9002ffff

This commit adds support for this quirk to OXFW driver, by using
CIP_WRONG_DBS flag. When this flag is set, packet streaming layer uses
the value of its 'data_block_quadlets' member instead of the value in CIP
header. This value is already set by OXFW driver and no discontinuity is
detected.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c |  5 ++++-
 sound/firewire/oxfw/oxfw.c        | 29 +++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.h        |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 77ad5b9..863eb4a 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -238,9 +238,12 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
 	 * packets. As a result, next isochronous packet includes more data
 	 * blocks than IEC 61883-6 defines.
 	 */
-	if (stream == &oxfw->tx_stream)
+	if (stream == &oxfw->tx_stream) {
 		oxfw->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK |
 					 CIP_JUMBO_PAYLOAD;
+		if (oxfw->wrong_dbs)
+			oxfw->tx_stream.flags |= CIP_WRONG_DBS;
+	}
 end:
 	return err;
 }
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 8c6ce01..d606e3a 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -19,6 +19,8 @@
 #define VENDOR_BEHRINGER	0x001564
 #define VENDOR_LACIE		0x00d04b
 
+#define MODEL_SATELLITE		0x00200f
+
 #define SPECIFIER_1394TA	0x00a02d
 #define VERSION_AVC		0x010001
 
@@ -129,6 +131,31 @@ static void oxfw_card_free(struct snd_card *card)
 	mutex_destroy(&oxfw->mutex);
 }
 
+static void detect_quirks(struct snd_oxfw *oxfw)
+{
+	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
+	struct fw_csr_iterator it;
+	int key, val;
+	int vendor, model;
+
+	/* Seek from Root Directory of Config ROM. */
+	vendor = model = 0;
+	fw_csr_iterator_init(&it, fw_dev->config_rom + 5);
+	while (fw_csr_iterator_next(&it, &key, &val)) {
+		if (key == CSR_VENDOR)
+			vendor = val;
+		else if (key == CSR_MODEL)
+			model = val;
+	}
+
+	/*
+	 * Mackie Onyx Satellite with base station has a quirk to report a wrong
+	 * value in 'dbs' field of CIP header against its format information.
+	 */
+	if (vendor == VENDOR_LOUD && model == MODEL_SATELLITE)
+		oxfw->wrong_dbs = true;
+}
+
 static int oxfw_probe(struct fw_unit *unit,
 		       const struct ieee1394_device_id *id)
 {
@@ -157,6 +184,8 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	detect_quirks(oxfw);
+
 	err = name_card(oxfw);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index cace5ad..7b5dad8 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -49,6 +49,7 @@ struct snd_oxfw {
 	struct mutex mutex;
 	spinlock_t lock;
 
+	bool wrong_dbs;
 	bool has_output;
 	u8 *tx_stream_formats[SND_OXFW_STREAM_FORMAT_ENTRIES];
 	u8 *rx_stream_formats[SND_OXFW_STREAM_FORMAT_ENTRIES];
-- 
2.1.4
