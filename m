Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB39DC001B0
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jul 2023 01:37:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E62A3E93;
	Mon, 24 Jul 2023 03:36:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E62A3E93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690162650;
	bh=jq8SHtkpLjhWwKStwEjQuJaMiOn/KEjf21wr7/La3vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RAIeSU1A026Qe1SS5VgHcAby3eM5yqu8Jb39SGV5mM1obTf7hOzFkXiv9PWRg9vEY
	 dWwSMYuPOcr2JTAYcO+nUBpy4bDl1eTb/J03xeXav6PRvD+XD5WXcBWwhYySXHi12i
	 xkcOGF3FKFRc9I78HcHadfHO11ASSbkpTYnYcVSo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63691F805A0; Mon, 24 Jul 2023 03:34:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B0905F805A0;
	Mon, 24 Jul 2023 03:34:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FFE1F80564; Mon, 24 Jul 2023 03:34:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7A412F800D2
	for <alsa-devel@alsa-project.org>; Mon, 24 Jul 2023 03:34:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A412F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rsu1TBHc
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4E061004;
	Mon, 24 Jul 2023 01:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AF7C433CA;
	Mon, 24 Jul 2023 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690162438;
	bh=jq8SHtkpLjhWwKStwEjQuJaMiOn/KEjf21wr7/La3vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsu1TBHcoDOOO5LLCMHREm3i+gchp2SX4saYMl4l6WVrhWWDnrF12+HnTyAmp0S/A
	 CtK3dVaGfFlwAGV4HL0c+heVUdPsl2YnwRQJJv5uWqgxamLC9u5rTF/qW3q73WxztT
	 Xf6ZXyne9i7VYxLfgvlcBuY9cDgiaWoW71dGLT4S/y990gr4Kh93yhZ0t3wjrjW7DY
	 +YhVqpP4mW4yf3CASVA8yxKeoWUvA5cCogh+prnSAlChBESuzhYQzsWb98uuba0Zr1
	 weLTo4RKX3sZqh5BS16uC+kwnpE3WaUi4u+AlXPXPoIBZ/8LnOfaJgJ9ONxnZMTZ3R
	 adz4nuwdNu6Nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tuo Li <islituo@gmail.com>,
	BassCheck <bass@buaa.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 23/24] ALSA: hda: fix a possible null-pointer
 dereference due to data race in snd_hdac_regmap_sync()
Date: Sun, 23 Jul 2023 21:33:24 -0400
Message-Id: <20230724013325.2332084-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013325.2332084-1-sashal@kernel.org>
References: <20230724013325.2332084-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AEIDXOA3FFKDHETCQCLIN6ZS2YJZZEMS
X-Message-ID-Hash: AEIDXOA3FFKDHETCQCLIN6ZS2YJZZEMS
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AEIDXOA3FFKDHETCQCLIN6ZS2YJZZEMS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Tuo Li <islituo@gmail.com>

[ Upstream commit 1f4a08fed450db87fbb5ff5105354158bdbe1a22 ]

The variable codec->regmap is often protected by the lock
codec->regmap_lock when is accessed. However, it is accessed without
holding the lock when is accessed in snd_hdac_regmap_sync():

  if (codec->regmap)

In my opinion, this may be a harmful race, because if codec->regmap is
set to NULL right after the condition is checked, a null-pointer
dereference can occur in the called function regcache_sync():

  map->lock(map->lock_arg); --> Line 360 in drivers/base/regmap/regcache.c

To fix this possible null-pointer dereference caused by data race, the
mutex_lock coverage is extended to protect the if statement as well as the
function call to regcache_sync().

[ Note: the lack of the regmap_lock itself is harmless for the current
  codec driver implementations, as snd_hdac_regmap_sync() is only for
  PM runtime resume that is prohibited during the codec probe.
  But the change makes the whole code more consistent, so it's merged
  as is -- tiwai ]

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/r/20230703031016.1184711-1-islituo@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_regmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index fe3587547cfec..39610a15bcc98 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -597,10 +597,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_regmap_update_raw_once);
  */
 void snd_hdac_regmap_sync(struct hdac_device *codec)
 {
-	if (codec->regmap) {
-		mutex_lock(&codec->regmap_lock);
+	mutex_lock(&codec->regmap_lock);
+	if (codec->regmap)
 		regcache_sync(codec->regmap);
-		mutex_unlock(&codec->regmap_lock);
-	}
+	mutex_unlock(&codec->regmap_lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_sync);
-- 
2.39.2

