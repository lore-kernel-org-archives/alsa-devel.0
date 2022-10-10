Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DEBC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Oct 2022 12:06:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DA83297E;
	Mon, 10 Oct 2022 14:05:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DA83297E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665403588;
	bh=b81rFCaucnf8oXxxRjBQGTwyXDPDKuYTsbOcBfqZy80=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvOMpVEueKVM1FzGNRlpFFvQqtEmfFI4sXT2cFPt1OYEFRke46d0jci91j4gyfpfU
	 gf7+H54tgI7ut6zih34GpygFl8hhcjSzk4XrLX0smZrnxZhNUoTm8w77VoNBo7wZT3
	 OxwKVSRIJEOx7Fd+7d4axuxQqrxv+w3+r1AkTX8Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FF3EF801D5;
	Mon, 10 Oct 2022 14:04:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCA65F80578; Mon, 10 Oct 2022 14:04:09 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FC50F80557
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 14:04:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FC50F80557
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Xoy4F7S2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665403444; x=1696939444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b81rFCaucnf8oXxxRjBQGTwyXDPDKuYTsbOcBfqZy80=;
 b=Xoy4F7S28tKnqMwZvux4Vx/dHyL6wn1KY4GnCG/s4RRpknS7t4rs62eD
 TWNGoY1gK25Po+ooRl22MZu/wweu4t7inVnkoIl8cRIQgpSaEAuaP4DB3
 ArFRqauyD7dA/zrLzsTXubIZzvrWsIYnvnosPHmjQEzVha4FReEPCRW+9
 kxeNT1WaSD8akpK6Z4oKmkBv05BKvQgzFLZBs2kGYM5fFaScvQaFxeboB
 xtdFWFigHE7n+oJ6txIubjOGQHuclulQ80l2rxN/WFfEaKjUy5ir0m5xv
 BEbMbBHliIAcfdIe54UoQEV0/Qr+v5V/GkMErjqGOuL2tTEe9Gc8ROvon A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="368346087"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="368346087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2022 05:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="871078910"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="871078910"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2022 05:03:58 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v2 06/15] ASoC: Intel: avs: Support da7219 on both KBL and APL
Date: Mon, 10 Oct 2022 14:19:46 +0200
Message-Id: <20221010121955.718168-7-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010121955.718168-1-cezary.rojewski@intel.com>
References: <20221010121955.718168-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

KBL and APL devices use same codec but have different clock, so it must
be set appropriately depending on device.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/boards/da7219.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/da7219.c b/sound/soc/intel/avs/boards/da7219.c
index 02ae542ad779..503a967a1c3a 100644
--- a/sound/soc/intel/avs/boards/da7219.c
+++ b/sound/soc/intel/avs/boards/da7219.c
@@ -6,6 +6,7 @@
 //
 
 #include <linux/module.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/platform_device.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -80,7 +81,10 @@ static int avs_da7219_codec_init(struct snd_soc_pcm_runtime *runtime)
 	int ret;
 
 	jack = snd_soc_card_get_drvdata(card);
-	clk_freq = 19200000;
+	if (soc_intel_is_apl())
+		clk_freq = 19200000;
+	else /* kbl */
+		clk_freq = 24576000;
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, clk_freq, SND_SOC_CLOCK_IN);
 	if (ret) {
-- 
2.25.1

