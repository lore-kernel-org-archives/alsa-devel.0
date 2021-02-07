Return-Path: <SRS0=N3b0=HJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67463C433E0
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Feb 2021 15:48:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A436A64D9A
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Feb 2021 15:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A436A64D9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 473371677;
	Sun,  7 Feb 2021 16:47:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 473371677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612712924;
	bh=oY7VC/JTgBhdEjqACva8TPEOPWGsfmGreiExo/BzNkc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JT1g7GMQEcAPyN9TFSfpPMdgF6Nc99/byRX0Hpz99NH1YEqK7LqgzY+RWAWgG3M7K
	 +iuEXNClVbDzvbhZpgIH88YLs6aW1jq5R1ccHZYekrfKYVBaCSJnSIjdb2hTiZERPB
	 UbCa8bH6bnooNwD6MchLrO8Nt2IuwFGSLektUUjU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0486F8016B;
	Sun,  7 Feb 2021 16:47:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87F4EF801D5; Sun,  7 Feb 2021 16:47:52 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D73ABF8013A
 for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2021 16:47:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D73ABF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="oiVsmjcV"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="AML2yacg"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 323E95C009F;
 Sun,  7 Feb 2021 10:47:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 07 Feb 2021 10:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=STU5izWa5EN9MHYCLgFA4N7fdh
 D3CCvIiAKG9jEwYpE=; b=oiVsmjcVCAF89vKYGTwSwNS0sByBSh3a/dAT9bgj/2
 bqOKHlKKdWzjc9PEr8AxEC3PpYhvA5bPeYvY2xx7MVYW07+Z/fNn5X7wYWThNTiS
 lmUKDXcjTKgjPSlAqYPVMaWNsQT7QcchFiC+b7AptHTMjxZhGvDk5ynHl3XezXhI
 KkuTw7usogQaUsTRvhFcaQUan//DAbRRlCVCRtO9XNyzEsSYHCKpgW7++YRKpABc
 /+xu/48P9fMRMSJG2n0vAANaenhZ3y/+jncItcZqsfmkWNPEyOKQnK6iAK4fZCsY
 9jJ/0USkBa9G93Ll/PEJDWeHRgOEB1bJQcBV+IV5/POQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=STU5izWa5EN9MHYCL
 gFA4N7fdhD3CCvIiAKG9jEwYpE=; b=AML2yacgv8YWbWzjmTqGrvyPW3yBo/iDJ
 dpetAKo1h06ifw60KyEbwWu8hc5XID9YAUKZrvLq2iBk1XmB4Wi1GNSF+bUZZbi6
 7gg92mZEnRmwlV9Ynsduqkyw3LSbblIAVBQTVvdvpDI9N/MGOzhWRwz1aTu/PI5/
 MjxdSx8NrBayEYnhu91aHsxvahskOdUQE7G+fhTQ9JszUESKzzEDzcH7WdMMhotx
 bdDhnt9WV0pKn6W61vJZUJPSdIogBVQaXjTKyUXQOwKFHuFD+TFd6l18sIka62DJ
 UY7TBAPgk05Rkah+5TEYUrA09AzmQnwJ7bfKMGXlXWKiXwuMAjfgw==
X-ME-Sender: <xms:nAsgYNZbZ-bOSoo5U5sb8AZBettNkUeTtOmPUp7oKXGLTYGWK_Fbsw>
 <xme:nAsgYEZ6wnv0wBDdoVkdWUQf4tqZzajzvq8vXj0oMmKC3dnkP8xBBmKfCk_AARqfg
 4eZl6GsCibhiUwfJlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrhedugdekvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
 sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedujeetlefhtddtke
 fgtdeuieelhffgteejjeehkeegveduvdevgeeiheeuueekjeenucfkphepudegrdefrdei
 hedrudejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:nAsgYP9Lkc-kQ3lwBWqWifiyG67TSp_4HJDxhpG4SfsTecIbUdY3Lw>
 <xmx:nAsgYLrhG2FC8MskkahDvAImcw_kpxXjBkaa75l9teeFtFshs60g7w>
 <xmx:nAsgYIr8ZwU3aXRdGiZ4tOHFs7k9QnjI7_jDnlKe4TBsuX4HOqzFQQ>
 <xmx:nQsgYFCqAxcyAPWsDfM2n8wb_yzHXdbYrBFPVGSqfE7L5lHKYhxrEg>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5D3FC1080057;
 Sun,  7 Feb 2021 10:47:39 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH] ALSA: fireface: fix to parse sync status register of latter
 protocol
Date: Mon,  8 Feb 2021 00:47:36 +0900
Message-Id: <20210207154736.229551-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, stable@vger.kernel.org
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Fireface UCX, UFX, and FF802 are categorized for latter protocol of the
series. Current support for FF802 (and UFX) includes failure to parse
sync status register and results in EIO.

Further investigation figures out that the content of register differs
depending on models. This commit adds tables specific to FF802 and UFX
to fix it.

Fixes: 062bb452b078b ("ALSA: fireface: add support for RME FireFace 802")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-latter.c | 118 ++++++++++++++++---
 1 file changed, 100 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
index 8d3b23778eb2..7ddb7b97f02d 100644
--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -15,6 +15,61 @@
 #define LATTER_FETCH_MODE	0xffff00000010ULL
 #define LATTER_SYNC_STATUS	0x0000801c0000ULL
 
+// The content of sync status register differs between models.
+//
+// Fireface UCX:
+//  0xf0000000: (unidentified)
+//  0x0f000000: effective rate of sampling clock
+//  0x00f00000: detected rate of word clock on BNC interface
+//  0x000f0000: detected rate of ADAT or S/PDIF on optical interface
+//  0x0000f000: detected rate of S/PDIF on coaxial interface
+//  0x00000e00: effective source of sampling clock
+//    0x00000e00: Internal
+//    0x00000800: (unidentified)
+//    0x00000600: Word clock on BNC interface
+//    0x00000400: ADAT on optical interface
+//    0x00000200: S/PDIF on coaxial or optical interface
+//  0x00000100: Optical interface is used for ADAT signal
+//  0x00000080: (unidentified)
+//  0x00000040: Synchronized to word clock on BNC interface
+//  0x00000020: Synchronized to ADAT or S/PDIF on optical interface
+//  0x00000010: Synchronized to S/PDIF on coaxial interface
+//  0x00000008: (unidentified)
+//  0x00000004: Lock word clock on BNC interface
+//  0x00000002: Lock ADAT or S/PDIF on optical interface
+//  0x00000001: Lock S/PDIF on coaxial interface
+//
+// Fireface 802 (and perhaps UFX):
+//   0xf0000000: effective rate of sampling clock
+//   0x0f000000: detected rate of ADAT-B on 2nd optical interface
+//   0x00f00000: detected rate of ADAT-A on 1st optical interface
+//   0x000f0000: detected rate of AES/EBU on XLR or coaxial interface
+//   0x0000f000: detected rate of word clock on BNC interface
+//   0x00000e00: effective source of sampling clock
+//     0x00000e00: internal
+//     0x00000800: ADAT-B
+//     0x00000600: ADAT-A
+//     0x00000400: AES/EBU
+//     0x00000200: Word clock
+//   0x00000080: Synchronized to ADAT-B on 2nd optical interface
+//   0x00000040: Synchronized to ADAT-A on 1st optical interface
+//   0x00000020: Synchronized to AES/EBU on XLR or 2nd optical interface
+//   0x00000010: Synchronized to word clock on BNC interface
+//   0x00000008: Lock ADAT-B on 2nd optical interface
+//   0x00000004: Lock ADAT-A on 1st optical interface
+//   0x00000002: Lock AES/EBU on XLR or 2nd optical interface
+//   0x00000001: Lock word clock on BNC interface
+//
+// The pattern for rate bits:
+//   0x00: 32.0 kHz
+//   0x01: 44.1 kHz
+//   0x02: 48.0 kHz
+//   0x04: 64.0 kHz
+//   0x05: 88.2 kHz
+//   0x06: 96.0 kHz
+//   0x08: 128.0 kHz
+//   0x09: 176.4 kHz
+//   0x0a: 192.0 kHz
 static int parse_clock_bits(u32 data, unsigned int *rate,
 			    enum snd_ff_clock_src *src,
 			    enum snd_ff_unit_version unit_version)
@@ -23,35 +78,48 @@ static int parse_clock_bits(u32 data, unsigned int *rate,
 		unsigned int rate;
 		u32 flag;
 	} *rate_entry, rate_entries[] = {
-		{ 32000,	0x00000000, },
-		{ 44100,	0x01000000, },
-		{ 48000,	0x02000000, },
-		{ 64000,	0x04000000, },
-		{ 88200,	0x05000000, },
-		{ 96000,	0x06000000, },
-		{ 128000,	0x08000000, },
-		{ 176400,	0x09000000, },
-		{ 192000,	0x0a000000, },
+		{ 32000,	0x00, },
+		{ 44100,	0x01, },
+		{ 48000,	0x02, },
+		{ 64000,	0x04, },
+		{ 88200,	0x05, },
+		{ 96000,	0x06, },
+		{ 128000,	0x08, },
+		{ 176400,	0x09, },
+		{ 192000,	0x0a, },
 	};
 	static const struct {
 		enum snd_ff_clock_src src;
 		u32 flag;
-	} *clk_entry, clk_entries[] = {
+	} *clk_entry, *clk_entries, ucx_clk_entries[] = {
 		{ SND_FF_CLOCK_SRC_SPDIF,	0x00000200, },
 		{ SND_FF_CLOCK_SRC_ADAT1,	0x00000400, },
 		{ SND_FF_CLOCK_SRC_WORD,	0x00000600, },
 		{ SND_FF_CLOCK_SRC_INTERNAL,	0x00000e00, },
+	}, ufx_ff802_clk_entries[] = {
+		{ SND_FF_CLOCK_SRC_WORD,	0x00000200, },
+		{ SND_FF_CLOCK_SRC_SPDIF,	0x00000400, },
+		{ SND_FF_CLOCK_SRC_ADAT1,	0x00000600, },
+		{ SND_FF_CLOCK_SRC_ADAT2,	0x00000800, },
+		{ SND_FF_CLOCK_SRC_INTERNAL,	0x00000e00, },
 	};
+	u32 rate_bits;
+	unsigned int clk_entry_count;
 	int i;
 
-	if (unit_version != SND_FF_UNIT_VERSION_UCX) {
-		// e.g. 0x00fe0f20 but expected 0x00eff002.
-		data = ((data & 0xf0f0f0f0) >> 4) | ((data & 0x0f0f0f0f) << 4);
+	if (unit_version == SND_FF_UNIT_VERSION_UCX) {
+		rate_bits = (data & 0x0f000000) >> 24;
+		clk_entries = ucx_clk_entries;
+		clk_entry_count = ARRAY_SIZE(ucx_clk_entries);
+	} else {
+		rate_bits = (data & 0xf0000000) >> 28;
+		clk_entries = ufx_ff802_clk_entries;
+		clk_entry_count = ARRAY_SIZE(ufx_ff802_clk_entries);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(rate_entries); ++i) {
 		rate_entry = rate_entries + i;
-		if ((data & 0x0f000000) == rate_entry->flag) {
+		if (rate_bits == rate_entry->flag) {
 			*rate = rate_entry->rate;
 			break;
 		}
@@ -59,14 +127,14 @@ static int parse_clock_bits(u32 data, unsigned int *rate,
 	if (i == ARRAY_SIZE(rate_entries))
 		return -EIO;
 
-	for (i = 0; i < ARRAY_SIZE(clk_entries); ++i) {
+	for (i = 0; i < clk_entry_count; ++i) {
 		clk_entry = clk_entries + i;
 		if ((data & 0x000e00) == clk_entry->flag) {
 			*src = clk_entry->src;
 			break;
 		}
 	}
-	if (i == ARRAY_SIZE(clk_entries))
+	if (i == clk_entry_count)
 		return -EIO;
 
 	return 0;
@@ -249,16 +317,22 @@ static void latter_dump_status(struct snd_ff *ff, struct snd_info_buffer *buffer
 		char *const label;
 		u32 locked_mask;
 		u32 synced_mask;
-	} *clk_entry, clk_entries[] = {
+	} *clk_entry, *clk_entries, ucx_clk_entries[] = {
 		{ "S/PDIF",	0x00000001, 0x00000010, },
 		{ "ADAT",	0x00000002, 0x00000020, },
 		{ "WDClk",	0x00000004, 0x00000040, },
+	}, ufx_ff802_clk_entries[] = {
+		{ "WDClk",	0x00000001, 0x00000010, },
+		{ "AES/EBU",	0x00000002, 0x00000020, },
+		{ "ADAT-A",	0x00000004, 0x00000040, },
+		{ "ADAT-B",	0x00000008, 0x00000080, },
 	};
 	__le32 reg;
 	u32 data;
 	unsigned int rate;
 	enum snd_ff_clock_src src;
 	const char *label;
+	unsigned int clk_entry_count;
 	int i;
 	int err;
 
@@ -270,7 +344,15 @@ static void latter_dump_status(struct snd_ff *ff, struct snd_info_buffer *buffer
 
 	snd_iprintf(buffer, "External source detection:\n");
 
-	for (i = 0; i < ARRAY_SIZE(clk_entries); ++i) {
+	if (ff->unit_version == SND_FF_UNIT_VERSION_UCX) {
+		clk_entries = ucx_clk_entries;
+		clk_entry_count = ARRAY_SIZE(ucx_clk_entries);
+	} else {
+		clk_entries = ufx_ff802_clk_entries;
+		clk_entry_count = ARRAY_SIZE(ufx_ff802_clk_entries);
+	}
+
+	for (i = 0; i < clk_entry_count; ++i) {
 		clk_entry = clk_entries + i;
 		snd_iprintf(buffer, "%s: ", clk_entry->label);
 		if (data & clk_entry->locked_mask) {
-- 
2.27.0

