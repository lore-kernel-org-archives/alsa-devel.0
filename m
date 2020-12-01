Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2191C4361A
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 08:08:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394B122DBF
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 08:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394B122DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEA881901;
	Sat,  5 Dec 2020 09:07:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEA881901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607155698;
	bh=BbU6Hr7e+pRq9nrVXXo1dwEeD1dgrs25CEtb8rFAtv0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LmB1oHjUKe1Sk5stKGR1IEO/NX55Pkifg0cvqclvoYytEkiA303fu4/zYA2rBt1RJ
	 pDKuqlAtlOFWqUhojQdAr6HxgdACgABgArwoGt0ub2kuslf9C8vvvtO86S//VFsUF9
	 1f6BO06A5gW2N9kxHu0mZceKN2FOspm0Pzk+R3rM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CC58F80506;
	Sat,  5 Dec 2020 09:03:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 694D0F804B2; Tue,  1 Dec 2020 10:07:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4FE5F80168
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 10:07:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4FE5F80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="X60VwPzB"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C47421D7A;
 Tue,  1 Dec 2020 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1606813622;
 bh=BbU6Hr7e+pRq9nrVXXo1dwEeD1dgrs25CEtb8rFAtv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X60VwPzBHglZVuWdOoPb6YFdRs21PHCRHPFHvH0J9iD8ORLXG2uslz7tuxLFui0DF
 apg+LjyegVVYo3aaJOEauXjrHwwhsNZCOCSdNEdAzsuGuRB+rWObU+DkSSQZebPze/
 S2QSwucKbcL+yx3sIIMt/ARvaVgGLrXlRuIc7TjY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.4 95/98] ASoC: Intel: Allow for ROM init retry on CNL
 platforms
Date: Tue,  1 Dec 2020 09:54:12 +0100
Message-Id: <20201201084659.719019674@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201084652.827177826@linuxfoundation.org>
References: <20201201084652.827177826@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Dec 2020 09:03:15 +0100
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 stable@vger.kernel.org
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

From: Cezary Rojewski <cezary.rojewski@intel.com>

commit 024aa45f55ccd40704cfdef61b2a8b6d0de9cdd1 upstream.

Due to unconditional initial timeouts, firmware may fail to load during
its initialization. This issue cannot be resolved on driver side as it
is caused by external sources such as CSME but has to be accounted for
nonetheless.

Fixes: cb6a55284629 ("ASoC: Intel: cnl: Add sst library functions for cnl platform")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-7-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/skylake/bxt-sst.c     |    2 --
 sound/soc/intel/skylake/cnl-sst.c     |   15 ++++++++++-----
 sound/soc/intel/skylake/skl-sst-dsp.h |    1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -38,8 +38,6 @@
 /* Delay before scheduling D0i3 entry */
 #define BXT_D0I3_DELAY 5000
 
-#define BXT_FW_ROM_INIT_RETRY 3
-
 static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 {
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -109,7 +109,7 @@ static int cnl_load_base_firmware(struct
 {
 	struct firmware stripped_fw;
 	struct skl_dev *cnl = ctx->thread_context;
-	int ret;
+	int ret, i;
 
 	if (!ctx->fw) {
 		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
@@ -131,12 +131,16 @@ static int cnl_load_base_firmware(struct
 	stripped_fw.size = ctx->fw->size;
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
-	ret = cnl_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
-	if (ret < 0) {
-		dev_err(ctx->dev, "prepare firmware failed: %d\n", ret);
-		goto cnl_load_base_firmware_failed;
+	for (i = 0; i < BXT_FW_ROM_INIT_RETRY; i++) {
+		ret = cnl_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
+		if (!ret)
+			break;
+		dev_dbg(ctx->dev, "prepare firmware failed: %d\n", ret);
 	}
 
+	if (ret < 0)
+		goto cnl_load_base_firmware_failed;
+
 	ret = sst_transfer_fw_host_dma(ctx);
 	if (ret < 0) {
 		dev_err(ctx->dev, "transfer firmware failed: %d\n", ret);
@@ -158,6 +162,7 @@ static int cnl_load_base_firmware(struct
 	return 0;
 
 cnl_load_base_firmware_failed:
+	dev_err(ctx->dev, "firmware load failed: %d\n", ret);
 	release_firmware(ctx->fw);
 	ctx->fw = NULL;
 
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -67,6 +67,7 @@ struct skl_dev;
 
 #define SKL_FW_INIT			0x1
 #define SKL_FW_RFW_START		0xf
+#define BXT_FW_ROM_INIT_RETRY		3
 
 #define SKL_ADSPIC_IPC			1
 #define SKL_ADSPIS_IPC			1


