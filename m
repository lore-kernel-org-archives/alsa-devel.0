Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E648C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:49:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB5420780
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oBFSabxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB5420780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54DEB16CA;
	Thu,  2 Jul 2020 13:48:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54DEB16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593690582;
	bh=NrMB049EbaSdKCEuGikGHgUF+C94/7+6rKjFv55K8dI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oBFSabxzekzAfosLdRZogzynZG8ZqBxubU9qgG05G8/OugPUNmJ4Zl9uXsrsAXqqv
	 EjIrQnyq6M9JNgaI+dGO45/QeJMC7U0gXloM35GZzirvkU+en3e2k/8tvh8cEhljgH
	 TblrkIMOtxZ9Slg9figQBPPYOZ+GkkrbbEdxyJp0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE1AEF8022B;
	Thu,  2 Jul 2020 13:48:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1913F8022D; Thu,  2 Jul 2020 13:48:50 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED71CF80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 13:48:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED71CF80134
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1jqxhj-00067a-OM; Thu, 02 Jul 2020 11:48:35 +0000
From: Colin King <colin.king@canonical.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Subject: [PATCH][next] ASoC: Intel: bxt-da7219-max98357a: return -EINVAL on
 unrecognized speaker amplifier
Date: Thu,  2 Jul 2020 12:48:35 +0100
Message-Id: <20200702114835.37889-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Currently if the ctx->spkamp is not recognized an error message is
reported but the code continues to set up the device with uninitialized
variables such as the number of widgets.  Fix this by returning -EINVAL
for unrecognized speaker amplifier types.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: e1435a1feb18 ("ASoC: Intel: bxt-da7219-max98357a: support MAX98390 speaker amp")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 4d39253e796b..0c0a717823c4 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -677,7 +677,7 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		break;
 	default:
 		dev_err(card->dev, "Invalid speaker amplifier %d\n", ctx->spkamp);
-		break;
+		return -EINVAL;
 	}
 
 	err = snd_soc_dapm_new_controls(&card->dapm, widgets, num_widgets);
-- 
2.27.0

