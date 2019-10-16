Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C958EFA372A
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:44:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CF720854
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZvMpg3ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CF720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A982845;
	Wed, 16 Oct 2019 14:43:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A982845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571229861;
	bh=ExSgKMSvfqWNoviCgzB4DYsWlCE8/6AaekifM5cfcQo=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZvMpg3veJyo+/w5YcI/ys+Il3ohr5oiGQ3J5mplB+0Ju2csNHrQ8L2VyynszpRNXX
	 x5EconI8nHYOSf636daZXskMB85dunQQOAHWfYVzJ50xsLqwWH31o3d0vaUIp5rK9T
	 3A6Qw9SlQMwMS1o6zIcliU2U9JJvv3QTaUYeJInY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FEB4F80323;
	Wed, 16 Oct 2019 14:43:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01478F80362; Wed, 16 Oct 2019 14:43:29 +0200 (CEST)
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32CE4F80276
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 14:43:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32CE4F80276
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id 1520C3C057C;
 Wed, 16 Oct 2019 14:43:21 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mna5zdhg1cQk; Wed, 16 Oct 2019 14:43:15 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 76CDF3C003F;
 Wed, 16 Oct 2019 14:43:15 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Wed, 16 Oct 2019 14:43:15 +0200
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav
 Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
 <alsa-devel@alsa-project.org>
Date: Wed, 16 Oct 2019 14:42:55 +0200
Message-ID: <20191016124255.7442-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Originating-IP: [10.72.93.184]
Cc: Timo Wischer <twischer@de.adit-jv.com>,
 Andrew Gabbasov <andrew_gabbasov@mentor.com>,
 Eugeniu Rosca <roscaeugeniu@gmail.com>, Jiada Wang <jiada_wang@mentor.com>,
 Junya Monden <jmonden@jp.adit-jv.com>, stable@vger.kernel.org,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [alsa-devel] [PATCH] ASoC: rsnd: Reinitialize bit clock inversion
	flag for every format setting
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

From: Junya Monden <jmonden@jp.adit-jv.com>

Unlike other format-related DAI parameters, rdai->bit_clk_inv flag
is not properly re-initialized when setting format for new stream
processing. The inversion, if requested, is then applied not to default,
but to a previous value, which leads to SCKP bit in SSICR register being
set incorrectly.
Fix this by re-setting the flag to its initial value, determined by format.

Fixes: 1a7889ca8aba3 ("ASoC: rsnd: fixup SND_SOC_DAIFMT_xB_xF behavior")
Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: Jiada Wang <jiada_wang@mentor.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>
Cc: stable@vger.kernel.org # v3.17+
Signed-off-by: Junya Monden <jmonden@jp.adit-jv.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 sound/soc/sh/rcar/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index bda5b958d0dc..e9596c2096cd 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -761,6 +761,7 @@ static int rsnd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set format */
+	rdai->bit_clk_inv = 0;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		rdai->sys_delay = 0;
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
