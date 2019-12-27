Return-Path: <SRS0=/8xD=2R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBCDC2D0C6
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 17:52:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432292173E
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 17:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k5aOCQh9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhF2Zfco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432292173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F4AC1743;
	Fri, 27 Dec 2019 18:51:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F4AC1743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577469142;
	bh=T8HAmsWbRh2kZmGoVjkyZOR3aLxdy42UYM5R8vxGEzU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k5aOCQh9gh84Uwrig8N0JmuLxqBrL6DvYhzcohqFWCTrZCFHmyb2YNL3QxBxeL8gd
	 2CBfXx4MNDBcNmH5oNZxPqUyFqBtIWAY3Z9kuKm+Fa90idzwSkbVx9XnUnk3YfN03K
	 v6ApcIMH6xDjzKFNYeO9fjdmIHwJW8G8ZcbI/d8U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44DE8F8028D;
	Fri, 27 Dec 2019 18:45:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F21DAF8028F; Fri, 27 Dec 2019 18:45:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CCF8F8028A
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2019 18:45:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CCF8F8028A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WhF2Zfco"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8EE8620740;
 Fri, 27 Dec 2019 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577468703;
 bh=S7renQ6JMhoqB5VfJ2q31j4ceVXaE9rW61AyX8FoOGE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WhF2ZfcoIvT+PvXxQvCCUMp6LqkHapPftxP3mey0VtaZbx3dGgVOBbcnCzStbf8kn
 UHTJFOmGihVQLwbShVY00eha98pkEZY1qEENxZMm7FIyYEBlThAUa8O/eWgxZ/eJ4q
 YCrxmH84d/p7lV3K1MnJQxsDMTQvfHyhCJfR81Ss=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 27 Dec 2019 12:43:27 -0500
Message-Id: <20191227174352.6264-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] [PATCH AUTOSEL 4.19 59/84] ASoC: wm8962: fix lambda
	value
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 556672d75ff486e0b6786056da624131679e0576 ]

According to user manual, it is required that FLL_LAMBDA > 0
in all cases (Integer and Franctional modes).

Fixes: 9a76f1ff6e29 ("ASoC: Add initial WM8962 CODEC driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index efd8910b1ff7..dde015fd70a4 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2792,7 +2792,7 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 
 	if (target % Fref == 0) {
 		fll_div->theta = 0;
-		fll_div->lambda = 0;
+		fll_div->lambda = 1;
 	} else {
 		gcd_fll = gcd(target, fratio * Fref);
 
@@ -2862,7 +2862,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 		return -EINVAL;
 	}
 
-	if (fll_div.theta || fll_div.lambda)
+	if (fll_div.theta)
 		fll1 |= WM8962_FLL_FRAC;
 
 	/* Stop the FLL while we reconfigure */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
