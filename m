Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08529C433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:23:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E9F61B3E
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83E9F61B3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1FC811C;
	Tue,  9 Nov 2021 23:23:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1FC811C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636496637;
	bh=7+BMEBjdSqQa1qVGB+Y4ucwGefWzUaTFb879pgxxR2w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F/lyHwop/q1fN/p67+JaDNeyQB9UU2yBG/Lst2IbbIAwZpHYz917ukxAXtW/R0fMH
	 m7bIz3gwkU3mOGjQYfcGSyjK+K+p32HVTQuDdxPY5jXGcTwGnsOJr43hJ9aTny7565
	 XKloZnRLIkod9+wHs9crD0+Id+nP6yp9wFN/Bbrw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E99C8F80516;
	Tue,  9 Nov 2021 23:20:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 636E5F8053A; Tue,  9 Nov 2021 23:20:14 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A28FEF804FA
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:20:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A28FEF804FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="goyfl+ed"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A65C461A58;
 Tue,  9 Nov 2021 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496409;
 bh=7+BMEBjdSqQa1qVGB+Y4ucwGefWzUaTFb879pgxxR2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=goyfl+ednXUkVVTa6LXQFhJOW+UQUl7gHGLKbsknijyNPHfDtibvBm1W6lj60OphP
 IU0iD7g/CcZqeSOgl11gtz7o1CyxzIgMn3xTkxVM4OxP/BgzXBeYVqJfCIeLCcakgW
 ezS3GFkHdRJJJV61Oajk7IDWysMZHNA7eaIMP8j+5HCFNT+rjTzNhZwgJEetNHu4wo
 l+6tWuKe7T+//kPlN1LXO7dXz7cAOiUPjgsLjpqeMO+Lb6JlNM7jtGA5NL8DKZjSgV
 YyISrSeu8IWgTmcURSrEePENoFPapcUxsho2VT3PfHFO3GAZ2TCqUJVw8h4G3Naf8z
 w9EXKbKiLlWPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 38/75] ASoC: rt5651: Use IRQF_NO_AUTOEN when
 requesting the IRQ
Date: Tue,  9 Nov 2021 17:18:28 -0500
Message-Id: <20211109221905.1234094-38-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221905.1234094-1-sashal@kernel.org>
References: <20211109221905.1234094-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, oder_chiou@realtek.com,
 alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 bardliao@realtek.com
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 6e037b72cf4ea6c28a131ea021d63ee4e7e6fa64 ]

Use the new IRQF_NO_AUTOEN flag when requesting the IRQ, rather then
disabling it immediately after requesting it.

This fixes a possible race where the IRQ might trigger between requesting
and disabling it; and this also leads to a small code cleanup.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20211003132255.31743-2-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5651.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index fc0c83b73f099..93820561b9f5d 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2261,11 +2261,8 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	ret = devm_request_irq(&i2c->dev, rt5651->irq, rt5651_irq,
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
-			       | IRQF_ONESHOT, "rt5651", rt5651);
-	if (ret == 0) {
-		/* Gets re-enabled by rt5651_set_jack() */
-		disable_irq(rt5651->irq);
-	} else {
+			       | IRQF_ONESHOT | IRQF_NO_AUTOEN, "rt5651", rt5651);
+	if (ret) {
 		dev_warn(&i2c->dev, "Failed to reguest IRQ %d: %d\n",
 			 rt5651->irq, ret);
 		rt5651->irq = -ENXIO;
-- 
2.33.0

