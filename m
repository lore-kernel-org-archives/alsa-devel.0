Return-Path: <SRS0=b36W=5B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E36C18E5B
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 05:55:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583132071C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 05:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qbIx3AUw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDPfi1Yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583132071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B01A9188B;
	Mon, 16 Mar 2020 06:54:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B01A9188B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584338129;
	bh=lS+qwx9mm8I2t3RkiOHXznQAfI14rFMap31xJBPpUeA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qbIx3AUwXbqaxEIrWi+pbY6ifPxQfU9A0fzVDPgKoDUz8mgDTzSo8RXcdJYeVrBlD
	 8UXgahSkSADtPA6YroBvaoOpVFGdO500f0MPREnmPqFZYmGU0kMjv1icm91hQzTlZM
	 +Cx8G1i/NK3MamZDmgMyE/lY1sTJ6Ds48yd1Z348=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1018EF8028C;
	Mon, 16 Mar 2020 06:54:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DA05F8028D; Mon, 16 Mar 2020 06:54:03 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 058E5F80248
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 06:54:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 058E5F80248
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HDPfi1Yb"
Received: from vkoul-mobl.Dlink (unknown [49.207.58.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0293A20679;
 Mon, 16 Mar 2020 05:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584338039;
 bh=lS+qwx9mm8I2t3RkiOHXznQAfI14rFMap31xJBPpUeA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HDPfi1Ybg/eRCYs8Bqoeg3jdNYM+kD/gPF62hGWaB7wcg+OFwKii7ZYEaCl2gbWKe
 alerMxtOXyVeYXca82uMpQRTsXKapK+i0vOHftiOghOmgYA3Qae2m7bO3wq2PLPPxo
 ZqPjBPiBKV9k38wvwm5pUoiMPi5T5u9xgaMkLYcA=
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 1/9] ALSA: compress: add wma codec profiles
Date: Mon, 16 Mar 2020 11:22:13 +0530
Message-Id: <20200316055221.1944464-2-vkoul@kernel.org>
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

Some codec profiles were missing for WMA, like WMA9/10 lossless and
wma10 pro, so add these profiles

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/sound/compress_params.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index 9c96fb0e4d90..a47d9df0fd7b 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -142,6 +142,9 @@
 #define SND_AUDIOPROFILE_WMA8                ((__u32) 0x00000002)
 #define SND_AUDIOPROFILE_WMA9                ((__u32) 0x00000004)
 #define SND_AUDIOPROFILE_WMA10               ((__u32) 0x00000008)
+#define SND_AUDIOPROFILE_WMA9_PRO            ((__u32) 0x00000010)
+#define SND_AUDIOPROFILE_WMA9_LOSSLESS       ((__u32) 0x00000020)
+#define SND_AUDIOPROFILE_WMA10_LOSSLESS      ((__u32) 0x00000040)
 
 #define SND_AUDIOMODE_WMA_LEVEL1             ((__u32) 0x00000001)
 #define SND_AUDIOMODE_WMA_LEVEL2             ((__u32) 0x00000002)
-- 
2.24.1

