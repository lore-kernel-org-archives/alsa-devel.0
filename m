Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B78C67871
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Oct 2022 09:59:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4944528C0;
	Thu, 27 Oct 2022 11:58:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4944528C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666864784;
	bh=vZz8Mm9LrmKpHASlDl9jKMxtlW1cx8vBWlzSkJcP2PY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bSshQKwnPE/XQ4b49XIpXLU7njE4mn3lIeYbQrH1J+HkNnNm3z95Ww20tEWeJWRyV
	 RAtTLu6PEBG1xqNpJUn6OVjy/zOS9haAXReXf6iIRuP1ewR20Y8hQ20IBUT3M9AJFN
	 8mcBT6v3QiE4dirRYZ1oHycZCeTtPSGX2R2oxH4E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBE3FF8025E;
	Thu, 27 Oct 2022 11:58:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0F8EF804AD; Thu, 27 Oct 2022 11:58:51 +0200 (CEST)
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81697F8016C
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 11:58:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81697F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="PDjj5tIH"
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1666864724; bh=v+OR8wmZOIyovuDfyWeiLKf+QGSEMk6EcfThh0NrItQ=;
 h=From:To:Cc:Subject:Date;
 b=PDjj5tIHERq38p5UkEbRwLtCxradDm2f7h9sxBb6AvbPSwVitnC3JaaFdhg+3wiwO
 VEe+GFIhFHI1ltppU24s4MkjJhNb1lW56ZBGVInqqHXRjwfPcYZd9IdS7ZDW8loYqB
 1V3cWumqiXT2Bs9EO7gbLbZ2JfzeOd+vMmbinbcs=
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: tas2770: Fix set_tdm_slot in case of single slot
Date: Thu, 27 Oct 2022 11:57:58 +0200
Message-Id: <20221027095800.16094-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Stephen Kitt <steve@sk2.org>,
 linux-kernel@vger.kernel.org, shenghao-ding@ti.com, kevin-lu@ti.com,
 Jos Dehaes <jos.dehaes@gmail.com>, Frank Shi <shifu0704@thundersoft.com>,
 Raphael-Xu <13691752556@139.com>,
 =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
 asahi@lists.linux.dev
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

There's a special branch in the set_tdm_slot op for the case of nslots
being 1, but:

 (1) That branch can never work (there's a check for tx_mask being
     non-zero, later there's another check for it *being* zero; one or
     the other always throws -EINVAL).

 (2) The intention of the branch seems to be what the general other
     branch reduces to in case of nslots being 1.

For those reasons remove the 'nslots being 1' special case.

Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
Suggested-by: Jos Dehaes <jos.dehaes@gmail.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2770.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index b6765235a4b3..8557759acb1f 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -395,21 +395,13 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (tx_mask == 0 || rx_mask != 0)
 		return -EINVAL;
 
-	if (slots == 1) {
-		if (tx_mask != 1)
-			return -EINVAL;
-
-		left_slot = 0;
-		right_slot = 0;
+	left_slot = __ffs(tx_mask);
+	tx_mask &= ~(1 << left_slot);
+	if (tx_mask == 0) {
+		right_slot = left_slot;
 	} else {
-		left_slot = __ffs(tx_mask);
-		tx_mask &= ~(1 << left_slot);
-		if (tx_mask == 0) {
-			right_slot = left_slot;
-		} else {
-			right_slot = __ffs(tx_mask);
-			tx_mask &= ~(1 << right_slot);
-		}
+		right_slot = __ffs(tx_mask);
+		tx_mask &= ~(1 << right_slot);
 	}
 
 	if (tx_mask != 0 || left_slot >= slots || right_slot >= slots)
-- 
2.33.0

