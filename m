Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031C0C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:30:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CB92073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EcLG3PTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CB92073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD6701654;
	Tue, 10 Dec 2019 14:29:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD6701654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575984631;
	bh=0+BIMmiaidE1ypOFfM/zeEnW4Q5TjN+82/ylBrcUXhk=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=EcLG3PTTVtTZ0NJj6T+sayzMWiI09RntlIapSHLu1ITM+TFuhlgx2Hz9h4dQ5vMuo
	 alDc78AC4ztpVjib6BP1ooRaqYsok9pMYJJmf3k6C6qynxkJPs+skONYpOe8XlAnoa
	 2HM6WWxpr2Muzz7bMXub34HpE7zKf5DC33GnhjBY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C870F802DF;
	Tue, 10 Dec 2019 14:23:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DB11F802D2; Tue, 10 Dec 2019 14:23:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 586DEF8028F
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:22:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 586DEF8028F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 582D8113E;
 Tue, 10 Dec 2019 05:22:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBEE93F52E;
 Tue, 10 Dec 2019 05:22:56 -0800 (PST)
Date: Tue, 10 Dec 2019 13:22:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878snlyq61.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-878snlyq61.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: move snd_soc_find_dai_link()"
	to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: soc-core: move snd_soc_find_dai_link()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d6f31e0e6d09594717ed21c7c9238d9fbdb30ccb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Dec 2019 09:34:14 +0900
Subject: [PATCH] ASoC: soc-core: move snd_soc_find_dai_link()

snd_soc_find_dai_link() is soc-topology specific function.
We don't need to have it at soc-core.
This patch moves it to soc-topology.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/878snlyq61.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h      |  3 ---
 sound/soc/soc-core.c     | 44 ----------------------------------------
 sound/soc/soc-topology.c | 41 +++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 40c2a677f531..09d3d9b615c2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1327,9 +1327,6 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link);
 void snd_soc_remove_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *dai_link);
-struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
-					       int id, const char *name,
-					       const char *stream_name);
 
 struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 					 struct snd_soc_dai_driver *dai_drv,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9ee7d5d118c0..bf5bbb1f3cdb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -901,50 +901,6 @@ struct snd_soc_dai *snd_soc_find_dai(
 }
 EXPORT_SYMBOL_GPL(snd_soc_find_dai);
 
-/**
- * snd_soc_find_dai_link - Find a DAI link
- *
- * @card: soc card
- * @id: DAI link ID to match
- * @name: DAI link name to match, optional
- * @stream_name: DAI link stream name to match, optional
- *
- * This function will search all existing DAI links of the soc card to
- * find the link of the same ID. Since DAI links may not have their
- * unique ID, so name and stream name should also match if being
- * specified.
- *
- * Return: pointer of DAI link, or NULL if not found.
- */
-struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
-					       int id, const char *name,
-					       const char *stream_name)
-{
-	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_dai_link *link;
-
-	lockdep_assert_held(&client_mutex);
-
-	for_each_card_rtds(card, rtd) {
-		link = rtd->dai_link;
-
-		if (link->id != id)
-			continue;
-
-		if (name && (!link->name || strcmp(name, link->name)))
-			continue;
-
-		if (stream_name && (!link->stream_name
-			|| strcmp(stream_name, link->stream_name)))
-			continue;
-
-		return link;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(snd_soc_find_dai_link);
-
 static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 				     struct snd_soc_dai_link *link)
 {
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 81d2af000a5c..cbd605b96722 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2207,6 +2207,47 @@ static int link_new_ver(struct soc_tplg *tplg,
 	return 0;
 }
 
+/**
+ * snd_soc_find_dai_link - Find a DAI link
+ *
+ * @card: soc card
+ * @id: DAI link ID to match
+ * @name: DAI link name to match, optional
+ * @stream_name: DAI link stream name to match, optional
+ *
+ * This function will search all existing DAI links of the soc card to
+ * find the link of the same ID. Since DAI links may not have their
+ * unique ID, so name and stream name should also match if being
+ * specified.
+ *
+ * Return: pointer of DAI link, or NULL if not found.
+ */
+static struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
+						      int id, const char *name,
+						      const char *stream_name)
+{
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai_link *link;
+
+	for_each_card_rtds(card, rtd) {
+		link = rtd->dai_link;
+
+		if (link->id != id)
+			continue;
+
+		if (name && (!link->name || strcmp(name, link->name)))
+			continue;
+
+		if (stream_name && (!link->stream_name
+				    || strcmp(stream_name, link->stream_name)))
+			continue;
+
+		return link;
+	}
+
+	return NULL;
+}
+
 /* Find and configure an existing physical DAI link */
 static int soc_tplg_link_config(struct soc_tplg *tplg,
 	struct snd_soc_tplg_link_config *cfg)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
