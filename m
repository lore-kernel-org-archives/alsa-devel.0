Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B667DCA9EB6
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:48:07 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408C421920
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408C421920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 201E41615;
	Wed, 23 Oct 2019 15:47:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 201E41615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571838485;
	bh=rWQQRRqoUxMfdVSA8S0lDaL0gQ99AsPbolnDAxFYe3I=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=giAxPUh7kMeLSyN1CyBfIka/Ybsckv2WHRrBdMZfG1Nsq3Cvcfx0jn0cyZ2Ll1UcI
	 Mm+crTMehzjNHeWTs24zFGa7rOXapbbHa0D8zSg0bcY9m+9L6SaU9LSgDk9Cjhvo4i
	 +4ceFP9twi95QLTqSFzIBlhhxZAiO4J/a5YdwXU8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77ECBF80321;
	Wed, 23 Oct 2019 15:47:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 378B1F80368; Wed, 23 Oct 2019 15:47:13 +0200 (CEST)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 943D2F802DF
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 15:47:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 943D2F802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="0SJiwMzr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rS7IaiuA9EianwvLu0X8wKvcXDrj0zY1Ij9NUwNkC1k=; b=0SJiwMzrhzvDxniR03PjuepUke
 /t6E5wdXu5SMsgrUuuBg5f3U/LvlIX7eFFzwLZEtaBkmSvrKitEYJ8hJXH2NmjnSPrdFBroyNU6Fh
 HztCD950qGoOCFiR/ZHvMMVmoZt4Cp+0rS9Y3v6G0MPiw1MJHNs2AfeNAt/0fN8axkB/XwKNeN52t
 teGwelXkHM5AvALcYKn21mYPC4f8hIiF10TTcdBUSHkzXDsawLZwzwrzJrZZKZw4+pVTk24jyQp6Q
 F/pJ7FJfWW5+9NbpsFphRQm1biypWKWbNHW7n/YGqVGc5/vlZSg5qLC3uk/41gWEruTmOsKcIScES
 VixOTZHw==;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:57408 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1iNGyK-0005Dc-OI; Wed, 23 Oct 2019 14:46:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1iNGyK-0004oF-6A; Wed, 23 Oct 2019 14:46:44 +0100
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1iNGyK-0004oF-6A@rmk-PC.armlinux.org.uk>
Date: Wed, 23 Oct 2019 14:46:44 +0100
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.armlinux.org.uk
Subject: [alsa-devel] [PATCH] ASoC: kirkwood: fix external clock probe defer
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

When our call to get the external clock fails, we forget to clean up
the enabled internal clock correctly.  Enable the clock after we have
obtained all our resources.

Fixes: 84aac6c79bfd ("ASoC: kirkwood: fix loss of external clock at probe time")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 3446a113f482..c323ae314b55 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -559,10 +559,6 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
-	err = clk_prepare_enable(priv->clk);
-	if (err < 0)
-		return err;
-
 	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
 	if (IS_ERR(priv->extclk)) {
 		if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
@@ -578,6 +574,10 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = clk_prepare_enable(priv->clk);
+	if (err < 0)
+		return err;
+
 	/* Some sensible defaults - this reflects the powerup values */
 	priv->ctl_play = KIRKWOOD_PLAYCTL_SIZE_24;
 	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
