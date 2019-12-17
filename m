Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7CC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:58:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22A821835
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HngBvDyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22A821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB4511615;
	Tue, 17 Dec 2019 17:57:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB4511615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576601928;
	bh=5mnoTxmoL65aGZUUTNEAyChqlQR3mDZjN2TzyPt7+bw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HngBvDyNGuKAGSA9potgxIVS0lB2MgAsiwHcYOIalaF1o6O377NoPGBGme11wBi8+
	 Wc5YXTSL0MnzV7lk2uWQEEmBwnWg8pMICTHLGebB2cc88E3yn3Xk7PqjzkddFlAi25
	 gpQ9a2ZIsh3a10Eaz49S1m0s1ErEZ6EwZHgmuTes=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1603FF8025A;
	Tue, 17 Dec 2019 17:57:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1C9AF8025A; Tue, 17 Dec 2019 17:57:04 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79341F80100
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 17:57:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79341F80100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 08:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; d="scan'208";a="416903359"
Received: from krose-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.184.73])
 by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2019 08:56:54 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Dec 2019 10:56:49 -0600
Message-Id: <20191217165649.12091-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217165649.12091-1-pierre-louis.bossart@linux.intel.com>
References: <20191217165649.12091-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [alsa-devel] [PATCH] ASoC: Intel: cml_rt1011_rt5682: use
	snd_soc_dai_link_component for codec_conf
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

We can use snd_soc_dai_link_component to specify codec_conf.
Let's use it.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Fixes: ee8f537fd8b71c ("ASoC: soc-core: remove legacy style of codec_conf")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cml_rt1011_rt5682.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index a22f97234201..ab1196108d23 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -406,19 +406,19 @@ static struct snd_soc_dai_link cml_rt1011_rt5682_dailink[] = {
 
 static struct snd_soc_codec_conf rt1011_conf[] = {
 	{
-		.dev_name = "i2c-10EC1011:00",
+		.dlc = COMP_CODEC_CONF("i2c-10EC1011:00"),
 		.name_prefix = "WL",
 	},
 	{
-		.dev_name = "i2c-10EC1011:01",
+		.dlc = COMP_CODEC_CONF("i2c-10EC1011:01"),
 		.name_prefix = "WR",
 	},
 	{
-		.dev_name = "i2c-10EC1011:02",
+		.dlc = COMP_CODEC_CONF("i2c-10EC1011:02"),
 		.name_prefix = "TL",
 	},
 	{
-		.dev_name = "i2c-10EC1011:03",
+		.dlc = COMP_CODEC_CONF("i2c-10EC1011:03"),
 		.name_prefix = "TR",
 	},
 };
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
