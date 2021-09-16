Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFFBC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 14:15:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A3A61212
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 14:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3A3A61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 326E7188F;
	Thu, 16 Sep 2021 16:14:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 326E7188F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631801718;
	bh=Nb1vFDiuTk6CWhu18ieOgR/Jj0Ejh0bkZNiEyZkjhqw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i0zXSR/j5CUcEKzwqUFRgNDaFQikm+NhflaBMxS2nAwoMGUBqYmqC1LpS8ZCYGKdD
	 WYYivs1AMTOezN+E/fxvDrubwB8wy46Fj+YqOjm9t3DnzXrlhHi9/gXJKslTeZFF/X
	 rOE/3u87bYZmpvoSbvwBkGj0MSZdwJFbymsZBBKQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1305F8025A;
	Thu, 16 Sep 2021 16:14:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B6EEF8025E; Thu, 16 Sep 2021 16:14:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89A67F80113
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 16:14:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89A67F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="R0JCgk1d"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EDCF61212;
 Thu, 16 Sep 2021 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631801660;
 bh=Nb1vFDiuTk6CWhu18ieOgR/Jj0Ejh0bkZNiEyZkjhqw=;
 h=From:To:Cc:Subject:Date:From;
 b=R0JCgk1ddwf51cS+9rRW6t0R5GCP+CntQKL5bOVuC0T1g8kc7nzYkKdN7SaxVpS5V
 jVnXlCbElp30JEEr8ySkt4r3syeZH8NzCU6MiORyetVONOV6wSunlqBSdoDHxZblra
 mml4Ujef4EtBmjtLS4b1TI/LTrZ0fkZWLZgfbSv8eDzhavmWkJsSqa1y9utlXWLnKZ
 LIMqUN0yy8OtnjHFxqiEUGDKqMQ+S4XG30MUgLEsofwRHWcTl7kfopvXkBu0IkuBY0
 2SFMPw89cOctjj88w0hAX08ptA73V46MyqH3VTG/VBOanFkm4WfqbYyPdrFtToINBS
 SaBAzEvr5v2Rw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: ab8500: Update to modern clocking terminology
Date: Thu, 16 Sep 2021 15:13:35 +0100
Message-Id: <20210916141335.43818-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2011; h=from:subject;
 bh=Nb1vFDiuTk6CWhu18ieOgR/Jj0Ejh0bkZNiEyZkjhqw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhQ1AzZaBeEyR+Hhja2rBo0Jjk67tSxJ+lT4SGXdOc
 NawR7s6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUNQMwAKCRAk1otyXVSH0MYtB/
 9aeKaxGSwAkbHD/7IbB4fs2jB55LNaEaNe4pqYptJP/dZ4QopCDKDBs/9gg4o3mZoKlEmc9cGzqWLa
 EtAbxPTjvyelT/xdxIZ2+WBQvEBhpQuUPw67QDNzaHHscWtWOj/kmHFQRchguiirqoUw3YZzEHii53
 yvy2GQEfsTCbaMjyxTxcTnSiCSOxMes92AOgJ3dq0itKl/XGfQKdf1AV+nOhQKXvC9rlN4OJvXUKDE
 goAntqq6z0R1N0sTB5klEXJE3Szrd5Rc2gqSo0kuBZHenGI3SlRg1lsRrdnfLqueXTuYTtv5afA9vx
 ub96ILJqIDlwSn1pibXKNHzYMr16Di
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
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

As part of moving to remove the old style defines for the bus clocks update
the ab8500 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 5525e1ccab76..aefafb0b7b97 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2104,26 +2104,26 @@ static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			BIT(AB8500_DIGIFCONF3_IF0MASTER);
 	val = 0;
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & FRM master */
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
 		dev_dbg(dai->component->dev,
-			"%s: IF0 Master-mode: AB8500 master.\n", __func__);
+			"%s: IF0 Master-mode: AB8500 provider.\n", __func__);
 		val |= BIT(AB8500_DIGIFCONF3_IF0MASTER);
 		break;
-	case SND_SOC_DAIFMT_CBS_CFS: /* codec clk & FRM slave */
+	case SND_SOC_DAIFMT_CBC_CFC:
 		dev_dbg(dai->component->dev,
-			"%s: IF0 Master-mode: AB8500 slave.\n", __func__);
+			"%s: IF0 Master-mode: AB8500 consumer.\n", __func__);
 		break;
-	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & FRM master */
-	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame slave */
+	case SND_SOC_DAIFMT_CBC_CFP:
+	case SND_SOC_DAIFMT_CBP_CFC:
 		dev_err(dai->component->dev,
-			"%s: ERROR: The device is either a master or a slave.\n",
+			"%s: ERROR: The device is either a provider or a consumer.\n",
 			__func__);
 		fallthrough;
 	default:
 		dev_err(dai->component->dev,
-			"%s: ERROR: Unsupporter master mask 0x%x\n",
-			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
+			"%s: ERROR: Unsupporter clocking mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK);
 		return -EINVAL;
 	}
 
-- 
2.20.1

