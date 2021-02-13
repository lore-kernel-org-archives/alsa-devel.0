Return-Path: <SRS0=f0FX=HP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB72EC433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Feb 2021 10:21:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D982C64DB1
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Feb 2021 10:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D982C64DB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5578C16F0;
	Sat, 13 Feb 2021 11:20:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5578C16F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613211667;
	bh=bJF+ACufcXrrAU8NJ4ecvu6SLGonA9tORuaY/8cRvMc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U5jYgtPzwnELlliihJ//Q7hokPmWUjhAdIjP5kdcNt62tdoBhALPHfebXtcIEuRNz
	 1PVnjb1+x3hrFVQbGOzfW/xiueG7OWMa/jUaW1Ch+AGSart6Ox54YAalbMIyLcmiUp
	 Rme7BPdPwyCDdgqdSwSL/o5o7ipLhWZhn+Bds1v4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75820F8028D;
	Sat, 13 Feb 2021 11:19:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C14D7F80290; Sat, 13 Feb 2021 11:19:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95279F801D5
 for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2021 11:19:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95279F801D5
X-IronPort-AV: E=Sophos;i="5.81,175,1610406000"; d="scan'208";a="372960478"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Feb 2021 11:19:14 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/4] ASoC: mxs-saif: drop unneeded snd_soc_dai_set_drvdata
Date: Sat, 13 Feb 2021 11:19:05 +0100
Message-Id: <20210213101907.1318496-3-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
References: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
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

snd_soc_dai_set_drvdata is not needed when the set data comes from
snd_soc_dai_get_drvdata or dev_get_drvdata.  The problem was fixed
usingthe following semantic patch: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y,e;
@@
	x = dev_get_drvdata(y->dev)
	... when != x = e
-	snd_soc_dai_set_drvdata(y,x);

@@
expression x,y,e;
@@
	x = snd_soc_dai_get_drvdata(y)
	... when != x = e
-	snd_soc_dai_set_drvdata(y,x);
// </smpl>

In this case, the whole probe function then does nothing, so drop it.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/mxs/mxs-saif.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 07f8cf9980e3..6a2d24d48964 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -642,18 +642,8 @@ static const struct snd_soc_dai_ops mxs_saif_dai_ops = {
 	.set_fmt = mxs_saif_set_dai_fmt,
 };
 
-static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
-{
-	struct mxs_saif *saif = dev_get_drvdata(dai->dev);
-
-	snd_soc_dai_set_drvdata(dai, saif);
-
-	return 0;
-}
-
 static struct snd_soc_dai_driver mxs_saif_dai = {
 	.name = "mxs-saif",
-	.probe = mxs_saif_dai_probe,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,

