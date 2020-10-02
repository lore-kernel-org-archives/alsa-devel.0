Return-Path: <SRS0=qvVP=DJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D09FC4363D
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 21:21:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6BB20754
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 21:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bBWpKl8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6BB20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FFFE1AEF;
	Fri,  2 Oct 2020 23:20:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FFFE1AEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601673672;
	bh=GMiy4BAFDwRhzp6kv1yeH222I45OvpYAlkvm6uZ68ow=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bBWpKl8kEFAsXAox86EXoBtosBw0vBOrWmv5OWOd72C2lgvQlB5F8Xnhg862h74qD
	 BIh+GIKD/RW8RCtu0J5CWXXF5Cj4bKmeCqI9fy+lfaW5C6BTTcLjC7Zd8FTWX8rxse
	 nF/5u8uzgtyhDwxz46ONi6Gxk1q5BOU4I/AbnF2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35C69F802DF;
	Fri,  2 Oct 2020 23:19:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC412F800AB; Fri,  2 Oct 2020 23:19:30 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A326F800AB
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 23:19:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A326F800AB
IronPort-SDR: jHb4Fn1OmGPJTtk2MtDxFrm+AN1xZvergx/1IKv+wFxCj4SMeObybnhrHWv8R0XbpM/5QWBZnQ
 qXvMXX7tX5aA==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="247823958"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; d="scan'208";a="247823958"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 14:19:16 -0700
IronPort-SDR: Sbjour1bG6YcvBQy+sq51Hz7sw/TvDo4otx5B/cFcZwcAaq+xYMyvGSRlr2SeIF9s+j5d/FuCo
 nhS6DCH9hPUQ==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; d="scan'208";a="346580604"
Received: from johnthom-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.158.101])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 14:19:16 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: Intel: sof_sdw_rt1308: add extra check on init
Date: Fri,  2 Oct 2020 16:18:59 -0500
Message-Id: <20201002211902.287692-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002211902.287692-1-pierre-louis.bossart@linux.intel.com>
References: <20201002211902.287692-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Apply same test as for other amplifiers - in case we enable feedback
one day.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw_rt1308.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw_rt1308.c b/sound/soc/intel/boards/sof_sdw_rt1308.c
index dba2fd28d77f..0d476f6f6313 100644
--- a/sound/soc/intel/boards/sof_sdw_rt1308.c
+++ b/sound/soc/intel/boards/sof_sdw_rt1308.c
@@ -132,6 +132,10 @@ int sof_sdw_rt1308_init(const struct snd_soc_acpi_link_adr *link,
 			struct sof_sdw_codec_info *info,
 			bool playback)
 {
+	/* Count amp number and do init on playback link only. */
+	if (!playback)
+		return 0;
+
 	info->amp_num++;
 	if (info->amp_num == 1)
 		dai_links->init = first_spk_init;
-- 
2.25.1

