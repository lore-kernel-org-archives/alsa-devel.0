Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1769C3A5A7
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Dec 2022 09:53:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18162187D;
	Tue,  6 Dec 2022 10:53:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18162187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670320437;
	bh=7hHdQtpeJgUhhlVrjaF3QqUWI/qXbxg2b5hWeRvhBPo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ui1ajYWo+0DIKFHROVhjtXIC8TbIglASm44kpPIoB4i5liYBREr+hbS3eUHUDzfYN
	 S3x6Qufxx5awDM+rffCijLD8GR4w7C9EQfXD7pSFYcUWoEH96e5uOXhhKeWoxxPKNi
	 mhSO8QZYR+zeMQZmMJoK8HFMjKGImcuSr90xLY6w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8576F8055A;
	Tue,  6 Dec 2022 10:51:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEA11F805B4; Tue,  6 Dec 2022 10:51:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 734C6F802DB
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2022 10:51:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 734C6F802DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VEj0dAFc"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0F24D61602;
 Tue,  6 Dec 2022 09:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613E2C433C1;
 Tue,  6 Dec 2022 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670320275;
 bh=7hHdQtpeJgUhhlVrjaF3QqUWI/qXbxg2b5hWeRvhBPo=;
 h=From:To:Cc:Subject:Date:From;
 b=VEj0dAFcq4EbNd/9ZH2NN4K3RG6X0C+QAkEBjxu/g2c4M5hE9Ks+/jToLIH7o9P5H
 dtUM1wE+iA/NaOVooB8RohVVKChf+18eLwsulZpfqrIdZInaOurjAQE5kkKWDeF2o7
 WzFTGDxWeXsUvLwm7JCj4cBBbZ/tWXk4xm3WLu9cqMyhjQOPE6i6BI7wUF1AJgMexQ
 +oWWPY4cnrZ+3T/UB9thaQIOJQvF2opc3hO53CWRuBS4/BmgFNTinYfkNIrwB7sqs0
 jY2qZ9EfN4l46SA7JAmLj9xx69cEqw4QOGfepxC5vMY/eNI0ZDxwrW0WLG7DG/lSLT
 JBsKFXShzCzNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/5] ASoC: ops: Check bounds for second channel
 in snd_soc_put_volsw_sx()
Date: Tue,  6 Dec 2022 04:51:07 -0500
Message-Id: <20221206095112.987799-1-sashal@kernel.org>
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

[ Upstream commit 97eea946b93961fffd29448dcda7398d0d51c4b2 ]

The bounds checks in snd_soc_put_volsw_sx() are only being applied to the
first channel, meaning it is possible to write out of bounds values to the
second channel in stereo controls. Add appropriate checks.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220511134137.169575-2-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 453b61b42dd9..00e6a6e46fe5 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -460,6 +460,12 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	if (snd_soc_volsw_is_stereo(mc)) {
 		val_mask = mask << rshift;
 		val2 = (ucontrol->value.integer.value[1] + min) & mask;
+
+		if (mc->platform_max && val2 > mc->platform_max)
+			return -EINVAL;
+		if (val2 > max)
+			return -EINVAL;
+
 		val2 = val2 << rshift;
 
 		err = snd_soc_component_update_bits(component, reg2, val_mask,
-- 
2.35.1

