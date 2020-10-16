Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77821C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:45:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F7520708
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c6AUeS2y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oQgHPYzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F7520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D560A17B5;
	Fri, 16 Oct 2020 16:44:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D560A17B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602859522;
	bh=W9YzkUFrap9HoRhbnJnn3z0qRWPGNWBgvoPRbUWxPXE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6AUeS2yUQd8svinmv3wA5ivIQ8aFBLknvqJ81s/jvwNdH3Bsf8Rxanwlqjt8qVeR
	 ZtoWAKS4zz5lDb4UadoDK8tVqd6tK+qTHzwz7hehfZIjogihdCugVJp6LkmDPxOC4B
	 WfJwIO8tirmmdyh+X2aOOKAvwQQrBveRADXQG9TM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A883F80226;
	Fri, 16 Oct 2020 16:43:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5914F80225; Fri, 16 Oct 2020 16:43:47 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCE93F80115
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 16:43:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCE93F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="oQgHPYzB"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f89b1890001>; Fri, 16 Oct 2020 07:43:21 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 14:43:31 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Oct 2020 14:43:25 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
 <kuninori.morimoto.gx@renesas.com>, <pierre-louis.bossart@linux.intel.com>,
 <perex@perex.cz>, <tiwai@suse.com>, <p.zabel@pengutronix.de>,
 <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
Subject: [PATCH v4 01/15] ASoC: soc-core: Fix component name_prefix parsing
Date: Fri, 16 Oct 2020 20:12:48 +0530
Message-ID: <1602859382-19505-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
References: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602859401; bh=OmjPVkQXuAcHfg1aXmReH5p2YM+CNTaZrB00dFKQZls=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=oQgHPYzBikRGOO/lyfdl47eLjJuz3bJ8T9H3jtw55YPlk7rDNCiFKTysKMrIEJi7w
 Mf1nr/52o2eRdqljMljaWc/iSvwO0TCIqbnk2/070Ix3hX9x0ctqsj/ItE7vi8HNlB
 UYqokTC/N5BOcai2CA1zE1Ku3ZDEmva6Aqwc43rYDBtZGp1FSwMkFK1nWmYidBLbRI
 3x/aPqBD9FFdB9alPaQMcrhcf/Fk4xB7YE7hRFohW/nhsDAv9zc+ophuHUwEpq3fXO
 FVEaNw1N3XLH36nmkHTV2wF/WmNdcDj+xNGxqaCCbkP3g+nzqbemgn3vXogIvC25NG
 NIScVhwZsxGqQ==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 nicoleotsuka@gmail.com, swarren@nvidia.com, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, atalambedu@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, nwartikar@nvidia.com, linux-tegra@vger.kernel.org,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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

The "prefix" can be defined in DAI link node or it can be specified as
part of the component node itself. Currently "sound-name-prefix" defined
in a component is not taking effect. Actually the property is not getting
parsed. It can be fixed by parsing "sound-name-prefix" property whenever
"prefix" is missing in DAI link Codec node.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/soc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ea3986a..cb7333d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1124,7 +1124,8 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 	for (i = 0; i < card->num_configs; i++) {
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
 
-		if (snd_soc_is_matching_component(&map->dlc, component)) {
+		if (snd_soc_is_matching_component(&map->dlc, component) &&
+		    map->name_prefix) {
 			component->name_prefix = map->name_prefix;
 			return;
 		}
-- 
2.7.4

