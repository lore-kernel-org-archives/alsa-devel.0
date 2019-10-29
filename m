Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655BCCA9EC0
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 03:36:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63607208C0
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 03:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="humWind3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63607208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 185B3219C;
	Tue, 29 Oct 2019 04:35:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 185B3219C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572320186;
	bh=J9jYXTKN6+OpOK9DpezZOaW5nj2voUslk1OPKKAe4a4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=humWind3WBxEqSr/mKxKtux5iYVe5kAM2AzsKnnj/sjfC18Bd1iM6ZbBP0r7sYV4/
	 My+O/Xt1aI6egGq1n0MHdksnAODdznYQMYRhJhmrXYTlAnm2P5MYZIdDRSMez7ki+T
	 EY2rbnM8A0SwQWkN3n8vZ1Z3ckM4K88xuniEALD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9897DF8015A;
	Tue, 29 Oct 2019 04:35:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3E5DF80392; Tue, 29 Oct 2019 04:35:32 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE6ACF8015A
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 04:35:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE6ACF8015A
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 20:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,242,1569308400"; d="scan'208";a="229916864"
Received: from macchian.itwn.intel.com ([10.5.230.13])
 by fmsmga002.fm.intel.com with ESMTP; 28 Oct 2019 20:35:25 -0700
From: mac.chiang@intel.com
To: alsa-devel@alsa-project.org
Date: Tue, 29 Oct 2019 11:35:24 +0800
Message-Id: <1572320124-13250-1-git-send-email-mac.chiang@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: sathya.prakash.m.r@intel.com, naveen.m@intel.com, mac.chiang@intel.com,
 broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Subject: [alsa-devel] [PATCH] ASoC: Intel: bxt_da7219_max98357a: update
	dai_link platform name
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Mac Chiang <mac.chiang@intel.com>

redefine soc platform name "0000:00:1f.3" if cml core

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index ac1dea5..38b7dbe 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -40,6 +40,13 @@ struct bxt_card_private {
 	struct list_head hdmi_pcm_list;
 };
 
+static struct snd_soc_dai_link_component platform_component[] = {
+	{
+		/* name might be overridden during probe */
+		.name = "0000:00:1f.3"
+	}
+};
+
 enum {
 	BXT_DPCM_AUDIO_PB = 0,
 	BXT_DPCM_AUDIO_CP,
@@ -708,6 +715,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 				broxton_dais[i].name = "SSP0-Codec";
 				broxton_dais[i].cpus->dai_name = "SSP0 Pin";
 			}
+			broxton_dais[i].platforms = platform_component;
 		}
 	}
 
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
