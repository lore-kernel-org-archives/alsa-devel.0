Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40DFC433E8
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:41:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70244208E4
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="faUlB7fh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="a+qAt40s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70244208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AF90168D;
	Thu, 23 Jul 2020 20:40:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AF90168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595529675;
	bh=qIQa+mn+31BRzmSFUUteAq0orLC4NPAWivmYKYi6wKA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=faUlB7fh8HmeK2lD7UEH5iJWAPiQC35fncU3J0aAbBbmhNyo4Fux3wYn/G3nwfoal
	 jqYlKYSGYK7gCKv3NW3HMEBkRFrypwQ2fwl6C8BYoIU5RYmPAYkHR6ql4Uvj5kOQiD
	 CBW+tFgbO/sZSkC9U0ht161Y24V5RNa43RdmNsWc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B001F8011F;
	Thu, 23 Jul 2020 20:39:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76F04F8028C; Thu, 23 Jul 2020 20:39:31 +0200 (CEST)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51B40F8020D
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 20:39:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51B40F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="a+qAt40s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1595529564;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=IPhq+JQHymy5t9BAg8bCj3SRGxYzGHSxJyIMhV286WU=;
 b=a+qAt40s3Dhzb6hDbn8XV6CVwyv6qh9I7X6OGiS/jDU2G8/w09KczaebleWclPdeIj
 8P0lUyyhJRuzt9d4iidPevtGemvtxqAGZtZUjq2y0bZj2ccOkHs7oBZUrfClfNsSqzAN
 E65SRw0Lcem28mSX1Boo9HHf0dxCcUYenbjTLtNpaasl0XscWtEn0fQEHlXhIebNrLjT
 kl8DiKxAx0SiilPuL5xEEYu/+8QZf38wtkqzyh8FaQHy171H6akd+h9aM+ahlc8SpKq6
 90aFI5OGNhaYsVz8gl5tWr7jI1Q7lNam6JkFwwBaPDpopIGCvIGhfWCForgCT0aXdlqG
 ShIg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6OBfnv"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
 by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
 with ESMTPSA id Y0939ew6NIdL5IL
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 23 Jul 2020 20:39:21 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/7] ASoC: qcom: common: Parse properties with "qcom," prefix
Date: Thu, 23 Jul 2020 20:39:02 +0200
Message-Id: <20200723183904.321040-6-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723183904.321040-1-stephan@gerhold.net>
References: <20200723183904.321040-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, Patrick Lai <plai@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, Cheng-Yi Chiang <cychiang@chromium.org>
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

The apq8016_sbc device tree binding uses a "qcom," vendor prefix
for all device tree properties, while qcom_snd_parse_of() uses the
same properties without a prefix.

In the future it would be nice to make this consistent, however,
for backwards compatibility we need to parse both names to allow
apq8016_sbc to use the common qcom_snd_parse_of() function.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/qcom/common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 54f5bc60246f..84dba0d69e6b 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -18,6 +18,9 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	int ret, num_links;
 
 	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret == 0 && !card->name)
+		/* Deprecated, only for compatibility with old device trees */
+		ret = snd_soc_of_parse_card_name(card, "qcom,model");
 	if (ret) {
 		dev_err(dev, "Error parsing card name: %d\n", ret);
 		return ret;
@@ -25,8 +28,13 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 	/* DAPM routes */
 	if (of_property_read_bool(dev->of_node, "audio-routing")) {
-		ret = snd_soc_of_parse_audio_routing(card,
-				"audio-routing");
+		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+		if (ret)
+			return ret;
+	}
+	/* Deprecated, only for compatibility with old device trees */
+	if (of_property_read_bool(dev->of_node, "qcom,audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card, "qcom,audio-routing");
 		if (ret)
 			return ret;
 	}
-- 
2.27.0

