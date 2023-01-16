Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CDBC46467
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Jan 2023 14:06:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0E7656D0;
	Mon, 16 Jan 2023 15:05:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0E7656D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673878004;
	bh=bBu648UyLViE+JOpdfE6UY5PG5TLk/lebaHg36/uIMA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=R6g/IcOghBUB+ZXsCM7vlx7JVdrYItTwN/am4VRggZe02SH7cUG8aGJmr14xrvuDu
	 4ut98WB/RIcdULj+cOP1tir57IqbgRPnIN/K+9JvwvwIw9AYInQMUhbRdouVVENuXr
	 WahIvMgX+MybUKj9VJxBnObrqqdY8qN9o+sVfWwk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED1BFF8057B;
	Mon, 16 Jan 2023 15:04:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A921DF8057B; Mon, 16 Jan 2023 15:04:31 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59F3CF8023B
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2023 15:04:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59F3CF8023B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B0sWkBJa
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EAB8B60FCB;
 Mon, 16 Jan 2023 14:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8129C433EF;
 Mon, 16 Jan 2023 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673877867;
 bh=bBu648UyLViE+JOpdfE6UY5PG5TLk/lebaHg36/uIMA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B0sWkBJaJk0zjn7X4k52/uifqKDkPIFhtFhEO3KnC/8M96DiCVTo852FOEANDSKJd
 ebxb2pBkoQtSi4an5sAGWXqD92MxQ2PZr+xDoIGRwU+LAdsYoCjK5ZnK2jQeHnELlp
 uH/RCkmmjPb4zsPnwPaYQTJmifJMwTwLQhT/q1TGzaD3QkUiCfXfe2+lE7lBriC7ly
 miQoqJ8J59VnpsGeBeB8bL37EwL550knZdxGhGbw7u6CdhL74XmOIUTvCd8uPWNJ00
 jy1qe4TDlvVq/DcDN5X6EhcXojeWVwP2j6zzqBCiat229ESBsCzSWK141csy6mF25s
 V3zDBT7/Mkfyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/24] ASoC: fsl-asoc-card: Fix naming of AC'97
 CODEC widgets
Date: Mon, 16 Jan 2023 09:03:50 -0500
Message-Id: <20230116140359.115716-15-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230116140359.115716-1-sashal@kernel.org>
References: <20230116140359.115716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 242fc66ae6e1e2b8519daacc7590a73cd0e8a6e4 ]

The fsl-asoc-card AC'97 support currently tries to route to Playback and
Capture widgets provided by the AC'97 CODEC. This doesn't work since the
generic AC'97 driver registers with an "AC97" at the front of the stream
and hence widget names, update to reflect reality. It's not clear to me
if or how this ever worked.

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20230106-asoc-udoo-probe-v1-2-a5d7469d4f67@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 978496c2fc09..5000d779aade 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -120,8 +120,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static const struct snd_soc_dapm_route audio_map_ac97[] = {
 	/* 1st half -- Normal DAPM routes */
-	{"Playback",  NULL, "CPU AC97 Playback"},
-	{"CPU AC97 Capture",  NULL, "Capture"},
+	{"AC97 Playback",  NULL, "CPU AC97 Playback"},
+	{"CPU AC97 Capture",  NULL, "AC97 Capture"},
 	/* 2nd half -- ASRC DAPM routes */
 	{"CPU AC97 Playback",  NULL, "ASRC-Playback"},
 	{"ASRC-Capture",  NULL, "CPU AC97 Capture"},
-- 
2.35.1

