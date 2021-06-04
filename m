Return-Path: <SRS0=evnw=K6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B97FC07E94
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 07:27:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358C961417
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 07:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358C961417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A6061708;
	Fri,  4 Jun 2021 09:26:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A6061708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622791621;
	bh=QL9r/k6OqX+R2Iy5czp6c6lWgpPMD31+LjAlGMhaXLE=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GHLqRH+RnPhGWvpUOEx0Ooy5dlZhWhLcvsCRkgYJsQiCP5UdR0l0TLXe/uFkP84RF
	 0e3wmHsWsWG1TfDl/gVeTeAstVL5TAYeSR6sW4KBET5asZQH6CVT1mEf9eUwUpLDCr
	 nc29sewTiZf+9UAm5iz0dK3bALWUm4e9xbdZP6FI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E41BFF802A9;
	Fri,  4 Jun 2021 09:26:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93506F802C4; Fri,  4 Jun 2021 09:26:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B7F1F80103
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 09:26:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B7F1F80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="coTXexxR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E10C661417;
 Fri,  4 Jun 2021 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622791564;
 bh=QL9r/k6OqX+R2Iy5czp6c6lWgpPMD31+LjAlGMhaXLE=;
 h=Date:From:To:Cc:Subject:From;
 b=coTXexxRGVD7ADaKTg82CksMLypwNkAWbSes/PqCs4C8nkDL8JWt1j6vDg9KulOlu
 ICBX+hWn4XCrDlksJM8IeNofWvYbWvDrmErCB1UhlRo1vU12jtYKjywtnAooTNdcI7
 e+N9Ba6esswRpayjU/gRcBgAcSQjNdDokp8l4V+3wSc30tQlLJNdR5hOJPLPKUw7CR
 i2e928PImS5GG6ccpBJcKxTCRbzmXi4GGDMY/l8cioogy5LzmEMYLS0i+k8ZhCH97W
 IFMhVf5jTt9lYhQew3h0y8cIRmPH6T515BFThbSHCEvgGuGyo0QzSQdT30ZTZhi96D
 G1ll5hreQcMyw==
Date: Fri, 4 Jun 2021 02:27:14 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2][next] ASoC: ti: davinci-mcasp: Fix fall-through warning
 for Clang
Message-ID: <20210604072714.GA244640@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
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

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a fallthrough; statement.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use fallthrough; instead of break;
 - Update changelog text.
 Link: https://lore.kernel.org/linux-hardening/25941c37-6e38-88ae-3afe-4f5af44380d3@gmail.com/

 sound/soc/ti/davinci-mcasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index b94220306d1a..017a5a5e56cd 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2317,6 +2317,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
+		fallthrough;
 	case -EPROBE_DEFER:
 		goto err;
 	}
-- 
2.27.0

