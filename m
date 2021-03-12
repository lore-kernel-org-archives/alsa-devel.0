Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD8C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 20:27:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EE764F88
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 20:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EE764F88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1483482E;
	Fri, 12 Mar 2021 21:26:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1483482E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615580861;
	bh=XM03Gt6hwnAQA+iUKmdY5gbRmhZPWBo/y7O/aK8RnLI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u+oJrj9xN/z5QHFFsMs+dja2Z0YD6OouYOZQlCaqFt99RLIP4lwgAD1Rk549PTc8H
	 oPz3a83LmqevEceY2LxHtQ6qQsCHOQYaBJ41zDoSOvfgn65AuEeBg0ixiASslwmIV3
	 qTL/SMqgfWdAKs05pHyYWozTRFhjUS1e+AcVGbGs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA8CFF80431;
	Fri, 12 Mar 2021 21:25:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFED6F80475; Fri, 12 Mar 2021 21:25:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E033EF8042F
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 21:25:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E033EF8042F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AASoTXXQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BF6E64F86;
 Fri, 12 Mar 2021 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615580721;
 bh=XM03Gt6hwnAQA+iUKmdY5gbRmhZPWBo/y7O/aK8RnLI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=AASoTXXQed8pOwRYePS/BplyEU4iF/DWiw9dztQ9fY77nPOvMd3JqW88ovkxaHKSS
 QWYdBSJIWrVWP2IfUUPcXhKpRi0JtDjvIR6hy92HzXiwH/sRvK4/C47DWXOSXRrwJE
 +s3XoTTFqZaw3vJKsgciSSUmzY7CVDgi/oWN18rqMjCwCo+YcK/4tx3uxususyvgSi
 9WofbZ7sEC5BiEn6uASFFbIW2krlkSo8KUC7iBuFyklxyHaoVRSEF0L/mu2oiz6j6e
 Ze1+vrAlbAQzNNj/GY1ssut9EeH1VwRITv0oPMD6LDaog5gdhgnFObsoTTcj8eNVSP
 8/JRPfCjEXFVA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: mediatek: remove cppcheck warnings
Message-Id: <161558062957.11113.1173652950898922023.b4-ty@kernel.org>
Date: Fri, 12 Mar 2021 20:23:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>, linux-kernel@vger.kernel.org,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

On Wed, 10 Mar 2021 18:49:00 -0600, Pierre-Louis Bossart wrote:
> There should be no functionality change, this patchset only fixes
> shadowed variables, prototypes and removes a useless assignment.
> 
> Pierre-Louis Bossart (4):
>   ASoC: mediatek: mtk-btcvsd: remove useless assignment
>   ASoC: mediatek: mt2701: align function prototype
>   ASoC: mediatek: mt2701: rename shadowed array
>   ASoC: mediatek: mt8173: rename local irq variable
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: mediatek: mtk-btcvsd: remove useless assignment
      commit: 2e5e57f085a3243aae7e4af88dc2c40e5ff4d3be
[2/4] ASoC: mediatek: mt2701: align function prototype
      commit: 57f1379e77a7432759e2f35b720c71863e2d83bc
[3/4] ASoC: mediatek: mt2701: rename shadowed array
      commit: d9cdc1335622866c52a463325b3aaea9844cff1b
[4/4] ASoC: mediatek: mt8173: rename local irq variable
      commit: 14667403a5631ce2fd2935d90c6d36f7975f61f3

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
