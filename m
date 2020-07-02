Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C6BC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:46:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6027C20720
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QEJddxYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6027C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA7E616E1;
	Thu,  2 Jul 2020 18:45:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA7E616E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593708398;
	bh=7TdBU5azYxUMfvml6P4DqBwjw63TkzgTD2OadDcpDQA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QEJddxYkKdBEVanuQwZithUTBCNFJv2HS9nvL3l70WTBWYdRaGtHhiBeP+16TgJdy
	 HrY7n42AgYs64CkndKSnVN9/WZWXfdtq5CFER3sUJaCizs+S0gds34zb2Km0UWK9EK
	 L9BR5VtJlSN+4neVWYsQOFJtVIa7akjtQ+UoCulU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D71E2F800C1;
	Thu,  2 Jul 2020 18:44:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7828FF8022B; Thu,  2 Jul 2020 18:44:57 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF069F8022B
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 18:44:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF069F8022B
IronPort-SDR: ywJpt7C49NZcw8cIF1vPMiyxicq8o/bGyjIPannKbhelYTqex15/3eSBqx/PTVUiM/0piVJaCJ
 PLhNURPBZreQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="144470126"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="144470126"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:44:47 -0700
IronPort-SDR: z+xYaj+5s1cpJ11hQ8XeMU9jBrjFzEBz2twjS3wxiebeBZQlooCPH/QCJg6LUgFBIXat0GLPzf
 gXP7uMMdlJig==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="426011053"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:44:46 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/6] ASoC: amd: acp-da7219-max98357a: fix 'defined but not
 used' warning
Date: Thu,  2 Jul 2020 11:44:28 -0500
Message-Id: <20200702164433.162815-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702164433.162815-1-pierre-louis.bossart@linux.intel.com>
References: <20200702164433.162815-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 broonie@kernel.org, Akshu Agrawal <akshu.agarawal@amd.com>,
 Yu-Hsuan Hsu <yuhsuan@chromium.org>
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

Fix W=1 warning

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 9414d7269c4f..7d8986379d80 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -450,11 +450,13 @@ static int cz_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id cz_audio_acpi_match[] = {
 	{ "AMD7219", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cz_audio_acpi_match);
+#endif
 
 static struct platform_driver cz_pcm_driver = {
 	.driver = {
-- 
2.25.1

