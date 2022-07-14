Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE6BC43334
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jul 2022 04:40:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B53C1A42;
	Thu, 14 Jul 2022 06:39:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B53C1A42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657773639;
	bh=sN7vWqDvnCjutFF1izI4mZX9UdD/N9GNfdT2bXLPyGo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mmwDhq81S9HP01ofsMPYw22k3ZTqj/C0ds/6TM7Ta1wTlIyD5txyQazggRa4Tt+sX
	 xi5RWi1+PkGOT2Z07QooBoXz6eoK8wV9E8nq5V0h6bHdMHT7jPurIlmmTHodUJiBwu
	 Hin3OGW3nsz73rECdzSA5vErTJdn8CK6JuaxA2iI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28BE9F805E0;
	Thu, 14 Jul 2022 06:27:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40B65F805E0; Thu, 14 Jul 2022 06:27:02 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C375EF80735
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2022 06:26:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C375EF80735
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HFH+NGJb"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2E901B8236E;
 Thu, 14 Jul 2022 04:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBAAC34114;
 Thu, 14 Jul 2022 04:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657772815;
 bh=sN7vWqDvnCjutFF1izI4mZX9UdD/N9GNfdT2bXLPyGo=;
 h=From:To:Cc:Subject:Date:From;
 b=HFH+NGJbeucW2pifZqKyEfKt2qVygFz/y5ySvg0rwuaHEZ0HEmnb1IT4Nes6CM9+R
 G9Qh3MiD+3sW3ovsBICMVN6uQleadHDUa0wmKQBtpfmK3XKHzJ8kgwhIC2p3H2BH4B
 AaYat0L0X6793qMtzxEeEzC7EjyYk0IYmN2z8RT4odTqSxYMLIcNGVLau/lgzadBlM
 k7ylAImoETH7GLec8PQNlK//DMCvCHdMDeMRcalBCd/ITd96ddrIX/vNQGZXrrhs26
 XS2K6x1seDFeb458FWFtiFh8fAfM80YQfEtiYBhyG1muqQ2HdkRSQsVdGKbAfRI5ef
 /cYnbF9F2BWXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 1/5] ASoC: ops: Fix off by one in range control
 validation
Date: Thu, 14 Jul 2022 00:26:48 -0400
Message-Id: <20220714042653.282599-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>
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

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 5871321fb4558c55bf9567052b618ff0be6b975e ]

We currently report that range controls accept a range of 0..(max-min) but
accept writes in the range 0..(max-min+1). Remove that extra +1.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220604105246.4055214-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 0848aec1bd24..81c9ecfa7c7f 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -535,7 +535,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 	if (mc->platform_max && tmp > mc->platform_max)
 		return -EINVAL;
-	if (tmp > mc->max - mc->min + 1)
+	if (tmp > mc->max - mc->min)
 		return -EINVAL;
 
 	if (invert)
@@ -556,7 +556,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 			return -EINVAL;
 		if (mc->platform_max && tmp > mc->platform_max)
 			return -EINVAL;
-		if (tmp > mc->max - mc->min + 1)
+		if (tmp > mc->max - mc->min)
 			return -EINVAL;
 
 		if (invert)
-- 
2.35.1

