Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A13E7C4F5
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Oct 2023 07:48:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E156EDF9;
	Thu,  5 Oct 2023 09:47:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E156EDF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696492113;
	bh=vTJNiOwVF4b2pGfzGVb8ZHxmmjupc/KlN8DrOG4IFn0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Tjmxzl4hnMozjCahmOvleclFOwlQGnu7JbJanGMpmPwx0Fz17/2B4lRWdksw6qqWs
	 75rh0tgxysAh/e+c1OX9LgME5q9SwrZCy551ufREhJKOVEHWSxuOMQysH6vFb/supI
	 uFZ1FkPvwXtU32DV8Lod6pGcFe7M0nNrP7LQsZfY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21397F80568; Thu,  5 Oct 2023 09:46:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AB51F8055B;
	Thu,  5 Oct 2023 09:46:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97F88F80290; Sat, 30 Sep 2023 11:56:22 +0200 (CEST)
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9CADAF8007C
	for <alsa-devel@alsa-project.org>; Sat, 30 Sep 2023 11:56:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CADAF8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256
 header.s=s201512 header.b=TuKoQkK9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1696067754;
	bh=bT0oatsp3pkSMaLKyp4Qrnd8ADAIwJtCgQOgUa+Ug6s=;
	h=From:To:Cc:Subject:Date;
	b=TuKoQkK9X8Tv/fYSIyblHvvdW+UufLSrjkAx3URg/JKCmbrNy0KF0zRsaE9btFXr2
	 /VmA1LLESWreGNqd7b53bP7rHIehOldJtF1hBpxvrK3HH1I+WTOqLcXUE4K/wikUjP
	 z+nS2mehFg77CO5Yu5yQfX98UWNEGOt1NTeWQGqI=
Received: from KernelDevBox.byted.org ([180.184.51.40])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id DF306A2B; Sat, 30 Sep 2023 17:55:51 +0800
X-QQ-mid: xmsmtpt1696067751ty35czsma
Message-ID: <tencent_4F37C9B5315B7960041E8E0ADDA869128F08@qq.com>
X-QQ-XMAILINFO: MBf0q8AysQnBhAPO+DycjfzqE4Ij8dAVEqskp0OipBIJ1hs7gNgQbeHUOFMDom
	 jOhD4yriDBYsMsOjrlj14H3u2/egNFnAa8SxkXJumF5w9XcdwgZbCwGmp1knEbPPSuCdd3vI3rxH
	 89PT7Y4FgpwBCBVrTGpY47mcsPpOYU3N3tdCGrlPP3XpfPj10kyEG2GFZj7E0WXKI0DOi04N+J5R
	 BErCXvlfI/e+dj0/+BhdP8oJLS65iw2+9ic2EwexRHeKhdNXnljqyL/gQ2MBB5dVLe4kgjIYZEUI
	 OVLOGzEWyQE/kJBDr5Ai2Xc7BTcTAWv2VN9MLgDRoIc9ZU9eL1BgpcW1o67/jD3OPYsAAdWfmoLG
	 1SBr4e9b4cDQAHkwwat7U4ra+Bw7s2mFk3j9FYV8pobC4wvgsPRqHNUEWZm4Fy/goBHvJsN4I07T
	 OjgQruxTHdaxYjbrudqRKBB6Z/yhFB13Hfigc49YnNWhRsn6cbrf/px/7ZuK5ECWbjkT31tdgwxh
	 ruwe0/C7zH2KhiYxBHtpgFBFEMxVUoF9Q+dZpq7z9AKuHIJtpflK4LJNNqRcgopVXkUvNCdvvhC4
	 OhAcrVjTwT/27ZDZYN+DqY/1wZXCDRRH0DQNd0r4stLaBA7bUfmqlAv3NxBSzaciKJyLo++iMP4S
	 FCsvhT+V1FmhvwaeWfu/Vl7i2EvkUYmUDqq7/zR4QqByZHDMTdXf8B8HtR6ESBgQCE9Uypf1E/vo
	 uQGzwjkGiwY8mq83BuovzaPJKAc+7VfzgaU6Kvl6vfmTmu9AN1oclynyAQbv7lAUit/71Z0yFpkn
	 z/KDzb0Z4yyrCX1tzIASdjJqIOb+YdIvLvlRh8imNubfgnURz3egLq6+4EDTOp14ttjee4iVjigv
	 6BQ2RoW2aF08NLhpKKakMNeffpQ5MWmTPKwr2sFeZUCdFORoG9N4mKPvOfe5haJU36OapYsHiQ12
	 jW0muUv6qqW4t18uxamGutGbUL0mYv0fEhK6rM2LPzrqd48xxrpFSiPJkjJasx
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Zhang Shurong <zhang_shurong@foxmail.com>
To: oder_chiou@realtek.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] ASoC: rt5682: Fix regulator enable/disable sequence
Date: Sat, 30 Sep 2023 17:55:50 +0800
X-OQ-MSGID: <20230930095550.99344-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: zhang_shurong@foxmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: MR7MDX4J5RLQZ3I7C26VKASHNMAGGPAB
X-Message-ID-Hash: MR7MDX4J5RLQZ3I7C26VKASHNMAGGPAB
X-Mailman-Approved-At: Thu, 05 Oct 2023 07:46:44 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MR7MDX4J5RLQZ3I7C26VKASHNMAGGPAB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This will attempt to disable the regulators if the initial enable fails
which is a bug.

Fix this bug by modifying the code to the correct sequence.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 sound/soc/codecs/rt5682-i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index b05b4f73d8aa..fbad1ed06626 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -157,11 +157,6 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
-				       rt5682);
-	if (ret)
-		return ret;
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(rt5682->supplies),
 				    rt5682->supplies);
 	if (ret) {
@@ -169,6 +164,11 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
+				       rt5682);
+	if (ret)
+		return ret;
+
 	ret = rt5682_get_ldo1(rt5682, &i2c->dev);
 	if (ret)
 		return ret;
-- 
2.30.2

