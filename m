Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6C0C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 08:11:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D28610A0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 08:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9D28610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E00C16B0;
	Tue, 26 Oct 2021 10:10:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E00C16B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635235909;
	bh=qo9P98H8KaNAlDfQ81NvflqHQDSii0h+YDrvtIOUgfk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e0n5qDlw0tZYNdBiefxPI8ryw/sEXh4J9qfjMRW0zJy88C1/NrS3lz5OznsvOXgHM
	 AVkVJU/FFNged/tHNukY5ilqn9/G5uvspExUYtHl7FD5iaPCVQQ/hosB7SpSoQq5lx
	 iJxeMvwWiYlVQU9MKYykvZ+JyJLaG2iUf8rb3PB8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 091DAF80269;
	Tue, 26 Oct 2021 10:10:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BA42F802C8; Tue, 26 Oct 2021 10:10:48 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F0F7F80105
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 10:10:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F0F7F80105
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 66FD11F4367C
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: oder_chiou@realtek.com
Subject: [PATCH] ASoC: rt5682-i2c: Use devm_clk_get_optional for optional clock
Date: Tue, 26 Oct 2021 10:10:30 +0200
Message-Id: <20211026081030.422481-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

The mclk clock is optional, but it's currently using devm_clk_get:
simplify the handling by using devm_clk_get_optional instead.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/codecs/rt5682-i2c.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index a30e42932cf7..983347b65127 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -280,14 +280,9 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 #ifdef CONFIG_COMMON_CLK
 	/* Check if MCLK provided */
-	rt5682->mclk = devm_clk_get(&i2c->dev, "mclk");
-	if (IS_ERR(rt5682->mclk)) {
-		if (PTR_ERR(rt5682->mclk) != -ENOENT) {
-			ret = PTR_ERR(rt5682->mclk);
-			return ret;
-		}
-		rt5682->mclk = NULL;
-	}
+	rt5682->mclk = devm_clk_get_optional(&i2c->dev, "mclk");
+	if (IS_ERR(rt5682->mclk))
+		return PTR_ERR(rt5682->mclk);
 
 	/* Register CCF DAI clock control */
 	ret = rt5682_register_dai_clks(rt5682);
-- 
2.33.0

