Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE5DC34056
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:09:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140EC207FD
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aqROP+xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140EC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 456DC16BC;
	Wed, 19 Feb 2020 22:08:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 456DC16BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582146589;
	bh=h6rXdn+U/z42QQoMYgoE+hZivYM9UFbti8cCLJg+U2o=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=aqROP+xFaBFzuhv+HIWtvDUGOuML9EKRrAGpVeYJu4kzFraNwfu9/LOuZ7aLSh7Wi
	 +ZB1iMLf5QUnNV2IQz6YYIFmrxzY7LuqsPqeyBAD9+5AOUPT/BUVDD5ByHL0VmmjZs
	 4zjRWhZaR6d3SlCTzQXLGChLuhq4XnlJswL8Nau8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B6F2F8035E;
	Wed, 19 Feb 2020 21:58:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B7FFF8035E; Wed, 19 Feb 2020 21:58:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2A5B2F80351
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 21:58:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A5B2F80351
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E13E101E;
 Wed, 19 Feb 2020 12:58:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01F953F68F;
 Wed, 19 Feb 2020 12:58:16 -0800 (PST)
Date: Wed, 19 Feb 2020 20:58:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Applied "ASoC: intel: skl: Fix pin debug prints" to the asoc tree
In-Reply-To: <20200218111737.14193-2-tiwai@suse.de>
Message-Id: <applied-20200218111737.14193-2-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>
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

   ASoC: intel: skl: Fix pin debug prints

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

From 64bbacc5f08c01954890981c63de744df1f29a30 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 18 Feb 2020 12:17:35 +0100
Subject: [PATCH] ASoC: intel: skl: Fix pin debug prints

skl_print_pins() loops over all given pins but it overwrites the text
at the very same position while increasing the returned length.
Fix this to show the all pin contents properly.

Fixes: d14700a01f91 ("ASoC: Intel: Skylake: Debugfs facility to dump module config")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20200218111737.14193-2-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 3466675f2678..4c1703da1a6d 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -34,7 +34,7 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
 	int i;
 	ssize_t ret = 0;
 
-	for (i = 0; i < max_pin; i++)
+	for (i = 0; i < max_pin; i++) {
 		ret += snprintf(buf + size, MOD_BUF - size,
 				"%s %d\n\tModule %d\n\tInstance %d\n\t"
 				"In-used %s\n\tType %s\n"
@@ -45,6 +45,8 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
 				m_pin[i].in_use ? "Used" : "Unused",
 				m_pin[i].is_dynamic ? "Dynamic" : "Static",
 				m_pin[i].pin_state, i);
+		size += ret;
+	}
 	return ret;
 }
 
-- 
2.20.1

