Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B194BC2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:15:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDBF2087F
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="veshg0cI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDBF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4F6E85D;
	Mon, 27 Jan 2020 19:14:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4F6E85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580148936;
	bh=XM0mveDau5o3htoRkbTTE4gaRAkQOnRVoMZyyg3Bqqk=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=veshg0cIUFaMM5c1DI7E2gqZICMXMt+/jpEtCp7qkFK/xwKLy5EEVpTsBzWN1PztS
	 fUT9BmKUn8jp0dQPBG2lzKx6PcTJEHkn09MtklWlHMeZMVieVbgoEskVqYKoag4HTR
	 Y5OlMJbZ9DDO+v5Qo/vlJhIrDbwrlNIO/2jYq8Pw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5FB0F8028A;
	Mon, 27 Jan 2020 19:11:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A12BF80268; Mon, 27 Jan 2020 19:11:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 7A7F8F80256
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 19:11:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A7F8F80256
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEF2C101E;
 Mon, 27 Jan 2020 10:11:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1329E3F67D;
 Mon, 27 Jan 2020 10:11:30 -0800 (PST)
Date: Mon, 27 Jan 2020 18:11:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200124213625.30186-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200124213625.30186-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 stable@vger.kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: core: free trace on errors" to the
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

   ASoC: SOF: core: free trace on errors

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

From 37e97e6faeabda405d0c4319f8419dcc3da14b2b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 24 Jan 2020 15:36:20 -0600
Subject: [PATCH] ASoC: SOF: core: free trace on errors

free_trace() is not called on probe errors, fix

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200124213625.30186-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/sof/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 44f9c04d54aa..f517ab448a1d 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -224,12 +224,12 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	if (ret < 0) {
 		dev_err(sdev->dev,
 			"error: failed to register DSP DAI driver %d\n", ret);
-		goto fw_run_err;
+		goto fw_trace_err;
 	}
 
 	ret = snd_sof_machine_register(sdev, plat_data);
 	if (ret < 0)
-		goto fw_run_err;
+		goto fw_trace_err;
 
 	/*
 	 * Some platforms in SOF, ex: BYT, may not have their platform PM
@@ -245,6 +245,8 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	return 0;
 
 #if !IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
+fw_trace_err:
+	snd_sof_free_trace(sdev);
 fw_run_err:
 	snd_sof_fw_unload(sdev);
 fw_load_err:
@@ -262,6 +264,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	 * snd_sof_device_remove() when the PCI/ACPI device is removed
 	 */
 
+fw_trace_err:
 fw_run_err:
 fw_load_err:
 ipc_err:
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
