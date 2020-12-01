Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B348C64E7B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:42:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3E9206D8
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aSwGjr38";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uJ337OXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3E9206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B5A61764;
	Tue,  1 Dec 2020 09:41:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B5A61764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606812166;
	bh=2kv0AQiQlzfXXJQUp7em1P1jWXei4mSdx5jP0FShFR0=;
	h=Subject:To:From:Date:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=aSwGjr38irShPX9qfN0kGzlWuUwgNozJT4KZFyim85EMKCbarTito9ThCQBwxBOF2
	 n39pO34yT2+BvO9+n67Vd2MBvBIZLmNC4wP7oc5KSdqV1aYoLAGpIxXUqIwMXUBAmN
	 amr9gYINsE7fcj+AkQYGSLrgHG7cS2fQ2NkHmfZ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FCA3F8016D;
	Tue,  1 Dec 2020 09:41:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59DEAF80158; Tue,  1 Dec 2020 09:41:53 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A096F80139
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 09:41:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A096F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="uJ337OXg"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC1612054F;
 Tue,  1 Dec 2020 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1606812102;
 bh=2kv0AQiQlzfXXJQUp7em1P1jWXei4mSdx5jP0FShFR0=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=uJ337OXg9uFlzM4PRvFTSuMplXP+XwBu20EFKLxXanG0m/uHoce6R3NQoNvr3PP7R
 U8s+9mBFH4cIkh7oQiHwAM5Gofs1Zl9qOitPnkj95NQmgRyYuwLpQ87DcONoLqj4lw
 Kh+8ICX6ZUP/muA8SesWgUyl949KqMMaDMDBW20c=
Subject: Patch "ASoC: Intel: Allow for ROM init retry on CNL platforms" has
 been added to the 5.4-stable tree
To: alsa-devel@alsa-project.org, broonie@kernel.org, cezary.rojewski@intel.com,
 gregkh@linuxfoundation.org, mateusz.gorski@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Dec 2020 09:42:54 +0100
In-Reply-To: <20201129114148.13772-6-cezary.rojewski@intel.com>
Message-ID: <1606812174128122@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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


This is a note to let you know that I've just added the patch titled

    ASoC: Intel: Allow for ROM init retry on CNL platforms

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     asoc-intel-allow-for-rom-init-retry-on-cnl-platforms.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Tue Dec  1 09:41:56 AM CET 2020
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Sun, 29 Nov 2020 12:41:45 +0100
Subject: ASoC: Intel: Allow for ROM init retry on CNL platforms
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com, mateusz.gorski@linux.intel.com, Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <20201129114148.13772-6-cezary.rojewski@intel.com>

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


Patches currently in stable-queue which might be from cezary.rojewski@intel.com are

queue-5.4/asoc-intel-skylake-select-hda-configuration-permissively.patch
queue-5.4/asoc-intel-skylake-enable-codec-wakeup-during-chip-init.patch
queue-5.4/asoc-intel-allow-for-rom-init-retry-on-cnl-platforms.patch
queue-5.4/asoc-intel-skylake-await-purge-request-ack-on-cnl.patch
queue-5.4/asoc-intel-skylake-remove-superfluous-chip-initialization.patch
queue-5.4/asoc-intel-skylake-shield-against-no-nhlt-configurations.patch
queue-5.4/asoc-intel-multiple-i-o-pcm-format-support-for-pipe.patch
queue-5.4/asoc-intel-skylake-automatic-dmic-format-configuration-according-to-information-from-nhlt.patch
