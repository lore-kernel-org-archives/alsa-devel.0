Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF40C05027
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 13:57:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3C8BE8D;
	Thu, 26 Jan 2023 14:56:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3C8BE8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674741425;
	bh=+zcnVOvMv0ffroVlt9v3selx4PLrSDPJU27GIQqf5CI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Est3yfeecSFojJ5QwemB5ONm0rLRB8S64l8SNvjLHxFMeJ+CBD7AVSAlfLbCTPJF6
	 F9SwSpA3IW/cyTebsJaNHq7wdeFq71qyOF7jIIeoC1JH/EcyQCYi/xEEJrdDsJlgDv
	 RRsjbh9rzNmM6aIWo5FfdxaVhWzGKg0eHbWK7nWY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C696F8025D;
	Thu, 26 Jan 2023 14:56:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 158E8F8027D; Thu, 26 Jan 2023 14:56:11 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81ABAF800AE
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2023 14:56:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81ABAF800AE
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=J+zABWma
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BB33CB81DBE;
 Thu, 26 Jan 2023 13:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526B0C433EF;
 Thu, 26 Jan 2023 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674741359;
 bh=+zcnVOvMv0ffroVlt9v3selx4PLrSDPJU27GIQqf5CI=;
 h=From:To:Cc:Subject:Date:From;
 b=J+zABWmav20VRHzPY06ARHMEbCGnJ0Uw/wiRy/BiN4s57VOAn9bMYGW97ll3NRNth
 BbowmeIp/RsueWsVjFiO/oWS0EfEUTZrp1dw4vA9DAWvJNb4zVB2FPFcKo4VNnuB75
 vtounBE55vnd87GjrqyqQ4aGNfFZqVPGZYEK33RjPntUPOg2npp4aZbpmerJweEcjP
 i5LgP7E8yldMVmt3+LVvgEjxBUB4d0YG1D+6w0VogOl9MpWtpDK/tWYs4WGL5Vi7UN
 s+YBYjxTxFGigs4H2uaJgcyIYVHQEMKn4+thdjtTfInYHnxdpMaHUsEVSilbHEobEi
 esTwUg22PgY7g==
From: Arnd Bergmann <arnd@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l56: fix DT probe
Date: Thu, 26 Jan 2023 14:55:29 +0100
Message-Id: <20230126135552.3625887-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>, patches@opensource.cirrus.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Wolfram Sang <wsa@kernel.org>, linux-gpio@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Arnd Bergmann <arnd@arndb.de>

While looking through legacy platform data users, I noticed that
this one could never be used with DT based probing as the
platform_data structure gets overwritten directly after it
is initialized.

There have never been any boards defining the platform_data in
the mainline kernel either, so this driver so far only worked
with patched kernels.

For the benefit of possible downstream users, fix the DT probe
by no longer overwriting the data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cs42l56.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 26066682c983..3b0e715549c9 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1191,18 +1191,12 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client)
 	if (pdata) {
 		cs42l56->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
-				     GFP_KERNEL);
-		if (!pdata)
-			return -ENOMEM;
-
 		if (i2c_client->dev.of_node) {
 			ret = cs42l56_handle_of_data(i2c_client,
 						     &cs42l56->pdata);
 			if (ret != 0)
 				return ret;
 		}
-		cs42l56->pdata = *pdata;
 	}
 
 	if (cs42l56->pdata.gpio_nreset) {
-- 
2.39.0

