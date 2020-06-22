Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E82C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:46:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B547A2073E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JeWHIr0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B547A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EA2516F9;
	Mon, 22 Jun 2020 17:45:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EA2516F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592840762;
	bh=t6KlqSVgkZEmnSYE150eL1rlgAYHOXaDlaamVz7yPWs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JeWHIr0WfdVHgE0JWBRPIGJxfPoYc44ghjJTOyR4KQUk6SyeCxXENiJemgcuJ0LFy
	 IDQOVNg24sOMAoBehlfnr5e43OAcRBLZkNrv6vhUC4nFK76q3Yz0WmphaiPZOpC53X
	 HUmsrRe40TagD4jd/4EKBbAOnwg16Dq+HdfIIrow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 207FCF802A1;
	Mon, 22 Jun 2020 17:43:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4275AF801F2; Mon, 22 Jun 2020 17:43:04 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86670F801F2
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 17:42:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86670F801F2
IronPort-SDR: Lwged1J0cIh8d9zy3YlO5Q9wR6/drp6EuQlWEzwOyg2Qsv/dD515Rm+dgL47FHGnl0dFq8IXUQ
 cc+t0vgLOtKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="141300456"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; d="scan'208";a="141300456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 08:42:52 -0700
IronPort-SDR: 5G/bM/zOJ6baXuJCD8qSqDlm61tZs2sLSNmP0lsgbKXoLSkTpliYHYJhDZrP2zU9t9ZwY8Z75r
 8MwfeM56hbsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; d="scan'208";a="478425163"
Received: from somsubhr-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.74.194])
 by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 08:42:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] ASoC: intel: cml_rt1011_rt5682: disable jack in dailink
 .exit()
Date: Mon, 22 Jun 2020 10:42:41 -0500
Message-Id: <20200622154241.29053-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
References: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

From: Fred Oh <fred.oh@linux.intel.com>

When removing the machine driver, the rt5682 jack handler will oops if jack
detection is not disabled. The jack can be disabled in the dai link's exit().

This is symmetrical change as jack is enabled in init().

Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cml_rt1011_rt5682.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index 68eff29daf8f..189c908c4aa8 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -161,6 +161,13 @@ static int cml_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 };
 
+static void cml_rt5682_codec_exit(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
 static int cml_rt1011_spk_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret = 0;
@@ -415,6 +422,7 @@ static struct snd_soc_dai_link cml_rt1011_rt5682_dailink[] = {
 		.name = "SSP0-Codec",
 		.id = 0,
 		.init = cml_rt5682_codec_init,
+		.exit = cml_rt5682_codec_exit,
 		.ignore_pmdown_time = 1,
 		.ops = &cml_rt5682_ops,
 		.dpcm_playback = 1,
-- 
2.20.1

