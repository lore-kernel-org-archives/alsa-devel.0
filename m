Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25422C64E7A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:44:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41307206D8
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MAtVioTt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztbO0aAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41307206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CFE31786;
	Tue,  1 Dec 2020 09:43:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CFE31786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606812264;
	bh=CdaD+oddHx4/hyHba8egomuQUXT5Rqpxg1jVrIOWzg8=;
	h=Subject:To:From:Date:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=MAtVioTtoPHGQlntoWVtegvTK1rh13L1ZOOtH5wvUZZ/Lo1vrLp5JMlSnmNgeM42+
	 FINoXgtJrKXNh8R4TkLqkIOKkt0W423R26cwdTNNHzYIYWUb1A3X40LnRH3jcH1H2g
	 JGoNbYT76ROIUfZTPPYt3TxOo6NUUSvGmwO4g46U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF988F804C3;
	Tue,  1 Dec 2020 09:42:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D20FF804BC; Tue,  1 Dec 2020 09:42:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A745CF80139
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 09:41:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A745CF80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="ztbO0aAV"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C551206E3;
 Tue,  1 Dec 2020 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1606812115;
 bh=CdaD+oddHx4/hyHba8egomuQUXT5Rqpxg1jVrIOWzg8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=ztbO0aAVZVVGDYSiv+TMQ8UaAlJxnMgKOcJig6wiSF8qcHcBCyj7Q1Xs0CWUpPKkr
 2Dw4Z/KCSUWkpMotDyEtfXYQ6sGVlLKzW/EWb92Z55KxBcWvoZU7r+lZ0K6D78SzPr
 QgdBQi3PCSd09T3/T8Q+Vx6iUMsi72BgwH4kByrc=
Subject: Patch "ASoC: Intel: Skylake: Await purge request ack on CNL" has been
 added to the 5.4-stable tree
To: alsa-devel@alsa-project.org, broonie@kernel.org, cezary.rojewski@intel.com,
 gregkh@linuxfoundation.org, mateusz.gorski@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Dec 2020 09:42:54 +0100
In-Reply-To: <20201129114148.13772-7-cezary.rojewski@intel.com>
Message-ID: <160681217413115@kroah.com>
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

    ASoC: Intel: Skylake: Await purge request ack on CNL

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     asoc-intel-skylake-await-purge-request-ack-on-cnl.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Tue Dec  1 09:41:56 AM CET 2020
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Sun, 29 Nov 2020 12:41:46 +0100
Subject: ASoC: Intel: Skylake: Await purge request ack on CNL
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com, mateusz.gorski@linux.intel.com, Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <20201129114148.13772-7-cezary.rojewski@intel.com>

From: Cezary Rojewski <cezary.rojewski@intel.com>

commit 7693cadac86548b30389a6e11d78c38db654f393 upstream.

Each purge request is sent by driver after master core is powered up and
unresetted but before it is unstalled. On unstall, ROM begins processing
the request and initializing environment for FW load. Host should await
ROM's ack before moving forward. Without doing so, ROM init poll may
start too early and false timeouts can occur.

Fixes: cb6a55284629 ("ASoC: Intel: cnl: Add sst library functions for cnl platform")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-8-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/skylake/bxt-sst.c     |    1 -
 sound/soc/intel/skylake/cnl-sst.c     |   20 ++++++++++++++++++--
 sound/soc/intel/skylake/skl-sst-dsp.h |    1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -17,7 +17,6 @@
 #include "skl.h"
 
 #define BXT_BASEFW_TIMEOUT	3000
-#define BXT_INIT_TIMEOUT	300
 #define BXT_ROM_INIT_TIMEOUT	70
 #define BXT_IPC_PURGE_FW	0x01004000
 
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -57,18 +57,34 @@ static int cnl_prepare_fw(struct sst_dsp
 	ctx->dsp_ops.stream_tag = stream_tag;
 	memcpy(ctx->dmab.area, fwdata, fwsize);
 
+	ret = skl_dsp_core_power_up(ctx, SKL_DSP_CORE0_MASK);
+	if (ret < 0) {
+		dev_err(ctx->dev, "dsp core0 power up failed\n");
+		ret = -EIO;
+		goto base_fw_load_failed;
+	}
+
 	/* purge FW request */
 	sst_dsp_shim_write(ctx, CNL_ADSP_REG_HIPCIDR,
 			   CNL_ADSP_REG_HIPCIDR_BUSY | (CNL_IPC_PURGE |
 			   ((stream_tag - 1) << CNL_ROM_CTRL_DMA_ID)));
 
-	ret = cnl_dsp_enable_core(ctx, SKL_DSP_CORE0_MASK);
+	ret = skl_dsp_start_core(ctx, SKL_DSP_CORE0_MASK);
 	if (ret < 0) {
-		dev_err(ctx->dev, "dsp boot core failed ret: %d\n", ret);
+		dev_err(ctx->dev, "Start dsp core failed ret: %d\n", ret);
 		ret = -EIO;
 		goto base_fw_load_failed;
 	}
 
+	ret = sst_dsp_register_poll(ctx, CNL_ADSP_REG_HIPCIDA,
+				    CNL_ADSP_REG_HIPCIDA_DONE,
+				    CNL_ADSP_REG_HIPCIDA_DONE,
+				    BXT_INIT_TIMEOUT, "HIPCIDA Done");
+	if (ret < 0) {
+		dev_err(ctx->dev, "timeout for purge request: %d\n", ret);
+		goto base_fw_load_failed;
+	}
+
 	/* enable interrupt */
 	cnl_ipc_int_enable(ctx);
 	cnl_ipc_op_int_enable(ctx);
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -68,6 +68,7 @@ struct skl_dev;
 #define SKL_FW_INIT			0x1
 #define SKL_FW_RFW_START		0xf
 #define BXT_FW_ROM_INIT_RETRY		3
+#define BXT_INIT_TIMEOUT		300
 
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
