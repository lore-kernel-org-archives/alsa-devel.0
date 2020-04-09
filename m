Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13ECC2BA2B
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 12:04:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B85220753
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 12:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Uv/SL6OA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXVNfeVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B85220753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 921DE1658;
	Thu,  9 Apr 2020 14:03:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 921DE1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586433856;
	bh=GvSwav3XdtAfWd655t2xKIVTYn/DVD1FkY62Qh/pzS8=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Uv/SL6OAI99jH+l31fMq6TORppMfy6g5ZWk9UC23sCGZmA2kzwq3T+CLdoxaeXHib
	 QjodcnVFOZzpCZ/A1hRleWJSg92Wrl3TFW5SQUNSXIH3lLKx57LxpAzaMwG4KIak/h
	 ejAsebK4bbYy/++f/jOrGsAJJSF4KEFjx5AG7DnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CCEDF80213;
	Thu,  9 Apr 2020 14:02:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14735F80216; Thu,  9 Apr 2020 14:02:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B9C9F80213
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 14:02:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B9C9F80213
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YXVNfeVu"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3B7B20753;
 Thu,  9 Apr 2020 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586433752;
 bh=GvSwav3XdtAfWd655t2xKIVTYn/DVD1FkY62Qh/pzS8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=YXVNfeVuphmxDEipWEc+dblexKfVoConS37aSMv4E3XKPF0WKi/OfACpnhSHdppQu
 5HW3AbMhWm3U0T+KcnX8wZjMDGdCmZR6CR9MhgN97Ham9GnKz2N1HMJd0IkRZi4veO
 QhyrCSF6GDfwSs7hCejGuujLTL+HS4GGRFiIO4IY=
Date: Thu, 09 Apr 2020 13:02:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Subject: Applied "ASoC: topology: Check return value of pcm_new_ver" to the
 asoc tree
In-Reply-To: <20200327204729.397-6-amadeuszx.slawinski@linux.intel.com>
Message-Id: <applied-20200327204729.397-6-amadeuszx.slawinski@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
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

   ASoC: topology: Check return value of pcm_new_ver

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

From b3677fc3d68dd942c92de52f0bd9dd8b472a40e6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Date: Fri, 27 Mar 2020 16:47:28 -0400
Subject: [PATCH] ASoC: topology: Check return value of pcm_new_ver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Function pcm_new_ver can fail, so we should check it's return value and
handle possible error.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200327204729.397-6-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index cb43994089de..818657b06799 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2135,7 +2135,9 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 			_pcm = pcm;
 		} else {
 			abi_match = false;
-			pcm_new_ver(tplg, pcm, &_pcm);
+			ret = pcm_new_ver(tplg, pcm, &_pcm);
+			if (ret < 0)
+				return ret;
 		}
 
 		/* create the FE DAIs and DAI links */
-- 
2.20.1

