Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27294C33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:49:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2609C20801
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qssLLXcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2609C20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCB90174B;
	Sun,  5 Jan 2020 15:48:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCB90174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578235771;
	bh=4Z8+dVOtfKUnUWFyzE3mOW5ypHNHGNUBcH9FwXiXPcU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qssLLXcmF0usD1oK4TWAosugwtepQc6BQoQHP/E3VWSYYga6gpyPXLJ7o9lsN7PUT
	 OHcvsFusm6FRK7Ozzh+QGSBoxslJeUvI39dL3AcjVEmsMitOTGMfjTDCZY/SIIkhhA
	 1YlZFsxLVLQC6w2lRF5kbw8oiQljN7D5kFReNTJw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C99BF802DD;
	Sun,  5 Jan 2020 15:48:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09CAFF80278; Sun,  5 Jan 2020 15:48:35 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8379F80116
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8379F80116
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A2458ADF0
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:31 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:17 +0100
Message-Id: <20200105144823.29547-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 02/68] ALSA: aoa: More constifications
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Apply const prefix at every place where appropriate: the static
register tables, the volume tables and the callback tables.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/aoa/codecs/onyx.c           | 4 ++--
 sound/aoa/codecs/tas-basstreble.h | 4 ++--
 sound/aoa/codecs/tas-gain-table.h | 2 +-
 sound/aoa/soundbus/i2sbus/core.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index f85bc8a1e2a6..12028b3e2eee 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -543,7 +543,7 @@ static const struct snd_kcontrol_new onyx_spdif_ctrl = {
 
 /* our registers */
 
-static u8 register_map[] = {
+static const u8 register_map[] = {
 	ONYX_REG_DAC_ATTEN_LEFT,
 	ONYX_REG_DAC_ATTEN_RIGHT,
 	ONYX_REG_CONTROL,
@@ -559,7 +559,7 @@ static u8 register_map[] = {
 	ONYX_REG_DIG_INFO4
 };
 
-static u8 initial_values[ARRAY_SIZE(register_map)] = {
+static const u8 initial_values[ARRAY_SIZE(register_map)] = {
 	0x80, 0x80, /* muted */
 	ONYX_MRST | ONYX_SRST, /* but handled specially! */
 	ONYX_MUTE_LEFT | ONYX_MUTE_RIGHT,
diff --git a/sound/aoa/codecs/tas-basstreble.h b/sound/aoa/codecs/tas-basstreble.h
index 770935af66af..14dc4e9eea73 100644
--- a/sound/aoa/codecs/tas-basstreble.h
+++ b/sound/aoa/codecs/tas-basstreble.h
@@ -13,7 +13,7 @@
 #define TAS3004_TREBLE_ZERO	36
 #define TAS3004_BASS_ZERO	36
 
-static u8 tas3004_treble_table[] = {
+static const u8 tas3004_treble_table[] = {
 	150, /* -18 dB */
 	149,
 	148,
@@ -99,7 +99,7 @@ static inline u8 tas3004_treble(int idx)
  * I have also ignored completely differences of
  * +/- 1
  */
-static s8 tas3004_bass_diff_to_treble[] = {
+static const s8 tas3004_bass_diff_to_treble[] = {
 	2, /* 7 dB, offset 50 */
 	2,
 	2,
diff --git a/sound/aoa/codecs/tas-gain-table.h b/sound/aoa/codecs/tas-gain-table.h
index 77b8e7dc55fd..c9ea01488181 100644
--- a/sound/aoa/codecs/tas-gain-table.h
+++ b/sound/aoa/codecs/tas-gain-table.h
@@ -27,7 +27,7 @@ int main() {
  * as easy as calculating
  *      hwvalue = 1048576.0*exp(0.057564628*dB*2)
  * :) */
-static int tas_gaintable[] = {
+static const int tas_gaintable[] = {
 	0x000000, /* -infinity dB */
 	0x00014b, /* -70.0 dB */
 	0x00015f, /* -69.5 dB */
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 17df288fbe98..faf6b03131ee 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -160,7 +160,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	static const char *rnames[] = { "i2sbus: %pOFn (control)",
 					"i2sbus: %pOFn (tx)",
 					"i2sbus: %pOFn (rx)" };
-	static irq_handler_t ints[] = {
+	static const irq_handler_t ints[] = {
 		i2sbus_bus_intr,
 		i2sbus_tx_intr,
 		i2sbus_rx_intr
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
