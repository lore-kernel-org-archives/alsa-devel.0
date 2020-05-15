Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020BAC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 21:13:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761AD205CB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 21:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b4LtOnfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761AD205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D67E11679;
	Fri, 15 May 2020 23:12:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D67E11679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589577201;
	bh=iZ15tE0C99I+7z2un/LSIRw4IIO4V+NX8Rc8GRJBs9Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b4LtOnfUXTPXmvPY+wJ7TxyFLJ+8kjl5ovlnuKCrbY9T0W/JcQ+Qbdg7iVx779RCS
	 hjsGinBDddbullCvGYU50bmT/SESEKeh88otbctCzBh1lm9U5/vJdiDLXNqytP9w56
	 V4zPasmRERtX28fF8T80GpOJzpRkXyjnkm/vDqQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B1EDF8029B;
	Fri, 15 May 2020 23:10:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C48BF80247; Fri, 15 May 2020 23:08:34 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D5EBF80255
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 23:08:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D5EBF80255
IronPort-SDR: HkWarjFdYYEs2pKtt+xZ7Fcg/9y2eDOU02qiCwSoCrRpzG+/jL8HOK9eN0WacY/CxVon9fSX5X
 dZbj+/oAWItA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 14:07:59 -0700
IronPort-SDR: GqADlirwmizZJtWwJ5n61Pj0UcGpsPO0VVAeY8TRQ5uNplfkU0CaAE/ZhpmQWDqOUrfwk6My/z
 /8artqDgZnGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; d="scan'208";a="410589939"
Received: from btchambe-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.66.225])
 by orsmga004.jf.intel.com with ESMTP; 15 May 2020 14:07:58 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] ASoC: Intel: cht_bsw_nau8824: remap BTN_0 as KEY_PLAYPAUSE
Date: Fri, 15 May 2020 16:07:31 -0500
Message-Id: <20200515210731.10942-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515210731.10942-1-pierre-louis.bossart@linux.intel.com>
References: <20200515210731.10942-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>
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

Use same mapping as in all other machine drivers:

BTN_0 : KEY_PLAYPAUSE
BTN_1 : KEY_VOICECOMMAND
BTN_2 : KEY_VOLUMEUP
BTN_3 : KEY_VOLUMEDOWN

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/intel/boards/cht_bsw_nau8824.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index f456150f89c2..67b46de2f088 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -108,7 +108,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	/* NAU88L24 supports 4 butons headset detection
-	 * KEY_MEDIA
+	 * KEY_PLAYPAUSE
 	 * KEY_VOICECOMMAND
 	 * KEY_VOLUMEUP
 	 * KEY_VOLUMEDOWN
@@ -122,7 +122,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 			"Headset Jack creation failed %d\n", ret);
 		return ret;
 	}
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
-- 
2.20.1

