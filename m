Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6ECC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 12:39:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380D82074B
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oQzsrGj7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQ5hcO8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380D82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A34BB1678;
	Fri, 12 Jun 2020 14:39:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A34BB1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591965597;
	bh=p3kTXwzEJzyjcU8PAjxRbcNdqyC+NnY+NoeqeMLg9f4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQzsrGj73+VbWbJrrbVM4Wy4/v7u1Fj4Qs2O+BvSF/mMFE+E/QRooT5ZXYlNXDH7U
	 ySOMq4lP/B3s2AYoBlWtW3mY1wbco9T7TlLYbFIUQplmG5kMaLowRPXHGiz1+7Dx3b
	 eYWYrFxUDaCpQ7Mz1ORAxQAmw+excrarIOAN7asA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51D01F8021E;
	Fri, 12 Jun 2020 14:38:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5FBEF8021C; Fri, 12 Jun 2020 14:38:13 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10083F80058
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 14:38:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10083F80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="iQ5hcO8x"
Received: by mail-wr1-x443.google.com with SMTP id r7so9608933wro.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3GhP3uz0XN6OU0twcZsptRwHlkZxcUOkI66yWE4C4Ro=;
 b=iQ5hcO8xBJOgPqnUvGNqnCuAYoyYn9av0SSPL1mJ2dW+9FHnsIeqKkfAkNk0/pQ5mj
 oez3VPL1T2Axh07pvGsbzc3fGus+FREEDOW7lQetNbN7Vso5Mfl+rWFlK+pSWrjiwUa2
 U4h/tV74irexipyOiFC21F6b9VgktOC7kDNTgGcsrmad6hGchmGarfpscpvfQGOJ+SKe
 IofO62pX+G8cqrgAMpCEdyK8IRpc/8gs5Sb06WKm3k2dTP1VlQ/6ZGhS/9yr2kOWDe0O
 sppflITo/T6kMHKhuHDhY7pzoxRrIpXaacmhOSacCU2Y/QCAKpO+p0nPFkilZeXkrqjN
 Mn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3GhP3uz0XN6OU0twcZsptRwHlkZxcUOkI66yWE4C4Ro=;
 b=ij/ay9M2TFi/HIPgD3PHd9UvGQ5Qj5SQC8fvk8nholDiwZpPzOIDUHS0ALWTPp8ewQ
 2xflLZ5z/uPcizPJ3+VBCNPE63kFxgw3KZmtSxFoXVc59bjjuuypn+QoeaUMfoDMWdrw
 +seb/PtD6/1iD7aSrXeeYgkoR9g/OVFqm8wI90D0V0p+ww6tnubDS2dwRKShvlzOZlES
 ZOHBkKmXqZG1FvxL3YoEhcy5AAgJnFar37ISd7mlH5cQqZIXD5FQcT0GwXC24VSRJU6l
 baC2MD0nR3h4J0re4RrclHTN6KAujhTxQF0wP1Sy/0bndpPhHs8t9dnMUokFwbB6k9/G
 Yszg==
X-Gm-Message-State: AOAM531HTZXIONynTn6U63CsLp/5dVbvEuh0hwlwSEODdqOKkdskNmyM
 jDMe3dcGJJP4kjlq/YV35HRNZA==
X-Google-Smtp-Source: ABdhPJzSPU3xAksW5P8P/fHH+J+BcWe+8ALGCptbAJ4fCUPMaUis1RTCbWo6ng9R3/v3s8Hab9j61A==
X-Received: by 2002:a5d:4f81:: with SMTP id d1mr15556564wru.95.1591965486947; 
 Fri, 12 Jun 2020 05:38:06 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id g18sm9392299wme.17.2020.06.12.05.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 05:38:06 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 2/2] ASoC: qcom: common: set correct directions for dailinks
Date: Fri, 12 Jun 2020 13:37:11 +0100
Message-Id: <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
References: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, vkoul@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 John Stultz <john.stultz@linaro.org>
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

Currently both FE and BE dai-links are configured bi-directional,
However the DSP BE dais are only single directional,
so set the directions as supported by the BE dais.

Fixes: c25e295cd77b (ASoC: qcom: Add support to parse common audio device nodes")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 6c20bdd850f3..8ada4ecba847 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -4,6 +4,7 @@
 
 #include <linux/module.h>
 #include "common.h"
+#include "qdsp6/q6afe.h"
 
 int qcom_snd_parse_of(struct snd_soc_card *card)
 {
@@ -101,6 +102,15 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			}
 			link->no_pcm = 1;
 			link->ignore_pmdown_time = 1;
+
+			if (q6afe_is_rx_port(link->id)) {
+				link->dpcm_playback = 1;
+				link->dpcm_capture = 0;
+			} else {
+				link->dpcm_playback = 0;
+				link->dpcm_capture = 1;
+			}
+
 		} else {
 			dlc = devm_kzalloc(dev, sizeof(*dlc), GFP_KERNEL);
 			if (!dlc)
@@ -113,12 +123,12 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			link->codecs->dai_name = "snd-soc-dummy-dai";
 			link->codecs->name = "snd-soc-dummy";
 			link->dynamic = 1;
+			link->dpcm_playback = 1;
+			link->dpcm_capture = 1;
 		}
 
 		link->ignore_suspend = 1;
 		link->nonatomic = 1;
-		link->dpcm_playback = 1;
-		link->dpcm_capture = 1;
 		link->stream_name = link->name;
 		link++;
 
-- 
2.21.0

