Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DCEC4CEC9
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:04:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43F8214AF
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GKf2bToZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ekBDrO18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43F8214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24670166E;
	Tue, 17 Sep 2019 18:03:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24670166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568736284;
	bh=Ro+BIWMKsoG+LdpNH5pWKrPJaQZAtWWF1wMFNEu95Kg=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=GKf2bToZvJkVnky+WHgsN4DkxisVT9pimWYPiZ9UT3UDf/nh1QBEdEimemP+OfO3q
	 3sXbu1R6DoOB52Nnhra6vK3k3xW//OD5OEgWopUbjBwB/THqE0G0gdbsJh15mWRjZZ
	 AbWeFGz1OG9ICPAv8N6JCjhRVbINH0oYvsRju2OM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7D58F804CF;
	Tue, 17 Sep 2019 18:02:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E1B0F80361; Tue, 17 Sep 2019 18:02:57 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98C63F80307
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 18:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98C63F80307
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="ekBDrO18"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=35d8UPTguuGp6BHsgYbk/Jm9wnRYhbE6NdqTl5N81eg=; b=ekBDrO18OjHt
 JZ2tNVQEvuGcpc22JMAgSXGMLj87TmzPpkJJNzfJUA8HuJzuapMjjP1phfHFgkc+hhpqoJl7b4SZ/
 +KC3wwE8sy8DjEWQhB/Sl7uuln/vmPH0l1Q3gcrgH65bYh8NLGQtsdE/fwxyGFklJkVt9NYl+0Up7
 jfnCU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iAFwH-0008OA-A8; Tue, 17 Sep 2019 16:02:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 7D77B27428EA; Tue, 17 Sep 2019 17:02:48 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20190916210353.6318-1-yung-chuan.liao@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190917160248.7D77B27428EA@ypsilon.sirena.org.uk>
Date: Tue, 17 Sep 2019 17:02:48 +0100 (BST)
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 tiwai@suse.de, pierre-louis.bossart@linux.intel.com,
 Mark Brown <broonie@kernel.org>, bard.liao@intel.com
Subject: [alsa-devel] Applied "ASoC: core: delete component->card_list in
	soc_remove_component only" to the asoc tree
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

   ASoC: core: delete component->card_list in soc_remove_component only

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From a0a4bf57a977ed37bcbdfc8027a44485fe086a3d Mon Sep 17 00:00:00 2001
From: Bard Liao <yung-chuan.liao@linux.intel.com>
Date: Tue, 17 Sep 2019 05:03:53 +0800
Subject: [PATCH] ASoC: core: delete component->card_list in
 soc_remove_component only

We add component->card_list in the end of soc_probe_component(). In
other words, component->card_list will not be added if there is an
error in the soc_probe_component() function. So we can't delete
component->card_list in the error handling of soc_probe_component().

Fixes: 22d1423187e5 ("ASoC: soc-core: add soc_cleanup_component()")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190916210353.6318-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 35f48e9c5ead..aff4b4bf4d07 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -978,7 +978,6 @@ static void soc_cleanup_component(struct snd_soc_component *component)
 	/* For framework level robustness */
 	snd_soc_component_set_jack(component, NULL, NULL);
 
-	list_del(&component->card_list);
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 	soc_cleanup_component_debugfs(component);
 	component->card = NULL;
@@ -991,7 +990,7 @@ static void soc_remove_component(struct snd_soc_component *component)
 		return;
 
 	snd_soc_component_remove(component);
-
+	list_del(&component->card_list);
 	soc_cleanup_component(component);
 }
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
