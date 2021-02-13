Return-Path: <SRS0=f0FX=HP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FBFC433E6
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Feb 2021 10:21:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C242864E4C
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Feb 2021 10:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C242864E4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 463951726;
	Sat, 13 Feb 2021 11:21:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 463951726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613211715;
	bh=YF13UcGnuLVf3lzvK71UoH9C2eXEAY1J+bHSaflAqOI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ag3GBi3y5UPuhnpqHG+c7qDwRHHUh1rMYGtKEZC7e5RxUfybLjgFSOuD6ojqOdm7F
	 ncWo0ZzK4hQQYkbfmfd2FtyEmfXZtpBwJWHxIp3GAKdBvV5HimgxrITG7+5ldLtovr
	 CtKbL+dmWdqwYwSxC8OEzqrLqoUqF2oPWA4EO/qw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC6DCF802DB;
	Sat, 13 Feb 2021 11:19:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE07EF802CA; Sat, 13 Feb 2021 11:19:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D23EFF801EB
 for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2021 11:19:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D23EFF801EB
X-IronPort-AV: E=Sophos;i="5.81,175,1610406000"; d="scan'208";a="372960480"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Feb 2021 11:19:14 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Timur Tabi <timur@kernel.org>
Subject: [PATCH 4/4] ASoC: fsl: drop unneeded snd_soc_dai_set_drvdata
Date: Sat, 13 Feb 2021 11:19:07 +0100
Message-Id: <20210213101907.1318496-5-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
References: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 linux-kernel@vger.kernel.org
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

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/fsl/fsl_micfil.c |    2 --
 sound/soc/fsl/fsl_sai.c    |    2 --
 sound/soc/fsl/fsl_xcvr.c   |    1 -
 3 files changed, 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 8aedf6590b28..fd21017fa2bd 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -423,8 +423,6 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 		return ret;
 	}
 
-	snd_soc_dai_set_drvdata(cpu_dai, micfil);
-
 	return 0;
 }
 
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5e65b456d3e2..8876d0ed37d9 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -727,8 +727,6 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	snd_soc_dai_init_dma_data(cpu_dai, &sai->dma_params_tx,
 				&sai->dma_params_rx);
 
-	snd_soc_dai_set_drvdata(cpu_dai, sai);
-
 	return 0;
 }
 
diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index dd228b421e2c..8a3bde718697 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -869,7 +869,6 @@ static int fsl_xcvr_dai_probe(struct snd_soc_dai *dai)
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
 
 	snd_soc_dai_init_dma_data(dai, &xcvr->dma_prms_tx, &xcvr->dma_prms_rx);
-	snd_soc_dai_set_drvdata(dai, xcvr);
 
 	snd_soc_add_dai_controls(dai, &fsl_xcvr_mode_kctl, 1);
 	snd_soc_add_dai_controls(dai, &fsl_xcvr_arc_mode_kctl, 1);

