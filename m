Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F1FCA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:00:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0899620873
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JG+Ii+fT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="C7qPIN6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0899620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A9641F94;
	Mon, 28 Oct 2019 15:59:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A9641F94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572274799;
	bh=stagE50fWFreb/dtAz1lnhBSZbysk0unqPx8qDRBZew=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=JG+Ii+fTdlBpI1tQwZoaBxlqr8na5XMbRPT8Yebjh3lWEOUD8gyhZaypqL5vzY6yz
	 9DyoUrEQiml3cqE5wZG/mDRW9JAytwDi87636h1wnjb1SDX5h5fXFYYR5g7i7zhNRk
	 fgtZcceVBNAuUdFTwqUDfDslXp+XKuN9uKAl8LOk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7DD1F80673;
	Mon, 28 Oct 2019 15:56:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F9F6F8063D; Mon, 28 Oct 2019 15:56:40 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30445F8044A
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 15:56:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30445F8044A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="C7qPIN6F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=Notkq1wSbP60fALgjCO4HKAPF5GXG8rKCXgNEaxZAhE=; b=C7qPIN6FnZMt
 tCJsOGwexFn5Iv3wEseaVkwYsDPVjWx0ccIophw6wYr/MEpQH1wl4vccD7bC7FZrFxZH/Ru8oS1vM
 d5XDHRg4oiM7DZPV9aURWZAkR4NMJHFiEeA+GDZrb8LiYbGraZrDS90FQugFqH5/rIDWI8RqYm5D7
 jBVFU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iP6Ra-0008Oq-CD; Mon, 28 Oct 2019 14:56:30 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 66C6227403EE; Mon, 28 Oct 2019 14:56:28 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Keyon Jie <yang.jie@linux.intel.com>
In-Reply-To: <20191025224122.7718-26-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145628.66C6227403EE@ypsilon.sirena.org.uk>
Date: Mon, 28 Oct 2019 14:56:28 +0000 (GMT)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: PM: Add support for DSP D0i3 state
	when entering S0ix" to the asoc tree
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

   ASoC: SOF: PM: Add support for DSP D0i3 state when entering S0ix

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

From c470fc3f61b25e955f8ba90fc9dc554881e4e72c Mon Sep 17 00:00:00 2001
From: Keyon Jie <yang.jie@linux.intel.com>
Date: Fri, 25 Oct 2019 17:41:21 -0500
Subject: [PATCH] ASoC: SOF: PM: Add support for DSP D0i3 state when entering
 S0ix

When system is entering into S0ix, the PCI device may transition to the
D0i3 substate instead of D3. In D0i3, some always-on functionality can
be enabled, such as acoustic event detection, voice activity detection
or hotwording. When an event is detected, the DSP firmware can wake-up
the device for a transition to D0 with an interrupt.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191025224122.7718-26-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/pm.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 99e4e6ffff74..560a937e0484 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -430,12 +430,58 @@ EXPORT_SYMBOL(snd_sof_set_d0_substate);
 
 int snd_sof_resume(struct device *dev)
 {
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	if (sdev->s0_suspend) {
+		/* resume from D0I3 */
+		dev_dbg(sdev->dev, "DSP will exit from D0i3...\n");
+		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I0);
+		if (ret == -ENOTSUPP) {
+			/* fallback to resume from D3 */
+			dev_dbg(sdev->dev, "D0i3 not supported, fall back to resume from D3...\n");
+			goto d3_resume;
+		} else if (ret < 0) {
+			dev_err(sdev->dev, "error: failed to exit from D0I3 %d\n",
+				ret);
+			return ret;
+		}
+
+		/* platform-specific resume from D0i3 */
+		return snd_sof_dsp_resume(sdev);
+	}
+
+d3_resume:
+	/* resume from D3 */
 	return sof_resume(dev, false);
 }
 EXPORT_SYMBOL(snd_sof_resume);
 
 int snd_sof_suspend(struct device *dev)
 {
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	if (sdev->s0_suspend) {
+		/* suspend to D0i3 */
+		dev_dbg(sdev->dev, "DSP is trying to enter D0i3...\n");
+		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I3);
+		if (ret == -ENOTSUPP) {
+			/* fallback to D3 suspend */
+			dev_dbg(sdev->dev, "D0i3 not supported, fall back to D3...\n");
+			goto d3_suspend;
+		} else if (ret < 0) {
+			dev_err(sdev->dev, "error: failed to enter D0I3, %d\n",
+				ret);
+			return ret;
+		}
+
+		/* platform-specific suspend to D0i3 */
+		return snd_sof_dsp_suspend(sdev);
+	}
+
+d3_suspend:
+	/* suspend to D3 */
 	return sof_suspend(dev, false);
 }
 EXPORT_SYMBOL(snd_sof_suspend);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
