Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD83C3A5A8
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:54:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4976E208E4
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CXQQQGOr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KLHLmNii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4976E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86DD01677;
	Wed,  4 Sep 2019 19:53:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86DD01677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567619663;
	bh=cKzmFkJhw0Tz/QML43k2N4q3sH08niAJNwg50zt5akQ=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=CXQQQGOrop8bl5d/Ey0RSRC4FX5xLSDWWYat1IHfXeyBH+JenT5LnKrdL4ZiwT754
	 6v+8FqWF36oAlrkcZw8rorYlRIF0wtDV6s3K1hxpbx+Rn5WTv9jPg9S8Fo/kw8QPvQ
	 9eSdmg1BCmCAJR+N16Gwuty9T8pg534LaysMrHWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCA54F803A6;
	Wed,  4 Sep 2019 19:53:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40FFCF803D0; Wed,  4 Sep 2019 19:53:31 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4148F80171
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 19:53:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4148F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="KLHLmNii"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=0vUN/mP2jRkFY1yC0RcTePYe1dw/6b3Wm/AMlgoaVhg=; b=KLHLmNii4LIg
 wQ7R7KM/CUmnUL13W0brNnQnUcX93lSLNCG5Ar7UDxrbkwAPTeE8Y9lgdPCWf/XmMwicc0Saicbc8
 JcDVI36DVpgoj7LQdnRGsvRCXq1F2mo7mXbD0tval9iF/QPNZ21en2CwP5TaPnfjvpYLKxL+u+311
 FQr1Q=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1i5ZTC-0006h5-7r; Wed, 04 Sep 2019 17:53:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 413C62742B45; Wed,  4 Sep 2019 18:53:25 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875zm8q5n8.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20190904175325.413C62742B45@ypsilon.sirena.org.uk>
Date: Wed,  4 Sep 2019 18:53:25 +0100 (BST)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-core: add comment to jack at
	soc_remove_component()" to the asoc tree
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

   ASoC: soc-core: add comment to jack at soc_remove_component()

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

From 04f770d968344ca95b55cf7b50452888ec5440e7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 4 Sep 2019 09:14:35 +0900
Subject: [PATCH] ASoC: soc-core: add comment to jack at soc_remove_component()

Basically, driver which setups snd_soc_component_set_jack() need
to release it by themselves. But, as framework level robustness,
soc_remove_component() also releases it.

To avoid code reader confuse, this patch makes it clarify.

This patch makes it clarify.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/875zm8q5n8.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2a166abaade1..05a2aff843aa 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -975,7 +975,9 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 
 static void soc_cleanup_component(struct snd_soc_component *component)
 {
+	/* For framework level robustness */
 	snd_soc_component_set_jack(component, NULL, NULL);
+
 	list_del(&component->card_list);
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 	soc_cleanup_component_debugfs(component);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
