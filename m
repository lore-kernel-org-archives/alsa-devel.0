Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A246EC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:11:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A0520409
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nIS3D4WB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUPKa6UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A0520409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77D69178D;
	Fri, 13 Mar 2020 08:10:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77D69178D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584083508;
	bh=2HHtMQ/oq3CtVwVJ1RMLryfUOU4xqIkyYyt4FkFInU4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nIS3D4WBTbpRhZ/W1iPfHTbqRDJHO+hFRsZdP5wQzqYfl9BOKgwqhigB4r3mdRES0
	 Arg3hNmmkrbt2s4eXCLUTm2NrdwaKwe0WXG0OAjfr+UJ9+sgehbO3DmgzWbNU26788
	 nRKQ8KcwKNOBmh2ZqpKxxgdFq5qqG3GR8dMr1keY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF4D3F8028F;
	Fri, 13 Mar 2020 08:09:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59A24F80276; Fri, 13 Mar 2020 08:09:21 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 850ADF801F8
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 08:09:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 850ADF801F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IUPKa6UH"
Received: from localhost.localdomain (unknown [171.76.107.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF10220409;
 Fri, 13 Mar 2020 07:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584083355;
 bh=2HHtMQ/oq3CtVwVJ1RMLryfUOU4xqIkyYyt4FkFInU4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IUPKa6UHmHqG2wrCYo/fRPrehhLUdlUT1kQUURDnW9MOJAIJ/PDri9+GGmFv8l7lG
 PQFg1vTx4bFgramvlWSPrdB7dG1Ld1t8jrsn4v7ZItpdlr3uM23txFIb1eP4nAIb5+
 gsY1Xz3EnQkzPtgpNZ4pTAaAryWG3h8h9LL4s07c=
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/9] ALSA: compress: Add wma decoder params
Date: Fri, 13 Mar 2020 12:38:40 +0530
Message-Id: <20200313070847.1464977-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313070847.1464977-1-vkoul@kernel.org>
References: <20200313070847.1464977-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
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

Some WMA decoders like WMAv10 etc need some additional encoder option
parameters, so add these as WMA decoder params.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/sound/compress_params.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index 634daa354b58..19d69d626573 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -329,6 +329,13 @@ struct snd_dec_flac {
 	__u16 reserved;
 } __attribute__((packed, aligned(4)));
 
+struct snd_dec_wma {
+	__u32 encoder_option;
+	__u32 adv_encoder_option;
+	__u32 adv_encoder_option2;
+	__u32 reserved;
+} __attribute__((packed, aligned(4)));
+
 union snd_codec_options {
 	struct snd_enc_wma wma;
 	struct snd_enc_vorbis vorbis;
@@ -336,6 +343,7 @@ union snd_codec_options {
 	struct snd_enc_flac flac;
 	struct snd_enc_generic generic;
 	struct snd_dec_flac flac_d;
+	struct snd_dec_wma wma_d;
 } __attribute__((packed, aligned(4)));
 
 /** struct snd_codec_desc - description of codec capabilities
-- 
2.24.1

