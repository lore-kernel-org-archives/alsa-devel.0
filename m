Return-Path: <SRS0=hSRK=XO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEDAC4CEC9
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 01:30:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF5620644
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 01:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T2NxK5Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF5620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D5C9166C;
	Thu, 19 Sep 2019 03:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D5C9166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568856618;
	bh=WAFDi6k6qQ/HjRe5CDZdL9YobFHDQ3cGpg+Pok49TxE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T2NxK5IrbcpFzDeWq5eb4Ta5GpUSwo8opmC8iu7Gv487Grh+oOmxqdVtxKgAUkJyj
	 mZRoRC/9tDADyPXyLyU8w8PF2FBWU6gJO7uchlFLSCkBoMsRNiDf8dHT/PUoh6ohjb
	 PYIYZ5Tt3BKbLly0/iEovi6e8R2FvN5zVeFKv/S8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A051F80146;
	Thu, 19 Sep 2019 03:29:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74AFBF80361; Thu, 19 Sep 2019 03:29:24 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF8EDF80146
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2019 03:29:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF8EDF80146
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Sep 2019 18:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; d="scan'208";a="191894176"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga006.jf.intel.com with ESMTP; 18 Sep 2019 18:29:15 -0700
From: Bard liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Date: Wed, 18 Sep 2019 21:31:31 +0800
Message-Id: <20190918133131.15045-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, bard.liao@intel.com,
 pierre-louis.bossart@linux.intel.com, kuninori.morimoto.gx@renesas.com
Subject: [alsa-devel] [PATCH] ASoC: core: use list_del_init and move it back
	to soc_cleanup_component
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

commit a0a4bf57a977 ("ASoC: core: delete component->card_list in soc_remove_component only")
was trying to fix a kernel oops when list_del was called twice without
re-init the list. Use list_del_init() can solve it, too. Besides, it
will be more readable if we cleanup all component related resource at
soc_cleanup_component().

Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/soc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aff4b4bf4d07..88978a3036c4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -978,6 +978,7 @@ static void soc_cleanup_component(struct snd_soc_component *component)
 	/* For framework level robustness */
 	snd_soc_component_set_jack(component, NULL, NULL);
 
+	list_del_init(&component->card_list);
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 	soc_cleanup_component_debugfs(component);
 	component->card = NULL;
@@ -990,7 +991,7 @@ static void soc_remove_component(struct snd_soc_component *component)
 		return;
 
 	snd_soc_component_remove(component);
-	list_del(&component->card_list);
+
 	soc_cleanup_component(component);
 }
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
