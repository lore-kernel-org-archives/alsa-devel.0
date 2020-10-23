Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729EFC4363A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:34:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB9A22210
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WsBfMkF0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/hkxDZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB9A22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E9891838;
	Fri, 23 Oct 2020 18:34:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E9891838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603470891;
	bh=u1Pqr2RIY1HqhTK0TpGLNOF+nTm1eTs38WLO0ZJ4+0A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WsBfMkF0dRV4KgNd/X/5kROMx3tURCWqwnwHtHVV9EHMIb8FCgsO9tsZYrjDbyHb0
	 yg3PYEUZALw5AsUfYLpAnd1uxp2AoCd9nFk4Rangbp2V5o5L4s5nUxtPLh3woKva2k
	 apXgAy/4CSjXSMe9ImvQnAKuRE7BgBQRXgtLEbq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF9C3F80253;
	Fri, 23 Oct 2020 18:34:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04325F80264; Fri, 23 Oct 2020 18:33:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0BF8F80245
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 18:33:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0BF8F80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Z/hkxDZY"
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de
 [95.90.213.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C0FE246A2;
 Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603470828;
 bh=u1Pqr2RIY1HqhTK0TpGLNOF+nTm1eTs38WLO0ZJ4+0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z/hkxDZYSLHRKJLOvLuXvqK3NtrZvdTmorxLGJrektvtGbFuOEQn34lI95TcpNxF+
 qlitjXCM4k77NEdYy1rMiXEf843CY27CIh0q217ZDc/pDLaPDyt39lauLEqIvXUaYA
 MOqQ4FkJOyYuKxsbU2LOpLuoptmFSr+tpEXx9O/k=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1kW00g-002Awc-0B; Fri, 23 Oct 2020 18:33:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH v3 28/56] slimbus: fix a kernel-doc markup
Date: Fri, 23 Oct 2020 18:33:15 +0200
Message-Id: <7a581d05aec5ebbd02be27513de1c5e5a25b7922.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
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

Fix the name of the enum on its kernel-doc markup:
	enum slim_ch_aux_fmt -> enum slim_ch_aux_bit_fmt

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/slimbus/slimbus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index c73035915f1d..00a7f112574b 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -244,7 +244,7 @@ enum slim_ch_data_fmt {
 };
 
 /**
- * enum slim_ch_aux_fmt: SLIMbus channel Aux Field format IDs according to
+ * enum slim_ch_aux_bit_fmt: SLIMbus channel Aux Field format IDs according to
  *	Table 63 of SLIMbus Spec 2.0
  * @SLIM_CH_AUX_FMT_NOT_APPLICABLE: Undefined
  * @SLIM_CH_AUX_FMT_ZCUV_TUNNEL_IEC60958: ZCUV for tunneling IEC60958
-- 
2.26.2

