Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E4C2BB85
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:16:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344BC2076D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FYzz7Did";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="POM0ui/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344BC2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84BA0852;
	Wed, 15 Apr 2020 19:15:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84BA0852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586970987;
	bh=iseWDu7buGKgWlnAuZkXe6N57EemoX364HbCH2CJH6o=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=FYzz7Did5IvKC8AeSHwH1Fm9FeHeWCRL/EA2eJVpTHKIB1bQ972958jtoatu2eg5R
	 UBa58qWwMVUz5eUniEbxkIZuSChsMvUYxysNWuPV/tE3obsD7YqHweVlZGD/wd3Bwn
	 F5g1vdd8a5Yais6pjN97fbNLM3HiT8S5BjiSUtz4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 153E1F80229;
	Wed, 15 Apr 2020 19:15:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 030ABF80245; Wed, 15 Apr 2020 19:15:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E44B4F800ED
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 19:15:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E44B4F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="POM0ui/R"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C7FF2076D;
 Wed, 15 Apr 2020 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586970926;
 bh=iseWDu7buGKgWlnAuZkXe6N57EemoX364HbCH2CJH6o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=POM0ui/RjwG4uRcFdDMuLMZmiw9OW1fSlG7fOIAXTy+mmSZgy70H9Oc3OEPkpR/i+
 XjYzKG98xjzTXuqg543uuoicSxgcxOq49pjPBOPDpPL7tIr6r5ambZMAdeBelzg98h
 U7tz87gsDeKhVnJ7XZvx5RzWLR8HBJhlIDlO8yXQ=
Date: Wed, 15 Apr 2020 18:15:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Subject: Applied "ASoC: topology: Remove unneeded semicolon" to the asoc tree
In-Reply-To: <20200415162435.31859-1-amadeuszx.slawinski@linux.intel.com>
Message-Id: <applied-20200415162435.31859-1-amadeuszx.slawinski@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>
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

The patch

   ASoC: topology: Remove unneeded semicolon

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 980f91778a2f4dcca43d16b7a83feda8df5c96e7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Date: Wed, 15 Apr 2020 12:24:34 -0400
Subject: [PATCH] ASoC: topology: Remove unneeded semicolon
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is unnecessary semicolon after last bracket of if statement,
remove it.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20200415162435.31859-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 33e8d189ba2f..a5cd73742dc5 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2390,7 +2390,7 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 		tplg->pos += le32_to_cpu(hdr->size) +
 			le32_to_cpu(hdr->payload_size);
 		return 0;
-	};
+	}
 
 	/* check the element size and count */
 	link = (struct snd_soc_tplg_link_config *)tplg->pos;
-- 
2.20.1

