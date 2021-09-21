Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C08C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:13:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD83561183
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD83561183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F7C01614;
	Tue, 21 Sep 2021 23:12:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F7C01614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632258823;
	bh=ZnM+iqWxm+4OI1WI+vtTm3ZebK6hxw24eEpvjq/BbMU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HQmmeVoEbfxyBKgjq+yt4CV0k2Y/RILyy+TOOhziaqmj3uFAEC/iBEJtlPUWaVoLK
	 YJF2Glxf5NyjOzO2ZniH3L3D2zLQ5vGYma2xUfooYhjQG4VUgOq6NXcfd3igL3UcqC
	 B/34wk31l+BoA6Yab83AMVDnUUDbSFvuk5rt2M/Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B266F804E4;
	Tue, 21 Sep 2021 23:11:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9325F804EB; Tue, 21 Sep 2021 23:11:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E72C1F804E4
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:11:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E72C1F804E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Xdzs3wJK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF52561183;
 Tue, 21 Sep 2021 21:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632258696;
 bh=ZnM+iqWxm+4OI1WI+vtTm3ZebK6hxw24eEpvjq/BbMU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xdzs3wJK2yhFJNUr/JDzqUtwQL3MaIG9aOXiRpZyUNbVQzV4dSJmwDsZsXnKbRj7E
 lt7Lg44nn7rqsoo/tjt1JybVXKzjted5pKDRKE/t667tuQRXVXDETrUIz7B0QfaAvt
 tj4UEdeS9OWl8ba01OAeD7wpqR9/CYTh2UI+NU/rRYFn11XbCoGeGIcPDI6H0Y95pw
 H27GXf1vsJEKEd5qgsPwv3pyCDl1bwCkwvTgnGFyKXlF6BAwxM+dG0/98JTdTAe6a2
 oi9s2OJhR0ZIZ+WXz5PdBUadnq/tz3T/CW3eKu94yOCEBiWkWnpWKXF4JCBLz2j/Vo
 oo5rv4vy9yC9w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH 05/16] ASoC: fsl-mqs: Update to modern clocking terminology
Date: Tue, 21 Sep 2021 22:10:29 +0100
Message-Id: <20210921211040.11624-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921211040.11624-1-broonie@kernel.org>
References: <20210921211040.11624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; h=from:subject;
 bh=ZnM+iqWxm+4OI1WI+vtTm3ZebK6hxw24eEpvjq/BbMU=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBhSkneidR+IfgASeBZcEe7nEyf9oCvyXFXV112DJOT
 KNY5LeSJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpJ3gAKCRAk1otyXVSH0JbRB/
 de8ESQ0uq4MfK/AvcBrek9jQ0ZRAl5lVNxyCOpr30ftA8NFul9vFGoEw/WG5dkXziY3uuef1oUSV/u
 +nEWBHZ/CdRvruf3GualDmOB/S1hWYO3c9YeyMpL2kQE/M0MUKfP9rwtDWt9ntkTIyWN0blHzHpAK4
 doS4yb9bd1jMMBf2ZYNmx5v4Cy6x5125EtAz/PuVqvFPKSBzzJ30wjYcmyEDhImKv+if8w56fXXTTV
 bNzWe7d9DAsxg5+yEuLqqM0+NvbsvZAJJAH1v90F/WRuIvzUzS9f0psYXpwFWm8a8l2FLmLfueBzbL
 1PEQ224mPgq3VIJh2eFu02jiCJdUQ=
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
the fsl-mqs driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_mqs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 69aeb0e71844..27b4536dce44 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -102,8 +102,8 @@ static int fsl_mqs_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
 		break;
 	default:
 		return -EINVAL;
-- 
2.20.1

