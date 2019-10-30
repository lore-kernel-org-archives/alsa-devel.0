Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490FBCA9EAF
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:11:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66D020874
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H2kJ9khd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="o1DhWeAe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zw28uc10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66D020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27B2722FC;
	Wed, 30 Oct 2019 09:10:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27B2722FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572423086;
	bh=TuTBf8UHTFkPI2Zz0aXZFKvu/DZ8kGCbrBwbPImKlPY=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2kJ9khdBPEZ5zRFV70zZ/L34CTvMkm/q9e+9UDMLUQe6/H29wZm3oa5Y5kNHiEeD
	 LrAO6SwyL8HA9IBAZjALuWrI6rinDI2Jx7XXdfK/oAzWZAau0uRs1Hg0rMCAKKEYjH
	 QwIgrYmOupSXrO5jWar+TVrVLwEzTHLcF0NzUUgM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0922DF8063D;
	Wed, 30 Oct 2019 09:07:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E48B9F805FD; Wed, 30 Oct 2019 09:07:00 +0100 (CET)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F19C5F805A9
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 09:06:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F19C5F805A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="o1DhWeAe"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Zw28uc10"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 25E5921EAE;
 Wed, 30 Oct 2019 04:06:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 30 Oct 2019 04:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=3RL7AnV/Y4fAz
 W3UhGKbpdplYOj2TSdVr3pvq12p/ic=; b=o1DhWeAeXUo89XBqJ99iJMh2egJFg
 j0tmXU6mSF2F9W4e3KMVTYUGRavAUzUdYsbDwnVEnLXu1CojNFPzWubtTbXAc4bI
 gMY/AC6Q+o5njaWKGTO+0UNgWThsA3okJD+pWMyRNJtibzHhACraVQiRUBjAfiNJ
 8bIaNKN6Vp9Vt6d3iFhAz8yvHySKDb+GQhgpla4o9jMz/FLmmW6yaMDCbHanzENJ
 ISmdOo2pRuiQbmSnhO7rqcq+eiiJTxSZSXZvtUxoq+Vmk5wRcSpATHGAxxUTB8Y5
 /K9bn2s0Lza6aVCqUvr4f88QnrLOxrxM2DTWv5/9/AA/bck/PamFP5LNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=3RL7AnV/Y4fAzW3UhGKbpdplYOj2TSdVr3pvq12p/ic=; b=Zw28uc10
 rmO6Ro/BbegpZnyEvExv+azuPXB3H8SCsaKuiy8Nwz54ipFxbL9qp7AD9oVCLa4C
 4MTSE2acE78gyjBbPBjhsmYEaP+PFP3Ws+TqpRV3aaEx6DbEierasTFboP1jx9WT
 y+vIFvC/I83BkuQz2yTS+uWCChT9QRVPiTnSVdR7xcLo9C57qdk8uA6eqGmUU13E
 6vuE0Otv8rC62KmYU2lVLUVTB0s8YD1VXH0d4k+GhJrXFd9xFpmO1zKHCIh/rFG6
 9nKRR3hyyGjykB9dOFZC5Smh/7M/+eLdcH8cqUWDZxN2pOKQq0oPWBjY6gDpYR4x
 1+3ONXT3Kb1ORA==
X-ME-Sender: <xms:n0S5XYFK-mxx7S2ClMIdsXhQI47LYL3s_LE1BwMVIuzhbjmju-Pz8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddtvddguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekud
 enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
 hhhirdhjphenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:oES5XVTXUQ0aYUTIatbQ-7P6-LqlGDMUfDdlpxaeJYQq7QiOV1twjw>
 <xmx:oES5XX-QQz7LEtrugmUfM1VpCKVtU1Pp7AWRJ2DtZjtk8vssqbVT2Q>
 <xmx:oES5XYgZ3Hr7CFcDEthu9DRNeNguAKlXDCpwETjG1ezwUpWBvX1vjw>
 <xmx:oES5XQ_igzTlP15EbXK48CObVycnpefAR1mKaG1n1edRQEJKLUXTUQ>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id CB8363060057;
 Wed, 30 Oct 2019 04:06:54 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Wed, 30 Oct 2019 17:06:43 +0900
Message-Id: <20191030080644.1704-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030080644.1704-1-o-takashi@sakamocchi.jp>
References: <20191030080644.1704-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 5/6] ALSA: firewire-motu: code refactoring to
	handle model specific switch for protocol v2
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

In MOTU FireWire series, devices which support protocol version 2 have
several types of hardware design to process audio data frames for isoc
packet. Roughly devices are categorized into three groups:
 - 828mkII
 - Traveler/896HD
 - UltraLite/8pre FireWire

Some bit flags in register addressed by 0x'ffff'f000'0b14
includes device-specific effects.

This commit cleanups implementation of protocol v2 in this point.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 72 +++++++++++++-------------
 sound/firewire/motu/motu.c             | 12 ++---
 sound/firewire/motu/motu.h             |  3 +-
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index cb0e58a9f33d..619b6ae73f62 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -12,10 +12,8 @@
 #define  V2_CLOCK_RATE_SHIFT			3
 #define  V2_CLOCK_SRC_MASK			0x00000007
 #define  V2_CLOCK_SRC_SHIFT			0
-#define  V2_CLOCK_TRAVELER_FETCH_DISABLE	0x04000000
-#define  V2_CLOCK_TRAVELER_FETCH_ENABLE		0x03000000
-#define  V2_CLOCK_8PRE_FETCH_DISABLE		0x02000000
-#define  V2_CLOCK_8PRE_FETCH_ENABLE		0x00000000
+#define  V2_CLOCK_FETCH_ENABLE			0x02000000
+#define  V2_CLOCK_MODEL_SPECIFIC		0x04000000
 
 #define V2_IN_OUT_CONF_OFFSET			0x0c04
 #define  V2_OPT_OUT_IFACE_MASK			0x00000c00
@@ -73,11 +71,6 @@ static int v2_set_clock_rate(struct snd_motu *motu, unsigned int rate)
 	data &= ~V2_CLOCK_RATE_MASK;
 	data |= i << V2_CLOCK_RATE_SHIFT;
 
-	if (motu->spec == &snd_motu_spec_traveler) {
-		data &= ~V2_CLOCK_TRAVELER_FETCH_ENABLE;
-		data |= V2_CLOCK_TRAVELER_FETCH_DISABLE;
-	}
-
 	reg = cpu_to_be32(data);
 	return snd_motu_transaction_write(motu, V2_CLOCK_STATUS_OFFSET, &reg,
 					  sizeof(reg));
@@ -145,42 +138,49 @@ static int v2_get_clock_source(struct snd_motu *motu,
 
 static int v2_switch_fetching_mode(struct snd_motu *motu, bool enable)
 {
+	enum snd_motu_clock_source src;
 	__be32 reg;
 	u32 data;
 	int err = 0;
 
-	if (motu->spec == &snd_motu_spec_traveler ||
-	    motu->spec == &snd_motu_spec_8pre) {
-		err = snd_motu_transaction_read(motu, V2_CLOCK_STATUS_OFFSET,
-						&reg, sizeof(reg));
+	// 828mkII implements Altera ACEX 1K EP1K30. Nothing to do.
+	if (motu->spec == &snd_motu_spec_828mk2)
+		return 0;
+
+	err = snd_motu_transaction_read(motu, V2_CLOCK_STATUS_OFFSET, &reg,
+					sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	err = get_clock_source(motu, data, &src);
+	if (err < 0)
+		return err;
+
+	data &= ~(V2_CLOCK_FETCH_ENABLE | V2_CLOCK_MODEL_SPECIFIC);
+	if (enable)
+		data |= V2_CLOCK_FETCH_ENABLE;
+
+	if (motu->spec->flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X4) {
+		// Expected for Traveler and 896HD, which implements Altera
+		// Cyclone EP1C3.
+		data |= V2_CLOCK_MODEL_SPECIFIC;
+	} else {
+		// For UltraLite and 8pre, which implements Xilinx Spartan
+		// XC3S200.
+		unsigned int rate;
+
+		err = get_clock_rate(data, &rate);
 		if (err < 0)
 			return err;
-		data = be32_to_cpu(reg);
-
-		if (motu->spec == &snd_motu_spec_traveler) {
-			data &= ~(V2_CLOCK_TRAVELER_FETCH_DISABLE |
-				  V2_CLOCK_TRAVELER_FETCH_ENABLE);
-
-			if (enable)
-				data |= V2_CLOCK_TRAVELER_FETCH_ENABLE;
-			else
-				data |= V2_CLOCK_TRAVELER_FETCH_DISABLE;
-		} else if (motu->spec == &snd_motu_spec_8pre) {
-			data &= ~(V2_CLOCK_8PRE_FETCH_DISABLE |
-				  V2_CLOCK_8PRE_FETCH_ENABLE);
-
-			if (enable)
-				data |= V2_CLOCK_8PRE_FETCH_DISABLE;
-			else
-				data |= V2_CLOCK_8PRE_FETCH_ENABLE;
-		}
 
-		reg = cpu_to_be32(data);
-		err = snd_motu_transaction_write(motu, V2_CLOCK_STATUS_OFFSET,
-						 &reg, sizeof(reg));
+		if (src == SND_MOTU_CLOCK_SOURCE_SPH && rate > 48000)
+			data |= V2_CLOCK_MODEL_SPECIFIC;
 	}
 
-	return err;
+	reg = cpu_to_be32(data);
+	return snd_motu_transaction_write(motu, V2_CLOCK_STATUS_OFFSET, &reg,
+					  sizeof(reg));
 }
 
 static void calculate_fixed_part(struct snd_motu_packet_format *formats,
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 680e363d0a4b..f249ad39d8a8 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -172,7 +172,7 @@ static void motu_bus_update(struct fw_unit *unit)
 	snd_motu_transaction_reregister(motu);
 }
 
-static const struct snd_motu_spec motu_828mk2 = {
+const struct snd_motu_spec snd_motu_spec_828mk2 = {
 	.name = "828mk2",
 	.protocol = &snd_motu_protocol_v2,
 	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
@@ -187,7 +187,7 @@ static const struct snd_motu_spec motu_828mk2 = {
 	.analog_out_ports = 8,
 };
 
-const struct snd_motu_spec snd_motu_spec_traveler = {
+static const struct snd_motu_spec motu_traveler = {
 	.name = "Traveler",
 	.protocol = &snd_motu_protocol_v2,
 	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
@@ -202,7 +202,7 @@ const struct snd_motu_spec snd_motu_spec_traveler = {
 	.analog_out_ports = 8,
 };
 
-const struct snd_motu_spec snd_motu_spec_8pre = {
+static const struct snd_motu_spec motu_8pre = {
 	.name = "8pre",
 	.protocol = &snd_motu_protocol_v2,
 	// In tx, use coax chunks for mix-return 1/2. In rx, use coax chunks for
@@ -270,9 +270,9 @@ static const struct snd_motu_spec motu_4pre = {
 }
 
 static const struct ieee1394_device_id motu_id_table[] = {
-	SND_MOTU_DEV_ENTRY(0x000003, &motu_828mk2),
-	SND_MOTU_DEV_ENTRY(0x000009, &snd_motu_spec_traveler),
-	SND_MOTU_DEV_ENTRY(0x00000f, &snd_motu_spec_8pre),
+	SND_MOTU_DEV_ENTRY(0x000003, &snd_motu_spec_828mk2),
+	SND_MOTU_DEV_ENTRY(0x000009, &motu_traveler),
+	SND_MOTU_DEV_ENTRY(0x00000f, &motu_8pre),
 	SND_MOTU_DEV_ENTRY(0x000015, &motu_828mk3),	/* FireWire only. */
 	SND_MOTU_DEV_ENTRY(0x000035, &motu_828mk3),	/* Hybrid. */
 	SND_MOTU_DEV_ENTRY(0x000033, &motu_audio_express),
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index bd782ee4e763..6efbde405a0d 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -130,8 +130,7 @@ struct snd_motu_spec {
 extern const struct snd_motu_protocol snd_motu_protocol_v2;
 extern const struct snd_motu_protocol snd_motu_protocol_v3;
 
-extern const struct snd_motu_spec snd_motu_spec_traveler;
-extern const struct snd_motu_spec snd_motu_spec_8pre;
+extern const struct snd_motu_spec snd_motu_spec_828mk2;
 
 int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 		    enum amdtp_stream_direction dir,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
