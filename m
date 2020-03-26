Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C933FC43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:13:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD6B20719
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C8DlYKr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD6B20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B03E4166C;
	Thu, 26 Mar 2020 22:12:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B03E4166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585257194;
	bh=zgTm4nCoNYd5R8LgTDGk2kA/QJ+EaCHnQcLiNw9OMus=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C8DlYKr0T7HGbcZbE7WOGHcf5ItVqJu3pfSJ+hmhywU145LKgiwtBBB/tAvXGbIk3
	 ZLuv55Mhjvgyed3dwWNSFBnV7nt2mIiAFhm8gvVO6pAeiyvJ+PCUZilX1ym/u690WZ
	 Qf2oyOonarnjld5iDEHiIN0iEGfdOOhnx16fani8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD1DCF8028E;
	Thu, 26 Mar 2020 22:10:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DBF6F8027B; Thu, 26 Mar 2020 22:10:19 +0100 (CET)
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by alsa1.perex.cz (Postfix) with ESMTP id 17B3EF80227
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 22:10:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17B3EF80227
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
 by pokefinder.org (Postfix) with ESMTPSA id C69492C1F96;
 Thu, 26 Mar 2020 22:10:13 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 1/1] ALSA: ppc: keywest: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:12 +0100
Message-Id: <20200326211013.13531-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326211013.13531-1-wsa+renesas@sang-engineering.com>
References: <20200326211013.13531-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org
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

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/ppc/keywest.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 093806d735c6..9554a0c506af 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -40,6 +40,7 @@ static int keywest_probe(struct i2c_client *client,
 static int keywest_attach_adapter(struct i2c_adapter *adapter)
 {
 	struct i2c_board_info info;
+	struct i2c_client *client;
 
 	if (! keywest_ctx)
 		return -EINVAL;
@@ -50,9 +51,11 @@ static int keywest_attach_adapter(struct i2c_adapter *adapter)
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	strlcpy(info.type, "keywest", I2C_NAME_SIZE);
 	info.addr = keywest_ctx->addr;
-	keywest_ctx->client = i2c_new_device(adapter, &info);
-	if (!keywest_ctx->client)
-		return -ENODEV;
+	client = i2c_new_client_device(adapter, &info);
+	if (IS_ERR(client))
+		return PTR_ERR(client);
+	keywest_ctx->client = client;
+
 	/*
 	 * We know the driver is already loaded, so the device should be
 	 * already bound. If not it means binding failed, and then there
-- 
2.20.1

