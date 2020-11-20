Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67A2C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:24:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A3F2225B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IBGkdgP7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu2G6q/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A3F2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EDDB839;
	Fri, 20 Nov 2020 17:24:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EDDB839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889495;
	bh=sO3ez0EZ5UNNfG4j2+8DCfucIft1SFisc/XRA8bljPg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBGkdgP7frEEFBH9tsa05eOgPrf/Tvok2xng8JUGWTHve79odsxh8j60OteB4dAg6
	 KgDHpJY65N/BIIJDPBNzHF06xJXCliZH9AUXubFVNCjnq18Gjybpdo63IG/bN2OtwR
	 IelteIOtmfjHWC4OTSr+Eoe5DCRtMCRob7XaQFR8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72C13F802A9;
	Fri, 20 Nov 2020 17:18:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F415F80539; Fri, 20 Nov 2020 17:18:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87C3EF80525
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:18:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87C3EF80525
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Iu2G6q/l"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 48E56238E6;
 Fri, 20 Nov 2020 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889121;
 bh=sO3ez0EZ5UNNfG4j2+8DCfucIft1SFisc/XRA8bljPg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Iu2G6q/lFfrOFsxMq4VY+LtkGiDw6vywWtAHTWo8BJpJ35bD23Z6Wk4nM8YbTsefq
 SjGUZM6xEW/6Y4PA14wQ1VBy+ZEiRo6de7xR5ddPh8PUm0yVk9r6BHMD3Du3u7vi2W
 uh3oKk+SOCq24uPaKwce9aEdv8Qzj/E/ydvtZM90=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 16/38] ASoC: da7218: skip of_device_id table when !CONFIG_OF
Date: Fri, 20 Nov 2020 17:16:30 +0100
Message-Id: <20201120161653.445521-16-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
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

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/da7218.c:2281:34: warning: ‘da7218_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/da7218.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 6d78bccb55c3..2bfafbe9e3dc 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2278,12 +2278,14 @@ static irqreturn_t da7218_irq_thread(int irq, void *data)
  * DT
  */
 
+#ifdef CONFIG_OF
 static const struct of_device_id da7218_of_match[] = {
 	{ .compatible = "dlg,da7217", .data = (void *) DA7217_DEV_ID },
 	{ .compatible = "dlg,da7218", .data = (void *) DA7218_DEV_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da7218_of_match);
+#endif
 
 static inline int da7218_of_get_id(struct device *dev)
 {
-- 
2.25.1

