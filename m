Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01034C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 17:02:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 354461F17;
	Wed,  2 Mar 2022 18:01:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 354461F17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646240557;
	bh=03m/Ug+M2jkhIYNLtlMDdUeKAjuUOGD+JbkbKcwu9f4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n5go6CkYO65KpZdl8Wt0J7mUWs5xL2y0sevS1owXXcIBWzWNvW67UH4D+iqaW8DVj
	 XTFVWi0sPCJLez0s7kMT/tI9H1Z4H8079BWDyVkTaovCszfihlPWiuGCYV/guCH4FV
	 j7adxDVpn0SVXbEP/marAc52P1H5bSKKZ21BVQZw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF6E4F80515;
	Wed,  2 Mar 2022 18:01:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42F62F80054; Wed,  2 Mar 2022 18:01:01 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7A99F80054
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 18:00:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7A99F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="N0oOgQcS"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0DE2DB82104;
 Wed,  2 Mar 2022 17:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570ECC004E1;
 Wed,  2 Mar 2022 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646240454;
 bh=03m/Ug+M2jkhIYNLtlMDdUeKAjuUOGD+JbkbKcwu9f4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=N0oOgQcStSStcr0Wfky2G20L6W1S9Ne+gXlMYJ08y3gfhKDsW+MXgL7AVugz7foJs
 obmuq5YXA0aMN8CotjS92NxBF4sK9WFPRLyT32nIdwrHHNq6UvzZDIu7evboy0YIR9
 bZ5J8gUMuDEcItYcSaro5RfJrMNhZ6NBSjqvgr5l8Fyk9UxYsnKv6S9egG+ZPkFTmH
 Lix7K1WxJFv+8RWxy/rMIwSAXUJ4J5ula/zYxTg5LOXCVofHwCTOF5or42UCBp74oO
 1q3zoLBkPLNZ8bGT9lkcrNFHTjBBL/HSHszgTnjCasfiA9R/vxyZRfagY+AI6o1naQ
 a1MplYzy/xLIQ==
From: Mark Brown <broonie@kernel.org>
To: linux-imx@nxp.com, lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
 shawnguo@kernel.org, kernel@pengutronix.de, s.hauer@pengutronix.de,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, festevam@gmail.com,
 Julia.Lawall@inria.fr
In-Reply-To: <20220301081717.3727190-1-jiasheng@iscas.ac.cn>
References: <20220301081717.3727190-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: mxs-saif: Handle errors for clk_enable
Message-Id: <164624045208.1145067.12901529281090150709.b4-ty@kernel.org>
Date: Wed, 02 Mar 2022 17:00:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 1 Mar 2022 16:17:17 +0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it, like mxs_saif_trigger().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mxs-saif: Handle errors for clk_enable
      commit: 2ecf362d220317debf5da376e0390e9f7a3f7b29

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
