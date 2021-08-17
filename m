Return-Path: <SRS0=htQG=NI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C54C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:37:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE64D60240
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE64D60240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C7BE886;
	Tue, 17 Aug 2021 02:36:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C7BE886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629160656;
	bh=Aqqg/+LAdGFrSRrekR1o1Bc4hvcDvgmePZggkIIT3UQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NOjdeU6Er9/ky+cYvDlY/4ClwuHDQifdvwivyGiqLpoc8YioESnpeeiWq6o7nfIat
	 ju91fxzS/vRPHuyHG08xz3tQj3GLOcO4sGwS7/GkfGNfWzz9HjBP+r0CpJG4l1Fw/q
	 HBxrJ4obQHblwBA+pMb64DM/GlXgnLGOaK1N2tMA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EC10F804E1;
	Tue, 17 Aug 2021 02:36:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D55CDF804DA; Tue, 17 Aug 2021 02:35:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46D3EF80246
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 02:35:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46D3EF80246
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="b9Y2J/A4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73C9B60FC3;
 Tue, 17 Aug 2021 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629160541;
 bh=Aqqg/+LAdGFrSRrekR1o1Bc4hvcDvgmePZggkIIT3UQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b9Y2J/A4lHWN/fY7RA9YiZrosX7Hc/solfTM4YpPtzv556s5LzwWHd++nlH0FoQ8C
 6W656iv7ivppiK+4vEX9JKvrWn38K1nX/1uvXpdXnAkkhHyr+7xhz/oiK6EesDJlYl
 i1MS+XN7ozcuIjdk2fB/HSCMxTeiiCLXgvdq0ekRveseCllqDxI+9ktTG9gm6FRe42
 REkjrVEimnUnHw0mpnwbCuhQRnQWyfXlC8UgCTSAIsRgcKzVMMNOSd0pwDYoF/v155
 EJ6IQRcWUMDpsA3m/57I89zyO9Rd2v3wk2jOup9G5L6fcW2g7JCjFYoD+dR5EwPT/x
 aa9B6YRJU/rlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 03/12] ASoC: wm_adsp: Let
 soc_cleanup_component_debugfs remove debugfs
Date: Mon, 16 Aug 2021 20:35:27 -0400
Message-Id: <20210817003536.83063-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817003536.83063-1-sashal@kernel.org>
References: <20210817003536.83063-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Lucas Tanure <tanureal@opensource.cirrus.com>
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

From: Lucas Tanure <tanureal@opensource.cirrus.com>

[ Upstream commit acbf58e530416e167c3b323111f4013d9f2b0a7d ]

soc_cleanup_component_debugfs will debugfs_remove_recursive
the component->debugfs_root, so adsp doesn't need to also
remove the same entry.
By doing that adsp also creates a race with core component,
which causes a NULL pointer dereference

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20210728104416.636591-1-tanureal@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index cef05d81c39b..6698b5343974 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -746,7 +746,6 @@ static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
 static void wm_adsp2_cleanup_debugfs(struct wm_adsp *dsp)
 {
 	wm_adsp_debugfs_clear(dsp);
-	debugfs_remove_recursive(dsp->debugfs_root);
 }
 #else
 static inline void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
-- 
2.30.2

