Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC9EC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 02:47:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF986008E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 02:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF986008E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8029116A8;
	Tue, 18 May 2021 04:46:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8029116A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621306019;
	bh=Ol4TdnbDacFTEm2+KDoCEeuePJiSvYvttTzlYH/Clbw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=snv0bGXqGHFI4B8JAi7dWjI8TWTZv81a8auaqBSZ23AWSfoJQyoCDaDyRrxoR8xiW
	 U1dMamgpC3ci6XC0PPlV7p3CA0q6hDsU3MM4/TiP6OIy2vtsQ/tjUhwPbkO8pPHM+Z
	 YxsQP0oJTA80IrJOmD6XYVD02vshb3YnYlrZbxfI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83562F804B0;
	Tue, 18 May 2021 04:44:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6709CF804AC; Tue, 18 May 2021 04:43:53 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EF61F80217
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 04:43:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EF61F80217
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="pfcUNiQP"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="NEm0Z7GT"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 4A5775C00A2;
 Mon, 17 May 2021 22:43:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 17 May 2021 22:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=6cWQDSRIA9Hga
 GA5A9fsw3EyyTM3D8deK8KTjqJYZC8=; b=pfcUNiQPalZuXYZqz2JmBHE+EXXSy
 zcYSfvXIM6+hPdJz/vINqUVjKPDNgcwWdViLccp0BjaB3XxfWMTAiXCpA6zCDUcy
 XjURlE7xjDOHNrZqVhKfjvyK+yhyN/loTSDN9Uk6bVinQ48lhN2FOL52In97DF1V
 HtgC4yO+CQPnRRIWHr5tFrOnd8xuBuY4jrGwLKm/WryE4B4FN8jFQMoGTryRi4v9
 G/v06GHihczXS9XAHyqSIhhBJ6jLm/3PFU76lcILkp4qCFzuXAz4S9QlsOncyYT+
 3z1W+IEPYOZtbS2fuF48DX0zpeEMPFgKZ1EgPfOqW3Bq5uwoaO7xSJLQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=6cWQDSRIA9HgaGA5A9fsw3EyyTM3D8deK8KTjqJYZC8=; b=NEm0Z7GT
 Khi3bRxreiYZTaluvQ9vwqbF9LMOmnyKJWFHVXF+DwJxADNdsao7+6P+V5hSMrf+
 idQ93pM7imWRPj6XmxJ8wLSzk6zcfQtFSGuP1QzMqM1UNAk86gkwwhWvP6DGmvSJ
 VNmy9molZ3BMxPfVS1EApkhqq/CIasO1xRwFtQ8aLisECZ4fiP9f8YWk7o/r4Zto
 kUIqfc3BLyjWsKFGrg+MJ1sEVBIFpKC3R+yxaKj/t/XBlmtGW3Wj3WZGl/OMNuL7
 qPPi6+3f+E5i2B44e7FWzpqImSp6yNKR5EJbhs9HjfNJm9sGFl2WseMf9faf4N9s
 OW/z7ocSwAYwvw==
X-ME-Sender: <xms:2SmjYA6ckgCFHDl43VEKhUuKy0E4CT-LbSrCU6Bvdb5NMosVFXpqxQ>
 <xme:2SmjYB4ifz9eM3asqZkUOTUhgwTqn5TGhywO09hb_thixScMlLnYouMdYwk6IecRK
 3LOmEptY-N34RHlfXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiiedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:2SmjYPfS0LAUf6jAKIbiNzOp7v_JfS-imksIkD1Omh011fkxXIdA7A>
 <xmx:2SmjYFIpC9m6I6yCSVPzhQHgWZxrJSng1Fnd3VOT2W1gTzuu1TCTPw>
 <xmx:2SmjYEIIvOAfDnDxtBOKGiAol9yDUdlZPsz7NoetTzIZz4wN9qTkeQ>
 <xmx:2SmjYOy38ozCn9tlNcMk3adgCk2PdYDQti60P7ZalgeFpfT8RcWApQ>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Mon, 17 May 2021 22:43:36 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v3 04/11] ALSA: oxfw: code refactoring to detect Mackie models
Date: Tue, 18 May 2021 11:43:19 +0900
Message-Id: <20210518024326.67576-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518024326.67576-1-o-takashi@sakamocchi.jp>
References: <20210518024326.67576-1-o-takashi@sakamocchi.jp>
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

This commit changes condition statement to call Mackie models detection
just for the device entry. Additionally, comment is added for Onyx 1640i.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 7be999c61730..2af72951ebf8 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -245,7 +245,7 @@ static int oxfw_probe(struct fw_unit *unit,
 {
 	struct snd_oxfw *oxfw;
 
-	if (entry->vendor_id == VENDOR_LOUD && !detect_loud_models(unit))
+	if (entry->vendor_id == VENDOR_LOUD && entry->model_id == 0 && !detect_loud_models(unit))
 		return -ENODEV;
 
 	/* Allocate this independent of sound card instance. */
@@ -341,6 +341,7 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 	/*
 	 * Any Mackie(Loud) models (name string/model id):
 	 *  Onyx-i series (former models):	0x081216
+	 *  Onyx 1640i:				0x001640
 	 *  Mackie Onyx Satellite:		0x00200f
 	 *  Tapco LINK.firewire 4x6:		0x000460
 	 *  d.2 pro/d.4 pro (built-in card):	Unknown
@@ -352,6 +353,7 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 				  IEEE1394_MATCH_SPECIFIER_ID |
 				  IEEE1394_MATCH_VERSION,
 		.vendor_id	= VENDOR_LOUD,
+		.model_id	= 0,
 		.specifier_id	= SPECIFIER_1394TA,
 		.version	= VERSION_AVC,
 	},
-- 
2.27.0

