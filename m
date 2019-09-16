Return-Path: <SRS0=lXbg=XL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EACC49ED7
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 19:26:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DBE20665
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 19:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="utEixPex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DBE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D20A1672;
	Mon, 16 Sep 2019 21:25:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D20A1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568661991;
	bh=ZuPSpFOLMOILR2e32a1GGqc7gsdrrcPPh9hBhenFlSE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=utEixPexdjT1KnlH6Lfa4Z38fW21cVxDhfS0grZV1oeqRsm7bBt2ig/dRCWRpkMHn
	 zETsSy81zbsvi3ZGDnU39G2/X6tlenjelI65A63IZXAQNfU2g7Iqi4XZRI9aT4HFQT
	 9M0CcKx2id2JAYkIYk+fQLhFvNKjJAyFJytpEhAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C54AEF805FA;
	Mon, 16 Sep 2019 21:24:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEEADF804FF; Mon, 16 Sep 2019 21:24:00 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61C60F804FF
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 21:23:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61C60F804FF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Sep 2019 12:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; d="scan'208";a="270291170"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.104.227])
 by orsmga001.jf.intel.com with ESMTP; 16 Sep 2019 12:23:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 16 Sep 2019 14:23:44 -0500
Message-Id: <20190916192348.467-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
References: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH 2/6] soundwire: remove DAI_ID_RANGE definitions
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

There is no reason to reserve a range of DAI IDs for SoundWire. This
is not scalable and it's better to let the ASoC core allocate the
dai->id when registering a component.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c     | 2 --
 include/linux/soundwire/sdw.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1814f6168801..c158a1d19a05 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -873,8 +873,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 			dais[i].capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
 		}
 
-		dais[i].id = SDW_DAI_ID_RANGE_START + i;
-
 		if (pcm)
 			dais[i].ops = &intel_pcm_dai_ops;
 		else
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ea787201c3ac..688b40e65c89 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -40,9 +40,6 @@ struct sdw_slave;
 
 #define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
 
-#define SDW_DAI_ID_RANGE_START		100
-#define SDW_DAI_ID_RANGE_END		200
-
 enum {
 	SDW_PORT_DIRN_SINK = 0,
 	SDW_PORT_DIRN_SOURCE,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
