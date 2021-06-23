Return-Path: <SRS0=sqcX=LR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87870C4743C
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 08:01:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA22611BF
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 08:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA22611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A208384B;
	Wed, 23 Jun 2021 10:00:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A208384B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624435256;
	bh=69Oe3yqW7dlpNqnDVIHtI0rhu73SIaWT3vII6hdni/c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bXFyDUH7jpYqV5Zf/bepDaZO+SHgPH65XLX3JN+lB9G8aM3bgiocaB+iAfDgx32je
	 o1NynGCamt9lSYddTcxkYBEOJBptyfQ4px+3btewNodsLZou0XRF/LR7WAxlBGTlpI
	 a2ENo7mc78FxvcrQ3cJepNr76Krk5VCTfPstBWFU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18A2BF80290;
	Wed, 23 Jun 2021 10:00:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A505F804D6; Wed, 23 Jun 2021 10:00:04 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 466B4F8016B
 for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2021 09:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 466B4F8016B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="vC5a/0eg"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="HcZkZlO3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id BF34310C3;
 Wed, 23 Jun 2021 03:59:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 23 Jun 2021 03:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=3TsDp33sfVx6E
 MKeXkP20fK0hEeW7lxWsjYmgocDB0A=; b=vC5a/0egQat8hQbvaJXnUQzjqr8h0
 54yBCK29hQAuOTGGBwfJh7hfWDYhGX4idMVv2EQME95uPb4vTYIg0qKXWmXbpbnm
 Y2q62qyfXoMJtD87ChRJ/N8EiTXeDeAK+M+B4Y+bIisuPHZI7i7L1xSPx2ntNSE4
 lhiiSTIH8Hi/9hLWSDKffBVPuAqrUU1PR36noXIBMZBZ3nW1WU9b3wdctYR3N7mo
 vwwkdHXTSKetxRNnC+ghvAkHbKkWhDJXOGE6NYnJowi/9/mOvw5noQjWlf5lTB+A
 lRhsSaBcru8NM8VN5T1hCNui6kZG0ZFGOi9KRcPrM+Eztka77YxWw+W5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=3TsDp33sfVx6EMKeXkP20fK0hEeW7lxWsjYmgocDB0A=; b=HcZkZlO3
 yN8F/NFQZcGTFVf3uLRjwLfDA/EdNhmrTskOTrcyuYTUXZmR0lN85SF1ADA3qKbQ
 RPJZ7Y84aztHufQSG4V8Vj3XkJUtfw+EBDAS7p2BqgoBBbNw2AuJx+IYws5ROEx+
 NvmeQsMw7PnRckmcmndfICaRy733H5je14e41CLCbI5+BaW+OOdo+azK95M7f4i1
 uoVR2oegLM4IkeXazOxVmH6XPyjQqMGlOF1s9gm6mfNn5v1m90oqOIba5Yr0by9h
 5PLXBF+IDIoQiiAqQKqZt2BnYl7Ve2KDCvMshewCh04zTL9h4QUbKnrCkL3Zz3T/
 XNp5JPYMrLVUDA==
X-ME-Sender: <xms:9enSYPUJ2Ni1kweEJ0nOIXTyP0uIzPsTiSG12oD_0h150QKv65l4Og>
 <xme:9enSYHl3wFghxI2VhWwpyFJrJuYmbQrjEVuGTdO6JtWYUmocqcUVN-uDWBlBW6Pca
 44i_hJHYMpCN5TxJiU>
X-ME-Received: <xmr:9enSYLbsNb7jcAazGkXT5F6eH_42Ki2KggSqMHREtGXHBb0A0Ac5APT8a13IO9b6pi8EtIoxdW4RELJqNqzrkXPeRuRrxOax0FnshWiabT6KemSP4zf5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegvddguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
 hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:9enSYKW5TMCVb25pl9zhxAUwnjXdqLjG0GcOYQI9CKpGMPKbllc-3A>
 <xmx:9enSYJkN1UULpI_l4TljHW8O4JlIlze1WpZ39N_hW16jKylGijmUkw>
 <xmx:9enSYHfc4N0ViImy_GKEOugPI91bglT0NfCipJHEHmw53bFJEoaEag>
 <xmx:9enSYJt0YdwmNNrl1lxPqEm9JBwzzHGKKBRD5tkLPOwR-lwoN2lD6w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jun 2021 03:59:48 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 1/9] ALSA: firewire-motu: fix detection for S/PDIF source on
 optical interface in v2 protocol
Date: Wed, 23 Jun 2021 16:59:33 +0900
Message-Id: <20210623075941.72562-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623075941.72562-1-o-takashi@sakamocchi.jp>
References: <20210623075941.72562-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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

The devices in protocol version 2 has a register with flag for IEC 60958
signal detection as source of sampling clock without discrimination
between coaxial and optical interfaces. On the other hand, current
implementation of driver manage to interpret type of signal on optical
interface instead.

This commit fixes the detection of optical/coaxial interface for S/PDIF
signal.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index 784073aa1026..f0a0ecad4d74 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -86,24 +86,23 @@ static int detect_clock_source_optical_model(struct snd_motu *motu, u32 data,
 		*src = SND_MOTU_CLOCK_SOURCE_INTERNAL;
 		break;
 	case 1:
+		*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT;
+		break;
+	case 2:
 	{
 		__be32 reg;
 
 		// To check the configuration of optical interface.
-		int err = snd_motu_transaction_read(motu, V2_IN_OUT_CONF_OFFSET,
-						    &reg, sizeof(reg));
+		int err = snd_motu_transaction_read(motu, V2_IN_OUT_CONF_OFFSET, &reg, sizeof(reg));
 		if (err < 0)
 			return err;
 
-		if (be32_to_cpu(reg) & 0x00000200)
+		if (((data & V2_OPT_IN_IFACE_MASK) >> V2_OPT_IN_IFACE_SHIFT) == V2_OPT_IFACE_MODE_SPDIF)
 			*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT;
 		else
-			*src = SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT;
+			*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX;
 		break;
 	}
-	case 2:
-		*src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX;
-		break;
 	case 3:
 		*src = SND_MOTU_CLOCK_SOURCE_SPH;
 		break;
-- 
2.30.2

