Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FC6C07E9D
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 16:37:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96ACDF3;
	Mon, 26 Sep 2022 18:36:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96ACDF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664210241;
	bh=jrNU4Md5uCoD2DaRN1AMPkZ4EniGLnZshn4TTZ3T8Ig=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=egabaO4VwoO7OQ+mQr6+knp3ySCXLEB0pAJ8o96420mBIyWtVfIhqR+NQy+Sre5gx
	 +gyoc0IvXOH7noqTk/4axWe4NJ/nMf7V7Ka9ihTTXnWKV7u2r2rTeqC0xcdTqpYdYN
	 MihROZEDfMV8I1ubRl8+r+cC+mwSqPGqfrb7HI8I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 182BDF80134;
	Mon, 26 Sep 2022 18:36:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7522F8027D; Mon, 26 Sep 2022 18:36:29 +0200 (CEST)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF32EF80134
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 18:36:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF32EF80134
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 0104F5202DB;
 Mon, 26 Sep 2022 18:36:16 +0200 (CEST)
Received: from localhost.localdomain (10.72.94.2) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 18:36:15 +0200
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: soc-pcm: fix fe and be race when accessing
 substream->runtime
Date: Mon, 26 Sep 2022 18:35:54 +0200
Message-ID: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.94.2]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>,
 Eugeniu Rosca <roscaeugeniu@gmail.com>, Jiada Wang <jiada_wang@mentor.com>,
 Zhang Yanmin <yanmin.zhang@intel.com>, Ramesh Babu <ramesh.babu@intel.com>,
 Dean Jenkins <Dean_Jenkins@mentor.com>,
 Ramesh Babu B <ramesh.babu.b@intel.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 xiao jin <jin.xiao@intel.com>
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

From: xiao jin <jin.xiao@intel.com>

After start of fe and be, fe might go to close without triggering
STOP, and substream->runtime is freed. However, be is still at
START state and its substream->runtime still points to the
freed runtime.

Later on, FE is opened/started again, and triggers STOP.
snd_pcm_do_stop => dpcm_fe_dai_trigger
                => dpcm_fe_dai_do_trigger
                => dpcm_be_dai_trigger
                => dpcm_do_trigger
                => soc_pcm_trigger
                => skl_platform_pcm_trigger
skl_platform_pcm_trigger accesses the freed old runtime data and
kernel panic.

The patch fixes it by assigning be_substream->runtime in
dpcm_be_dai_startup when be's state is START.

Signed-off-by: xiao jin <jin.xiao@intel.com>
Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 sound/soc/soc-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4f60c0a83311..6ca1d02065ce 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1608,6 +1608,8 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		if (be->dpcm[stream].users++ != 0)
 			continue;
 
+		be_substream->runtime = be->dpcm[stream].runtime;
+
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_NEW) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
 			continue;
@@ -1615,7 +1617,6 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		dev_dbg(be->dev, "ASoC: open %s BE %s\n",
 			stream ? "capture" : "playback", be->dai_link->name);
 
-		be_substream->runtime = be->dpcm[stream].runtime;
 		err = __soc_pcm_open(be, be_substream);
 		if (err < 0) {
 			be->dpcm[stream].users--;
-- 
2.37.2

