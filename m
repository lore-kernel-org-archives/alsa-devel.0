Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E83C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 23:34:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7822076A
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 23:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hlZNWK4H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yjvsIFkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7822076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A72291665;
	Thu, 16 Apr 2020 01:33:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A72291665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586993654;
	bh=/+6BznV8Jf9Tl/AqA3M9t+PR0nD926zjVaL5oQ8S0AY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=hlZNWK4HAhDsMS0A6uYPEvQuQJVDkhd7Gkj8Ap3j0M0EDIJaVH2k7k0euo7oWYR9+
	 kjT2w8DNsjZuFJViWCgORUBXZN0UuUHefZew8G/eEOtzTFf09rplTyQURUlaSjKBwL
	 u+Y+W3kLjQqgoIHf6T47K3rFrcnRSXgZlkSfa2kY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFB62F8025F;
	Thu, 16 Apr 2020 01:32:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9275F80266; Thu, 16 Apr 2020 01:32:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DBB0F8025F
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 01:32:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DBB0F8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="yjvsIFkj"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E911820787;
 Wed, 15 Apr 2020 23:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586993548;
 bh=/+6BznV8Jf9Tl/AqA3M9t+PR0nD926zjVaL5oQ8S0AY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=yjvsIFkjVt5a5MUmLNdlAIn4+QDGO+AGPxW3HqAvMmcm6VJSWnevn+o5bEUDge6ux
 Q4p//Amg5njkF7uWlS/3hhuDWWEkn0njqPQw/sB7AwW9podS+6/U1RGlch0tXnbloU
 3qumfwOjv/uUEkhF9TA5THlst16NvfWgmc9hX//g=
Date: Thu, 16 Apr 2020 00:32:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Applied "ASoC: pcm: fix error handling when try_module_get() fails."
 to the asoc tree
In-Reply-To: <20190408193025.22639-1-ranjani.sridharan@linux.intel.com>
Message-Id: <applied-20190408193025.22639-1-ranjani.sridharan@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 pierre-louis.bossart@linux.intel.com
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

   ASoC: pcm: fix error handling when try_module_get() fails.

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

From 7df8e234449a9a1cd2af5de728b7f811346c6fec Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Mon, 8 Apr 2019 12:30:25 -0700
Subject: [PATCH] ASoC: pcm: fix error handling when try_module_get() fails.

Handle error before returning when try_module_get() fails
to prevent inconsistent mutex lock/unlock.

Fixes: 52034add7 (ASoC: pcm: update module refcount if
		  module_get_upon_open is set)
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a810f6eeffee..69ea962de585 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -518,8 +518,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			continue;
 
 		if (component->driver->module_get_upon_open &&
-		    !try_module_get(component->dev->driver->owner))
-			return -ENODEV;
+		    !try_module_get(component->dev->driver->owner)) {
+			ret = -ENODEV;
+			goto module_err;
+		}
 
 		ret = component->driver->ops->open(substream);
 		if (ret < 0) {
@@ -636,7 +638,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 
 component_err:
 	soc_pcm_components_close(substream, component);
-
+module_err:
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 out:
-- 
2.20.1

