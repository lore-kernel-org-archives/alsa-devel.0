Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB833C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 02:17:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DED5218BC;
	Tue, 14 Jun 2022 04:17:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DED5218BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655173073;
	bh=6xwjsAZAN6khBLt8KdzfH0uzWkQQWNNqeRfPYu9dOQk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M9uciVjccd4UVWojfohD8A75zp66avBIDxn7E1d5OsjoXjWigSz8TqF0XZG2/Dl+k
	 RUST16BtksK4JPo/lB1EUu44tCGYt5PVv7DDEteQ+TZg0zxwQF7tCkdw6QhTeAgRsh
	 24KzTN4uL0wfw5Q9x2ay7DiTopYsSsdi8qD4vC8I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3368F8061D;
	Tue, 14 Jun 2022 04:08:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B7DCF8056F; Tue, 14 Jun 2022 04:08:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 902A1F8056F
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 04:08:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 902A1F8056F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="j7XiLP+S"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7B74060EFB;
 Tue, 14 Jun 2022 02:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCB0C3411B;
 Tue, 14 Jun 2022 02:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655172515;
 bh=6xwjsAZAN6khBLt8KdzfH0uzWkQQWNNqeRfPYu9dOQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j7XiLP+SrhbTTfkDH29yDFbVrH+QXcDjweo4MQMbpOaJR7/3Vv/Hvi47nYCZ3n56o
 bAfVLQX6VmDwFMc6q/nCnsY9DAHR5lawUYs6Xsy8swWY39IPgaAvZR+8eY+VSElAsO
 04/Gf9NlFE+YQgJzGIN+0Y3CY1RloYub+R4PiyOGlXe/CMD1DGvdyK/aL3DZE2Tzjl
 0JEXrR1hXSx38VqcoEpMBFm1muRGNs0+Kdzrwq2q63Mm8FWIz4esh1EGu4610s1zQW
 I9DyYQNTiQuE+BNB23x6IUGtHYcIn1cunR45oeS2InRRh+qTpITiWXo2jtOZIKDa4N
 Yyrhr89Enoe9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/29] ASoC: wm8962: Fix suspend while playing
 music
Date: Mon, 13 Jun 2022 22:07:58 -0400
Message-Id: <20220614020815.1099999-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614020815.1099999-1-sashal@kernel.org>
References: <20220614020815.1099999-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 patches@opensource.wolfsonmicro.com,
 Charles Keepax <ckeepax@opensource.cirrus.com>, tiwai@suse.com,
 lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
 Adam Ford <aford173@gmail.com>
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

From: Adam Ford <aford173@gmail.com>

[ Upstream commit d1f5272c0f7d2e53c6f2480f46725442776f5f78 ]

If the audio CODEC is playing sound when the system is suspended,
it can be left in a state which throws the following error:

wm8962 3-001a: ASoC: error at soc_component_read_no_lock on wm8962.3-001a: -16

Once this error has occurred, the audio will not work again until rebooted.

Fix this by configuring SET_SYSTEM_SLEEP_PM_OPS.

Signed-off-by: Adam Ford <aford173@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20220526182129.538472-1-aford173@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 0bd3bbc2aacf..38651022e3d5 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3864,6 +3864,7 @@ static int wm8962_runtime_suspend(struct device *dev)
 #endif
 
 static const struct dev_pm_ops wm8962_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(wm8962_runtime_suspend, wm8962_runtime_resume, NULL)
 };
 
-- 
2.35.1

