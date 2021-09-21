Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9FDC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:40:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6D661159
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B6D661159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB81216AD;
	Tue, 21 Sep 2021 23:39:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB81216AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632260440;
	bh=7aZeUplfK5FIw57TTz+BqraFodfiICmaUpVRsJfChZE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=roTrX7a5WbtTHfxHCD5oUokfoaRtALICdr54xQgEyqWucNqX1IYuHkW3SqupjxwQk
	 6RyXJwP7CylRLOsZec1F/Amk1Xka4sIuOsJqMghSMrcJhKMptYXwgnOlg/mhk6MGom
	 pbmxvXz+LmHVSnbmDYo6YXC9pX0ZXT5d5h1+tDRs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F4E6F8051A;
	Tue, 21 Sep 2021 23:37:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E77FCF8051B; Tue, 21 Sep 2021 23:37:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 774A8F80515
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:37:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 774A8F80515
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qA08s/wx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F19C661159;
 Tue, 21 Sep 2021 21:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632260227;
 bh=7aZeUplfK5FIw57TTz+BqraFodfiICmaUpVRsJfChZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qA08s/wx8q3dFLMOFErpwMkr6mYz1UsNnw00dnHKS11X3oqmdlWvg4xf8VNYJbK23
 YGJ86c6ofhwtyaUDRfICsXx5VH9adsKloxHWsnbuHIIMBDvritVG+jb2D4unn4zazK
 Dv4k3hztCwh/tR/QQUpT6acxdMVxPqEYuaWsmMGSu02JNQBwgG0DyU0pBb683ygjER
 zM5ysrrb6Gg1mSlIl4qjB0NIVi0pW8sweyvHKi2DYZxri5eimr0d7ZmL1tyHovtgYK
 VsZkm93hM92dhQiL8fPRWCBqk2GVH60817z6XFWRu0Xm9XJEuq1edvZtw4cLYaD9US
 z0PUdvBDWzW1w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH v2 09/16] ASoC: imx-card: Update to modern clocking terminology
Date: Tue, 21 Sep 2021 22:35:35 +0100
Message-Id: <20210921213542.31688-9-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921213542.31688-1-broonie@kernel.org>
References: <20210921213542.31688-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=755; h=from:subject;
 bh=7aZeUplfK5FIw57TTz+BqraFodfiICmaUpVRsJfChZE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSk8Z5y01gwCdTS5VjWmRZez9dl1P2h1FuUCCfjJ0
 SQkUd8KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpPGQAKCRAk1otyXVSH0LErB/
 4oaUZCM3nnbVzSi86egkGj1gDDHIyt1qlhyjKZUsv4DiIPkK8R88NkCV2bBAzWVJHvzxNt41mY4uaz
 WG6Bai1SGTW3KcfpxsZI6FjrpopdFGX4VqYOY0TtdsJa3NI53C3BhzfImCzlykkaIcYmuxjt7Ah2lb
 OWekcV4hHp8wRwJyiaaJ/keljvzvatp43ESfsdCc7j6On9RqUteZupFr2zakJY9BSN2Ptjd8pN8yeH
 aTXtxWawedMeoU8PhYkESWsDn+KdqudUqVGnNcbsSw5vjtgIPaOPbZueRLi6V8h84d9qGpeYAbexYL
 zAkmKnFgXOdAULh/IgxFkLlc3ApCAZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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
the imx-card driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 58fd0639a069..e9fe3fc2f261 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -652,7 +652,7 @@ static int imx_card_parse_of(struct imx_card_data *data)
 					       NULL, &link->dai_fmt);
 		if (ret)
 			link->dai_fmt = SND_SOC_DAIFMT_NB_NF |
-					SND_SOC_DAIFMT_CBS_CFS |
+					SND_SOC_DAIFMT_CBC_CFC |
 					SND_SOC_DAIFMT_I2S;
 
 		/* Get tdm slot */
-- 
2.20.1

