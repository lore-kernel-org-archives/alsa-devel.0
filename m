Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D75C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:33:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51C72073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pRNgy9WI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51C72073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 063081615;
	Tue, 10 Dec 2019 14:33:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 063081615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575984835;
	bh=6LIiLJjGQ3YAegw233Ho8Z5U/31l1TitZos7wJbLYE4=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=pRNgy9WI0Xa8f2bqqXqbNmITB6vSoQe2fS3En2V1zeeEsMPc+w0X+Ld26SC6JybcL
	 iS2il1MZK/aagfxamtKDV1Imx10diDe3NEQcmmxMz/mZQl9TqMMRNTj1Ka/Xx3z6Si
	 X/fPvT3XjcKKSbEkgO/Mu7sLAAH++b3pDXtFFdMI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A96FF80322;
	Tue, 10 Dec 2019 14:23:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F1E6F80306; Tue, 10 Dec 2019 14:23:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 22F04F802F7
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:23:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22F04F802F7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C411045;
 Tue, 10 Dec 2019 05:23:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 184543F52E;
 Tue, 10 Dec 2019 05:23:08 -0800 (PST)
Date: Tue, 10 Dec 2019 13:23:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fthtyq6z.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87fthtyq6z.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: remove dai_link_list" to the
	asoc tree
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

   ASoC: soc-core: remove dai_link_list

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

From cc73390008c9a47c49ad73c459b5590fd4c4c890 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Dec 2019 09:33:40 +0900
Subject: [PATCH] ASoC: soc-core: remove dai_link_list

ASoC is using many lists.
Now, used dai_link is listed to card as dai_link_list.

	[card]->[dai_link]->[dai_link]->...

BTW, this "dai_link" is used to create "rtd".
And this rtd is listed to card as rtd_list.

	[card]->[rtd]->[rtd]->...

Here, each rtd has dai_link. This means, we can track all dai_link via
rtd list. This patch removes card dai_link_list, and uses rtd_list
instead of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87fthtyq6z.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  7 -------
 sound/soc/soc-core.c | 17 +++++++----------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c28a1ed5e8df..b7ba3b91d080 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -852,7 +852,6 @@ struct snd_soc_dai_link {
 	/* Do not create a PCM for this DAI link (Backend link) */
 	unsigned int ignore:1;
 
-	struct list_head list; /* DAI link list of the soc card */
 #ifdef CONFIG_SND_SOC_TOPOLOGY
 	struct snd_soc_dobj dobj; /* For topology */
 #endif
@@ -1037,7 +1036,6 @@ struct snd_soc_card {
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;  /* predefined links only */
 	int num_links;  /* predefined links only */
-	struct list_head dai_link_list; /* all links */
 
 	struct list_head rtd_list;
 	int num_rtd;
@@ -1107,11 +1105,6 @@ struct snd_soc_card {
 	     ((i) < (card)->num_aux_devs) && ((aux) = &(card)->aux_dev[i]); \
 	     (i)++)
 
-#define for_each_card_links(card, link)				\
-	list_for_each_entry(link, &(card)->dai_link_list, list)
-#define for_each_card_links_safe(card, link, _link)			\
-	list_for_each_entry_safe(link, _link, &(card)->dai_link_list, list)
-
 #define for_each_card_rtds(card, rtd)			\
 	list_for_each_entry(rtd, &(card)->rtd_list, list)
 #define for_each_card_rtds_safe(card, rtd, _rtd)	\
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1a362a799dbb..9483bfe17260 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -934,11 +934,14 @@ struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
 					       int id, const char *name,
 					       const char *stream_name)
 {
+	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link *link;
 
 	lockdep_assert_held(&client_mutex);
 
-	for_each_card_links(card, link) {
+	for_each_card_rtds(card, rtd) {
+		link = rtd->dai_link;
+
 		if (link->id != id)
 			continue;
 
@@ -1075,8 +1078,6 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 	if (card->remove_dai_link)
 		card->remove_dai_link(card, dai_link);
 
-	list_del(&dai_link->list);
-
 	rtd = snd_soc_get_pcm_runtime(card, dai_link->name);
 	if (rtd)
 		soc_free_pcm_runtime(rtd);
@@ -1158,9 +1159,6 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 		}
 	}
 
-	/* see for_each_card_links */
-	list_add_tail(&dai_link->list, &card->dai_link_list);
-
 	return 0;
 
 _err_defer:
@@ -1931,7 +1929,7 @@ static void __soc_setup_card_name(char *name, int len,
 static void soc_cleanup_card_resources(struct snd_soc_card *card,
 				       int card_probed)
 {
-	struct snd_soc_dai_link *link, *_link;
+	struct snd_soc_pcm_runtime *rtd, *n;
 
 	if (card->snd_card)
 		snd_card_disconnect_sync(card->snd_card);
@@ -1942,8 +1940,8 @@ static void soc_cleanup_card_resources(struct snd_soc_card *card,
 	soc_remove_link_dais(card);
 	soc_remove_link_components(card);
 
-	for_each_card_links_safe(card, link, _link)
-		snd_soc_remove_dai_link(card, link);
+	for_each_card_rtds_safe(card, rtd, n)
+		snd_soc_remove_dai_link(card, rtd->dai_link);
 
 	/* remove auxiliary devices */
 	soc_remove_aux_devices(card);
@@ -2393,7 +2391,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->aux_comp_list);
 	INIT_LIST_HEAD(&card->component_dev_list);
 	INIT_LIST_HEAD(&card->list);
-	INIT_LIST_HEAD(&card->dai_link_list);
 	INIT_LIST_HEAD(&card->rtd_list);
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	INIT_LIST_HEAD(&card->dobj_list);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
