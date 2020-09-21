Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11340C43468
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:45:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EC921D91
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eE6Bkf3K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDGU34LG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EC921D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9ED616DE;
	Mon, 21 Sep 2020 16:44:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9ED616DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600699547;
	bh=Y/rU4Kl8mzIytkEa5q3OGx+tpP2TRJ7q1NdFMAg0QeQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eE6Bkf3KOnkNuylXsQYngGVjCg8ZjgjGcJtMtZAI2zD3gVNQwnzxUj4nHk3glhx9+
	 d8eD+epQAkqBkz4W+hlf5vs2Rb9uq2JxGlpZ24tkh95QdmdpkDgICQicy5AlqOS/aK
	 sChbucGeN3t76I/nH1iYENwmL4p06nnlKZ3JApdc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7997DF802FF;
	Mon, 21 Sep 2020 16:41:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C9DEF80305; Mon, 21 Sep 2020 16:41:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AA2DF802E0
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 16:40:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AA2DF802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dDGU34LG"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2F372388E;
 Mon, 21 Sep 2020 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600699257;
 bh=Y/rU4Kl8mzIytkEa5q3OGx+tpP2TRJ7q1NdFMAg0QeQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dDGU34LGyePs9qNHVgXrh0IWle3mmW0gWoSvzOiHs1lGNNx9kOFnlK/oLBrZ8XJP3
 trAOrjbiXPGHDbqPokr4RB3r0UqCR/0mlTJM/unKMaavQSBaX71Coq06/HvOTNeC9c
 O+7sUcYmQxF3+6XNBDIMAm803onDHQXDkSX3OfP4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/15] ASoC: pcm3168a: ignore 0 Hz settings
Date: Mon, 21 Sep 2020 10:40:41 -0400
Message-Id: <20200921144054.2135602-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921144054.2135602-1-sashal@kernel.org>
References: <20200921144054.2135602-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
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

[ Upstream commit 7ad26d6671db758c959d7e1d100b138a38483612 ]

Some sound card try to set 0 Hz as reset, but it is impossible.
This patch ignores it to avoid error return.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87a6yjy5sy.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 88b75695fbf7f..b37e5fbbd301a 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -302,6 +302,13 @@ static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(dai->component);
 	int ret;
 
+	/*
+	 * Some sound card sets 0 Hz as reset,
+	 * but it is impossible to set. Ignore it here
+	 */
+	if (freq == 0)
+		return 0;
+
 	if (freq > PCM3168A_MAX_SYSCLK)
 		return -EINVAL;
 
-- 
2.25.1

