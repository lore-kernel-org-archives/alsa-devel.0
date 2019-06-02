From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/15] ALSA: fireface: support
	allocate_resources operation in latter protocol
Date: Sun,  2 Jun 2019 16:12:55 +0900
Message-ID: <20190602071259.21622-12-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DAE0F89741
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:22 +0200 (CEST)
In-Reply-To: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit is a part of preparation to perform allocation/release
of isochronous channels in pcm.hw_params/hw_free callbacks.

This commit implements allocate_resources callback for the protocol
specific to latter models. The encoded values of constant table is
split into several condition statements to separate the operation
to configure sampling transfer frequency from the operation to
configure the number of data channels in rx packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-latter.c | 113 +++++++++----------
 1 file changed, 56 insertions(+), 57 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
index c8236ff89b7f..3d12ba5b2a9b 100644
--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -97,25 +97,64 @@ static int latter_switch_fetching_mode(struct snd_ff *ff, bool enable)
 				  LATTER_FETCH_MODE, &reg, sizeof(reg), 0);
 }
 
-static int keep_resources(struct snd_ff *ff, unsigned int rate)
+static int latter_allocate_resources(struct snd_ff *ff, unsigned int rate)
 {
 	enum snd_ff_stream_mode mode;
+	unsigned int code;
+	__le32 reg;
+	unsigned int count;
 	int i;
 	int err;
 
-	// Check whether the given value is supported or not.
-	for (i = 0; i < CIP_SFC_COUNT; i++) {
-		if (amdtp_rate_table[i] == rate)
+	// Set the number of data blocks transferred in a second.
+	if (rate % 32000 == 0)
+		code = 0x00;
+	else if (rate % 44100 == 0)
+		code = 0x02;
+	else if (rate % 48000 == 0)
+		code = 0x04;
+	else
+		return -EINVAL;
+
+	if (rate >= 64000 && rate < 128000)
+		code |= 0x08;
+	else if (rate >= 128000 && rate < 192000)
+		code |= 0x10;
+
+	reg = cpu_to_le32(code);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 LATTER_STF, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	// Confirm to shift transmission clock.
+	count = 0;
+	while (count++ < 10) {
+		unsigned int curr_rate;
+		enum snd_ff_clock_src src;
+
+		err = latter_get_clock(ff, &curr_rate, &src);
+		if (err < 0)
+			return err;
+
+		if (curr_rate == rate)
 			break;
 	}
-	if (i >= CIP_SFC_COUNT)
+	if (count == 10)
+		return -ETIMEDOUT;
+
+	for (i = 0; i < ARRAY_SIZE(amdtp_rate_table); ++i) {
+		if (rate == amdtp_rate_table[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(amdtp_rate_table))
 		return -EINVAL;
 
 	err = snd_ff_stream_get_multiplier_mode(i, &mode);
 	if (err < 0)
 		return err;
 
-	/* Keep resources for in-stream. */
+	// Keep resources for in-stream.
 	ff->tx_resources.channels_mask = 0x00000000000000ffuLL;
 	err = fw_iso_resources_allocate(&ff->tx_resources,
 			amdtp_stream_get_max_payload(&ff->tx_stream),
@@ -123,7 +162,7 @@ static int keep_resources(struct snd_ff *ff, unsigned int rate)
 	if (err < 0)
 		return err;
 
-	/* Keep resources for out-stream. */
+	// Keep resources for out-stream.
 	ff->rx_resources.channels_mask = 0x00000000000000ffuLL;
 	err = fw_iso_resources_allocate(&ff->rx_resources,
 			amdtp_stream_get_max_payload(&ff->rx_stream),
@@ -136,61 +175,20 @@ static int keep_resources(struct snd_ff *ff, unsigned int rate)
 
 static int latter_begin_session(struct snd_ff *ff, unsigned int rate)
 {
-	static const struct {
-		unsigned int stf;
-		unsigned int code;
-		unsigned int flag;
-	} *entry, rate_table[] = {
-		{ 32000,  0x00, 0x92, },
-		{ 44100,  0x02, 0x92, },
-		{ 48000,  0x04, 0x92, },
-		{ 64000,  0x08, 0x8e, },
-		{ 88200,  0x0a, 0x8e, },
-		{ 96000,  0x0c, 0x8e, },
-		{ 128000, 0x10, 0x8c, },
-		{ 176400, 0x12, 0x8c, },
-		{ 192000, 0x14, 0x8c, },
-	};
+	unsigned int flag;
 	u32 data;
 	__le32 reg;
-	unsigned int count;
-	int i;
 	int err;
 
-	for (i = 0; i < ARRAY_SIZE(rate_table); ++i) {
-		entry = rate_table + i;
-		if (entry->stf == rate)
-			break;
-	}
-	if (i == ARRAY_SIZE(rate_table))
+	if (rate >= 32000 && rate <= 48000)
+		flag = 0x92;
+	else if (rate >= 64000 && rate <= 96000)
+		flag = 0x8e;
+	else if (rate >= 128000 && rate <= 192000)
+		flag = 0x8c;
+	else
 		return -EINVAL;
 
-	reg = cpu_to_le32(entry->code);
-	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 LATTER_STF, &reg, sizeof(reg), 0);
-	if (err < 0)
-		return err;
-
-	// Confirm to shift transmission clock.
-	count = 0;
-	while (count++ < 10) {
-		unsigned int curr_rate;
-		enum snd_ff_clock_src src;
-
-		err = latter_get_clock(ff, &curr_rate, &src);
-		if (err < 0)
-			return err;
-
-		if (curr_rate == rate)
-			break;
-	}
-	if (count == 10)
-		return -ETIMEDOUT;
-
-	err = keep_resources(ff, rate);
-	if (err < 0)
-		return err;
-
 	data = (ff->tx_resources.channel << 8) | ff->rx_resources.channel;
 	reg = cpu_to_le32(data);
 	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
@@ -200,7 +198,7 @@ static int latter_begin_session(struct snd_ff *ff, unsigned int rate)
 
 	// Always use the maximum number of data channels in data block of
 	// packet.
-	reg = cpu_to_le32(entry->flag);
+	reg = cpu_to_le32(flag);
 	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
 				  LATTER_ISOC_START, &reg, sizeof(reg), 0);
 }
@@ -424,6 +422,7 @@ const struct snd_ff_protocol snd_ff_protocol_latter = {
 	.fill_midi_msg		= latter_fill_midi_msg,
 	.get_clock		= latter_get_clock,
 	.switch_fetching_mode	= latter_switch_fetching_mode,
+	.allocate_resources	= latter_allocate_resources,
 	.begin_session		= latter_begin_session,
 	.finish_session		= latter_finish_session,
 	.dump_status		= latter_dump_status,
-- 
2.20.1
