Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206BBC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 19 May 2022 17:11:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 634961742;
	Thu, 19 May 2022 19:10:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 634961742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652980283;
	bh=egoYKR4vr8CKpHoKDJBKtrQDW1fdVWPv/xn5gzjvNkY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i74RUEaRXMnsrx9cJCTrdv0S1nEeXmz8xrsB5S8z/ilIenbNknV1shuj/3ySenX9K
	 ETnpwBX5qW54of7jEb9ITewbqsYnkIY5GvD7RHVbhNCCRmo0awuAHmD5diyDj7uiwC
	 cB2wpweQVXKxeBoTVrP/oaPAY2cP3OXwkgNhEBwk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A3EFF80237;
	Thu, 19 May 2022 19:10:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46FDBF8025D; Thu, 19 May 2022 19:10:31 +0200 (CEST)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 437A8F800F0
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2022 19:10:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 437A8F800F0
Received: from hednb3.intra.ispras.ru (unknown [10.10.2.52])
 by mail.ispras.ru (Postfix) with ESMTPSA id 1E21240755F2;
 Thu, 19 May 2022 17:10:21 +0000 (UTC)
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: max98090: Remove unneeded check in
 max98090_put_enab_tlv()
Date: Thu, 19 May 2022 20:10:12 +0300
Message-Id: <1652980212-21473-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Cc: ldv-project@linuxtesting.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
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

Variable sel is of unsigned int type, so sel < 0 is not required.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 2fbe467bcbfc ("ASoC: max98090: Reject invalid values in custom control put()")
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 62b41ca050a2..c535a8496bf1 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -413,7 +413,7 @@ static int max98090_put_enab_tlv(struct snd_kcontrol *kcontrol,
 
 	val = (val >> mc->shift) & mask;
 
-	if (sel < 0 || sel > mc->max)
+	if (sel > mc->max)
 		return -EINVAL;
 
 	*select = sel;
-- 
2.7.4

