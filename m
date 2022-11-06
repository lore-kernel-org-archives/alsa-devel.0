Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A9AC43217
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Nov 2022 17:06:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90A9215F9;
	Sun,  6 Nov 2022 18:05:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90A9215F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667754398;
	bh=spFnfVlKiS7/MeFJFoXk3DlejXOfIoIgoxHhLFjuejU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LhvGh55dzrsUCHr0l7ykSyEuH+2QxA7ywr+7zKuqB3JCIypCcEyt5wnScGv2RYH6z
	 opX/5cLsrdMe5deVIU/Ajyn2kcW5RAKnEXQOo88F6mDy9uhqkLHz0fLoq9aIuhKpxw
	 Nu34p/N7bScpVXicaVV+cWmfJJDx9C6D5LLIwC2k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A519CF8057C;
	Sun,  6 Nov 2022 18:04:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DDA27F8056F; Sun,  6 Nov 2022 18:04:16 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45008F8056F
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2022 18:04:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45008F8056F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Xjwao+G4"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E73F560CEC;
 Sun,  6 Nov 2022 17:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A96CC433B5;
 Sun,  6 Nov 2022 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667754252;
 bh=spFnfVlKiS7/MeFJFoXk3DlejXOfIoIgoxHhLFjuejU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xjwao+G4p7m2jaPnbZLXeUJ4ImDCeoqjGgGrgBsfIVVWWktMkexEEtCRHiAu15fFE
 8OfaiOn/jDOUamtvjNIMzXpHAIsJrlozTk+WMKlZ0NDFIu6K3rbu0ELkjzn4iGYK0M
 hg6JuOA9lRbOpXnOklCK1+DS8/KVMoz0ZOled4GANg8W2r4T3ifZQUuX7JzJrb5vqi
 yYZ5ZMBEcjPb3uGk1G1SdwF19Zs0A43+oM1GRB7/naYNkHFb6W93ec1OmyMRFNNGjm
 3uItGrmcciaQ79WhezLfWIG5uBmlaV6VGlCMr2o6ib2y3cp+4hbBgJVoqaV+f+3wEc
 8wqgbHMN8LOog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 12/30] ASoC: codecs: jz4725b: fix reported volume
 for Master ctl
Date: Sun,  6 Nov 2022 12:03:24 -0500
Message-Id: <20221106170345.1579893-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221106170345.1579893-1-sashal@kernel.org>
References: <20221106170345.1579893-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, paul@crapouillou.net,
 Siarhei Volkau <lis8215@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-mips@vger.kernel.org
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

From: Siarhei Volkau <lis8215@gmail.com>

[ Upstream commit 088777bf65b98cfa4b5378119d0a7d49a58ece44 ]

DAC volume control is the Master Playback Volume at the moment
and it reports wrong levels in alsamixer and other alsa apps.

The patch fixes that, as stated in manual on the jz4725b SoC
(16.6.3.4 Programmable attenuation: GOD) the ctl range varies
from -22.5dB to 0dB with 1.5dB step.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Link: https://lore.kernel.org/r/20221016132648.3011729-3-lis8215@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index cc7a48c96aa4..72549ee2e789 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -142,8 +142,8 @@ struct jz_icdc {
 	struct clk *clk;
 };
 
-static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_dac_tlv, -2250, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_line_tlv, -1500, 600);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_dac_tlv, -2250, 150, 0);
 
 static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_DOUBLE_TLV("Master Playback Volume",
-- 
2.35.1

