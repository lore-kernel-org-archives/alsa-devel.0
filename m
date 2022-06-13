Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF405C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 05:57:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F08A21852;
	Tue, 14 Jun 2022 07:56:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F08A21852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655186224;
	bh=moRm3LZaWjAvMr/JY0Hg4zQYgfZJVr5LKGrFgTW+uyo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iSpG0dmsmVJWvaPjGjixnC8l+bXcoMjeXYv82kMNVWJdNp4X2A3/IHfeO1POtn9j5
	 Tqi+p/WWffvTvdVpqe3WCqFsN+q76+jt8JkGWuAanEndb8KrCDy7fjrqVhSb9K+70y
	 uu8hk7lwY+EeXnajezkHfvjC3CE9FHvX3ScrC1R4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A30EBF80543;
	Tue, 14 Jun 2022 07:54:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EF3AF804C1; Mon, 13 Jun 2022 10:13:24 +0200 (CEST)
Received: from mail.nfschina.com (unknown
 [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
 by alsa1.perex.cz (Postfix) with ESMTP id 9D596F80139
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2022 10:13:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D596F80139
Received: from localhost (unknown [127.0.0.1])
 by mail.nfschina.com (Postfix) with ESMTP id 76F9D1E80D8F;
 Mon, 13 Jun 2022 16:11:59 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
 by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfep-sN8dM9B; Mon, 13 Jun 2022 16:11:56 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
 (Authenticated sender: renyu@nfschina.com)
 by mail.nfschina.com (Postfix) with ESMTPA id 0EA6A1E80D89;
 Mon, 13 Jun 2022 16:11:56 +0800 (CST)
From: Ren Yu <renyu@nfschina.com>
To: lgirdwood@gmail.com
Subject: [PATCH] soc: fix typos in comment
Date: Mon, 13 Jun 2022 16:12:19 +0800
Message-Id: <20220613081219.25058-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Mailman-Approved-At: Tue, 14 Jun 2022 07:54:10 +0200
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 Ren Yu <renyu@nfschina.com>, yuzhe@nfschina.com, linux-kernel@vger.kernel.org,
 tiwai@suse.com, liqiong@nfschina.com, hukun@nfschina.com,
 rf@opensource.cirrus.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 qixu@nfschina.com, steve@sk2.org
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

change 'slection' to 'selection'

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 sound/soc/codecs/lm49453.c | 2 +-
 sound/soc/codecs/rt5631.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index bd0078e4499b..2eb43e93778e 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1201,7 +1201,7 @@ static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	case 12288000:
 	case 26000000:
 	case 19200000:
-		/* pll clk slection */
+		/* pll clk selection */
 		pll_clk = 0;
 		break;
 	case 48000:
diff --git a/sound/soc/codecs/rt5631.h b/sound/soc/codecs/rt5631.h
index 8a6b99a48c7c..0caca2e1d31b 100644
--- a/sound/soc/codecs/rt5631.h
+++ b/sound/soc/codecs/rt5631.h
@@ -373,7 +373,7 @@
  */
 #define RT5631_SDP_DAC_DATA_L_R_SWAP			(0x1 << 4)
 
-/* Data Length Slection */
+/* Data Length Selection */
 #define RT5631_SDP_I2S_DL_MASK				(0x3 << 2)
 #define RT5631_SDP_I2S_DL_16				(0x0 << 2)
 #define RT5631_SDP_I2S_DL_20				(0x1 << 2)
-- 
2.11.0

