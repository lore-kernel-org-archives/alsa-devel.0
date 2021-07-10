Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAFAC07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:30:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEB8613B7
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEB8613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FB5116F7;
	Sat, 10 Jul 2021 04:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FB5116F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884218;
	bh=ZKJVrmLYGVPSJrHqQHBq6fK9ClMXludSvV3cqZNaBzE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lLaJtDzljU2mGDpC/rhn6dMZORLJkPkYJ5cfI1rgdYaJx2iYoQVBzwuONz4eed615
	 57KL4ubHs2mWThoUn7jmgM04POAV/Yj7O5OvF9uT9mB9uRZLYZyxYQvd62jmDR6mBh
	 OQ5/vUFauqtOe4hvQkxOnQUEhSuxlmM7kx0v7T9E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5B91F8052D;
	Sat, 10 Jul 2021 04:23:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F7F9F80536; Sat, 10 Jul 2021 04:23:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C49FF80567
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:23:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C49FF80567
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Up+dlVWq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 031D8613ED;
 Sat, 10 Jul 2021 02:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883799;
 bh=ZKJVrmLYGVPSJrHqQHBq6fK9ClMXludSvV3cqZNaBzE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Up+dlVWqLtFsfSJ5ZvPnuEPab5OYeSJG5y+B/R59+/IGdsWQSQZPJtPjKH8Scx7N+
 Eramb7DgDzE2sGrZ5NVUl+/WrqX6EWJ3TH/RqyirZY+GLxQQ/oOOfqrVdsxWHN82+S
 bX/WFAGABkpOJZCGNwQWc1hwKkgpGiLwZ3O4esdSgY/7XEKt1NQzVvsLIslS9QS+A9
 rWunVa2j6bzWaXFI55KDULgZ+5V/tZvf5F0pleKtLNXIwwOZdHnA2Jln4HeONoT6GD
 bLOk1CmdNOoXbWcGdPkYYFOJTccgGGfBrnIZWJW6FX4WAqekNxs7U4PexPDqpdHjmD
 GQrZaMXbRJK0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 063/104] ASoC: soc-pcm: fix the return value in
 dpcm_apply_symmetry()
Date: Fri,  9 Jul 2021 22:21:15 -0400
Message-Id: <20210710022156.3168825-63-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022156.3168825-1-sashal@kernel.org>
References: <20210710022156.3168825-1-sashal@kernel.org>
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

From: Jaroslav Kysela <perex@perex.cz>

[ Upstream commit 12ffd726824a2f52486f72338b6fd3244b512959 ]

In case, where the loops are not executed for a reason, the uninitialized
variable 'err' is returned to the caller. Make code fully predictible
and assign zero in the declaration.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20210614071746.1787072-1-perex@perex.cz
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 14d85ca1e435..4a25a1e39831 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1695,7 +1695,7 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(fe_substream);
 	struct snd_soc_dai *fe_cpu_dai;
-	int err;
+	int err = 0;
 	int i;
 
 	/* apply symmetry for FE */
-- 
2.30.2

