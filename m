Return-Path: <SRS0=b36W=5B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B01C0044D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 05:59:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8052E20674
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 05:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WS/oP221";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofp0S/SM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8052E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D232E18B3;
	Mon, 16 Mar 2020 06:59:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D232E18B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584338396;
	bh=eOHdzKsuiDRxoSeOKx1T/q3qpP4W3MG5l3YkkamaGsA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WS/oP221sSUeBALqdpz4pk9APmAT4NihZjYhbhFrRoPksYax92ZGYoizBHlucZjVY
	 FO2o3Beb2P/YJMyYd9doUv0XXz+VPMp3NiHkMe3nDa4+eqshn3MDqZvvxz6xJgLJcz
	 2ksQRB8sU1g4GARXIIKvpO0BuKp/FiyuggliOxoI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2433F802BE;
	Mon, 16 Mar 2020 06:56:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEC37F802C2; Mon, 16 Mar 2020 06:56:42 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55D22F802BC
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 06:56:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55D22F802BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ofp0S/SM"
Received: from vkoul-mobl.Dlink (unknown [49.207.58.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1010C20679;
 Mon, 16 Mar 2020 05:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584338198;
 bh=eOHdzKsuiDRxoSeOKx1T/q3qpP4W3MG5l3YkkamaGsA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ofp0S/SMz2xArGWdteZGbpHj/qUfFeLutZQOIrBaBlfPVdqiAYLPruzaOugbMIf4N
 uL6ftxG4PjKsS7n1DHV+TzS8lm/GwRk7c8tmiTvhmZ9LqLlULn/e/d8FBFilBsDlY0
 FOJcA1WZPJWrIRaIiUB6MCsm98WG7Wjj/j0b+PPs=
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 9/9] ALSA: compress: bump the version
Date: Mon, 16 Mar 2020 11:22:21 +0530
Message-Id: <20200316055221.1944464-10-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316055221.1944464-1-vkoul@kernel.org>
References: <20200316055221.1944464-1-vkoul@kernel.org>
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

We have added support for bunch of new decoders and parameters for
decoders. To help users find the support bump the version up to 0,2,0.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/sound/compress_offload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 56d95673ce0f..7184265c0b0d 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -31,7 +31,7 @@
 #include <sound/compress_params.h>
 
 
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 2)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 2, 0)
 /**
  * struct snd_compressed_buffer - compressed buffer
  * @fragment_size: size of buffer fragment in bytes
-- 
2.24.1

