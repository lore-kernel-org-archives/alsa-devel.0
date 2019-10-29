Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B08CA9EAE
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:37:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B25320856
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sDVmfBAo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kdFNZYrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B25320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76B32226A;
	Tue, 29 Oct 2019 18:36:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76B32226A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572370620;
	bh=ofTvaa7MInnFwUcEwIfqVxrg28YemWZuH7uilc0Ay2g=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=sDVmfBAoO3xQ4NAEljdGFXrBzhq+aKyP6IR7F1hwRK10l9pQOq+iqtA4qJj550JBn
	 k3F6FZMtkN+VWOX5oS1j29v87Q9v2mjIH6z9sJLg8FbkClKZ7Wg7DZLLCCUcuVgjVj
	 QmMzKj3b3V3Jkcof0MH7bWp2yQui/yn2gmOoXxzE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C62DF8015A;
	Tue, 29 Oct 2019 18:34:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66DF5F805FC; Tue, 29 Oct 2019 18:34:28 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1BFBF80269
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 18:34:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1BFBF80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="kdFNZYrT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=e5hZYRYyByav+yMiDS5IWVhqfdZqCS2gx6OD58w8JiA=; b=kdFNZYrTT0Hp
 ovhXZD2a97WgL4InFooVPZTkQ6AoltdLja9tBNMDo9KTiY7NxeLmfQNLQM83VMx5AxMNTLo4ULTgj
 bNdnAquW41d6YDS/QlyncUvlqZijJCH5NfQJFp2rHyeX1BkV+INOutysgWd2k4qkyLJr3t95948ye
 92VOA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iPVNs-0002kR-B5; Tue, 29 Oct 2019 17:34:20 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id BB3982742990; Tue, 29 Oct 2019 17:34:19 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <20191029134017.18901-8-kai.vehmanen@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191029173419.BB3982742990@ypsilon.sirena.org.uk>
Date: Tue, 29 Oct 2019 17:34:19 +0000 (GMT)
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, tiwai@suse.de,
 pierre-louis.bossart@linux.intel.com, julia.lawall@lip6.fr,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: Intel: glk_rt5682_max98357a: common
	hdmi codec support" to the asoc tree
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

   ASoC: Intel: glk_rt5682_max98357a: common hdmi codec support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From dfe87aa86cd92d21603d64f4035fecae19c92e7a Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Tue, 29 Oct 2019 15:40:15 +0200
Subject: [PATCH] ASoC: Intel: glk_rt5682_max98357a: common hdmi codec support

Add support for using snd-hda-codec-hdmi driver for HDMI/DP
instead of ASoC hdac-hdmi. This is aligned with how other
HDA codecs are already handled.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191029134017.18901-8-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Makefile               |  2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 0cf4a984f083..b36f44906c91 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -6,7 +6,7 @@ snd-soc-sst-bdw-rt5677-mach-objs := bdw-rt5677.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bxt-da7219_max98357a-objs := bxt_da7219_max98357a.o hda_dsp_common.o
 snd-soc-sst-bxt-rt298-objs := bxt_rt298.o
-snd-soc-sst-glk-rt5682_max98357a-objs := glk_rt5682_max98357a.o
+snd-soc-sst-glk-rt5682_max98357a-objs := glk_rt5682_max98357a.o hda_dsp_common.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
 snd-soc-sst-bytcr-rt5651-objs := bytcr_rt5651.o
 snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index bd2d371f2acd..b36264d1d1cd 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -19,6 +19,7 @@
 #include <sound/soc-acpi.h>
 #include "../../codecs/rt5682.h"
 #include "../../codecs/hdac_hdmi.h"
+#include "hda_dsp_common.h"
 
 /* The platform clock outputs 19.2Mhz clock to codec as I2S MCLK */
 #define GLK_PLAT_CLK_FREQ 19200000
@@ -41,6 +42,7 @@ struct glk_hdmi_pcm {
 struct glk_card_private {
 	struct snd_soc_jack geminilake_headset;
 	struct list_head hdmi_pcm_list;
+	bool common_hdmi_codec_drv;
 };
 
 enum {
@@ -545,6 +547,13 @@ static int glk_card_late_probe(struct snd_soc_card *card)
 	int err = 0;
 	int i = 0;
 
+	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct glk_hdmi_pcm,
+			       head);
+	component = pcm->codec_dai->component;
+
+	if (ctx->common_hdmi_codec_drv)
+		return hda_dsp_hdmi_build_controls(card, component);
+
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
 		snprintf(jack_name, sizeof(jack_name),
@@ -612,6 +621,8 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ctx->common_hdmi_codec_drv = mach->mach_params.common_hdmi_codec_drv;
+
 	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
