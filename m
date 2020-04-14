Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB634C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 15:08:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FDE2078B
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 15:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jIdUmyIF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF2B0nLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FDE2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FF0F16D7;
	Tue, 14 Apr 2020 17:01:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FF0F16D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586876566;
	bh=q1TsmEQ7wbDcJmniqWHqMFjLmrk1YLX7JD6dHw9hv8A=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=jIdUmyIFwIxV6EcubjkEgqB0E51C6SDLrE/7HHa1CRMBNFkWLv+oWj9Qtg0ucfbm4
	 +DAqK2Zqb4sQwTTvAP92NfV0/V4hotuEH3vlqPPn/uwQsWo9qrOjBxa1Ecx/Q+/3Yh
	 M5r12O0jScTyMCM0auVqeQJiDj6h+o6rv1sq6t8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70348F80383;
	Tue, 14 Apr 2020 16:48:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9FA5AF8034D; Tue, 14 Apr 2020 16:48:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB5C0F8033E
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 16:48:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB5C0F8033E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CF2B0nLD"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CB522078B;
 Tue, 14 Apr 2020 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586875693;
 bh=q1TsmEQ7wbDcJmniqWHqMFjLmrk1YLX7JD6dHw9hv8A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=CF2B0nLDXLPbuhCZ4Y4bB/bP7S3jqGvaQAGnFrLYXrkUjAgLHAPwQzPdTUv3vvAXT
 L11aBvxGLNNJ5+ZSKXTVEGQuiB/5l9tEUFMtWODJCKNFhz0L69vhACTnhcOm0NNvpX
 ixUFa9enrWt1Wf9IG4t4BNWD4EDPBxhWOPFFBUQw=
Date: Tue, 14 Apr 2020 15:48:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Libin Yang <libin.yang@linux.intel.com>
Subject: Applied "ASoC: SOF: Intel: add PCI ID for ElkhartLake" to the asoc
 tree
In-Reply-To: <20200409185827.16255-5-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200409185827.16255-5-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
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

   ASoC: SOF: Intel: add PCI ID for ElkhartLake

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

From a4ed29273376cb1f5aa05b90eb3c4d5877564976 Mon Sep 17 00:00:00 2001
From: Libin Yang <libin.yang@linux.intel.com>
Date: Thu, 9 Apr 2020 13:58:18 -0500
Subject: [PATCH] ASoC: SOF: Intel: add PCI ID for ElkhartLake

Add PCI ID for ElkhartLake platform.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20200409185827.16255-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/sof-pci-dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index cec631a1389b..b5f0221d624f 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -435,6 +435,8 @@ static const struct pci_device_id sof_pci_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ELKHARTLAKE)
 	{ PCI_DEVICE(0x8086, 0x4b55),
 		.driver_data = (unsigned long)&ehl_desc},
+	{ PCI_DEVICE(0x8086, 0x4b58),
+		.driver_data = (unsigned long)&ehl_desc},
 #endif
 	{ 0, }
 };
-- 
2.20.1

