Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A99C433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 17:11:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1508523B04
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 17:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1508523B04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A256716DF;
	Tue,  8 Dec 2020 18:11:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A256716DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607447511;
	bh=plV8I0bySicFB1JidK/SdCqiEkA2o9bWoORFOACJkos=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OAuFzNnxgwenLKHeCMiGoLQGEaRgbdaKNm98DUHgEtmNJLVjVkiW6BIZtPWK/kd+r
	 mahM5fYUsTTdg7jaX5VKKsHGvQa33qRWCTzYyOdrk3TwKfm3DrUeufZ70Rl5RDyplE
	 2L5WuhINDSwJIbGcvSdhwSCTDIHejWfDaMOdiWdM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F33B1F8026A;
	Tue,  8 Dec 2020 18:10:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72218F8027C; Tue,  8 Dec 2020 18:10:16 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 108A5F80269
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 18:10:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 108A5F80269
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, perex@perex.cz,
 robh+dt@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, tiwai@suse.com
In-Reply-To: <1607251319-5821-1-git-send-email-shengjiu.wang@nxp.com>
References: <1607251319-5821-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: imx-hdmi: Add binding doc for
 hdmi machine driver
Message-Id: <160744738921.29839.15317690694275693705.b4-ty@kernel.org>
Date: Tue, 08 Dec 2020 17:09:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sun, 6 Dec 2020 18:41:58 +0800, Shengjiu Wang wrote:
> Imx-hdmi is a new added machine driver for supporting hdmi devices
> on i.MX platforms. There is HDMI IP or external HDMI modules connect
> with SAI or AUD2HTX interface.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: imx-hdmi: Add binding doc for hdmi machine driver
      commit: e344cf5e4871f99495396f78d4401b8ac4c92465
[2/2] ASoC: fsl: Add imx-hdmi machine driver
      commit: 6a5f850aa83a1d844d27e3e53ca2f247e55d438b

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
