Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BBFC48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 12:08:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBAA661437
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 12:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAA661437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F6741693;
	Tue, 15 Jun 2021 14:07:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F6741693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623758899;
	bh=C59SXF8kM4HNcdZxrEa6z376xr37BIWP3ZfoDwC39DE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XF6wEZQlh1bMmmtBDUbMf6QaBhH4PsyeajfGzG09Lennvf6RDd5VwYObLYDeVJaH8
	 yhXZMTGMLLKvAHArYsqPXUA8R3wg1lYj69kPDjXdJsETmJqHKBJu3H0oNDjoRGCQ9J
	 PTFRWnNKuCjUQdkLpG0xvcY0gow/zBSLvVAxge4U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A1B3F8016C;
	Tue, 15 Jun 2021 14:06:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73BA2F8049E; Tue, 15 Jun 2021 14:06:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0A7AF8016D
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 14:06:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0A7AF8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ehE4e8so"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0895961437;
 Tue, 15 Jun 2021 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623758808;
 bh=C59SXF8kM4HNcdZxrEa6z376xr37BIWP3ZfoDwC39DE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ehE4e8soru4vX7YvJZiz5Nmi1Uq/jGfeAvHK2X+uJx9wmR8JrtAIzTzIe4L35Ca1t
 Dt+cmGHyoiZXrwMlLmrbO6XWsKLsumD6uGKiy30ZROwC4Cu1dooG9uhI3MnO6RuFh3
 Tou4xN+SlMDkBA/KOP6GHhAtsKUbOKNhE7HJDotffruyOt+YxgMYQ+ar0F3LIO0TiI
 8PXqq5QqgjBGE98tKRZkUYM+PiBAQn3Ul5fZDMkZ80YjabUdry+R90bbJr5pfGjspC
 8Tvw1ldCE7PX67+au4fk5oOvyvLgf8Al6eCSv07ClotTCiPbCoZv1MZnAtcvG/geoD
 2lMBZafWmHmgg==
From: Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,
 spdif: Add compatible string for imx8ulp
Date: Tue, 15 Jun 2021 13:06:25 +0100
Message-Id: <162375817571.30661.10673881585496337751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622613849-10271-1-git-send-email-shengjiu.wang@nxp.com>
References: <1622613849-10271-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Wed, 2 Jun 2021 14:04:09 +0800, Shengjiu Wang wrote:
> Add compatible string for imx8ulp, which supports spdif module

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,spdif: Add compatible string for imx8ulp
      commit: cb7d734ea9b85f49f26d04d8de09ece363cbd6fc

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
