Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D9DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 22:35:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642EE61359
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 22:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 642EE61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C8C8179D;
	Tue, 14 Sep 2021 00:34:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C8C8179D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631572541;
	bh=ecIaMXb+m7FDhBfUMgGoGyY9OZ2Pm2kgMizHBu5cn38=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pqIjW7e6HESeT1B3Z0Ngd+iDj2lRRL0SaIuZ67UgfQmgpEFLUOX1vlTucjqoL3GK9
	 1oSb0gZugGidaR3i5U9uJukecZJPENlvBP3rK0FaAYjuVXnE85kUOL4hwJhU94L+Tg
	 l4fAq6muhkI5PspE7VUBA8HIfHyGC3pOdHWk26fg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51583F8032C;
	Tue, 14 Sep 2021 00:34:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89E40F8049E; Tue, 14 Sep 2021 00:34:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62B6BF80169
 for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2021 00:34:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62B6BF80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DJYUSf5f"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E54861163;
 Mon, 13 Sep 2021 22:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631572465;
 bh=ecIaMXb+m7FDhBfUMgGoGyY9OZ2Pm2kgMizHBu5cn38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DJYUSf5f9S0bay/cp04CV77OdAYtBkiAXDqCk0gh7Cz/RWJNolHoD4sOSgPk1L8qx
 Zz7P3QKJormmfdNi1I16ddyCvWRVrZXuJ3Y4RbEC3mh0q5ujZBvC0Hlh5QEfPOSFsC
 fw9h2/N4HRcC5AmJjpKF9SBMkUWQTj80nSRcdcCy0vi2QRYjTbH8H7q5G8kuzQXkum
 w5fUMQVGqUsLB8Gy2uV9BxLG/I/3i8QaEFTSK4bcWh0FddBOLKKvaVFn6SKIeNJmAC
 PeDYxqf0xqC+/g+N2tAy4Bqk9nmsOzVFz/A4Lezz/dn3w7f5LvzjyKkR5Bvy5KnF7m
 sOhLEReuFx6Zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 07/19] ASoC: audio-graph: respawn Platform Support
Date: Mon, 13 Sep 2021 18:34:03 -0400
Message-Id: <20210913223415.435654-7-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913223415.435654-1-sashal@kernel.org>
References: <20210913223415.435654-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Olivier MOYSAN <olivier.moysan@foss.st.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 5f939f49771002f347039edf984aca42f30fc31a ]

commit 63f2f9cceb09f8 ("ASoC: audio-graph: remove Platform support")
removed Platform support from audio-graph, because it doesn't have
"plat" support on DT (simple-card has).
But, Platform support is needed if user is using
snd_dmaengine_pcm_register() which adds generic DMA as Platform.
And this Platform dev is using CPU dev.

Without this patch, at least STM32MP15 audio sound card is no more
functional (v5.13 or later). This patch respawn Platform Support on
audio-graph again.

Reported-by: Olivier MOYSAN <olivier.moysan@foss.st.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Olivier MOYSAN <olivier.moysan@foss.st.com>
Link: https://lore.kernel.org/r/878s0jzrpf.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 5e71382467e8..546f6fd0609e 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -285,6 +285,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	if (li->cpu) {
 		struct snd_soc_card *card = simple_priv_to_card(priv);
 		struct snd_soc_dai_link_component *cpus = asoc_link_to_cpu(dai_link, 0);
+		struct snd_soc_dai_link_component *platforms = asoc_link_to_platform(dai_link, 0);
 		int is_single_links = 0;
 
 		/* Codec is dummy */
@@ -313,6 +314,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 			dai_link->no_pcm = 1;
 
 		asoc_simple_canonicalize_cpu(cpus, is_single_links);
+		asoc_simple_canonicalize_platform(platforms, cpus);
 	} else {
 		struct snd_soc_codec_conf *cconf = simple_props_to_codec_conf(dai_props, 0);
 		struct snd_soc_dai_link_component *codecs = asoc_link_to_codec(dai_link, 0);
@@ -366,6 +368,7 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
 	struct snd_soc_dai_link_component *cpus = asoc_link_to_cpu(dai_link, 0);
 	struct snd_soc_dai_link_component *codecs = asoc_link_to_codec(dai_link, 0);
+	struct snd_soc_dai_link_component *platforms = asoc_link_to_platform(dai_link, 0);
 	char dai_name[64];
 	int ret, is_single_links = 0;
 
@@ -383,6 +386,7 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 		 "%s-%s", cpus->dai_name, codecs->dai_name);
 
 	asoc_simple_canonicalize_cpu(cpus, is_single_links);
+	asoc_simple_canonicalize_platform(platforms, cpus);
 
 	ret = graph_link_init(priv, cpu_ep, codec_ep, li, dai_name);
 	if (ret < 0)
@@ -608,6 +612,7 @@ static int graph_count_noml(struct asoc_simple_priv *priv,
 
 	li->num[li->link].cpus		= 1;
 	li->num[li->link].codecs	= 1;
+	li->num[li->link].platforms     = 1;
 
 	li->link += 1; /* 1xCPU-Codec */
 
@@ -630,6 +635,7 @@ static int graph_count_dpcm(struct asoc_simple_priv *priv,
 
 	if (li->cpu) {
 		li->num[li->link].cpus		= 1;
+		li->num[li->link].platforms     = 1;
 
 		li->link++; /* 1xCPU-dummy */
 	} else {
-- 
2.30.2

