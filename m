Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7694AC433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 16:56:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D61610CB
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 16:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D61610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3A8B1607;
	Thu,  8 Apr 2021 18:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3A8B1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617900981;
	bh=ljaoLjpUyxpXyGPLoASETbRS8txgyowKqom0/yFE2Ds=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fy38FyPlaqjVpvY1xSVKTZ5WvigUXnoWBq2IrUvIEfVXEzNenn4YNk69k2y+lC3Ck
	 bbef/ilWQyO46juWNe/taZQjPFajbYZawx6GyQwxSjDOd/YPnbtgqvkFyCYA0ycO4G
	 5ifuzb5b+NjN6NP2sZBqVLcuThxlhht4Ta+5JKkU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB38DF80259;
	Thu,  8 Apr 2021 18:55:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25798F80259; Thu,  8 Apr 2021 18:55:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4494F80169
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 18:55:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4494F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ULfOGTmh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9B0961056;
 Thu,  8 Apr 2021 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617900921;
 bh=ljaoLjpUyxpXyGPLoASETbRS8txgyowKqom0/yFE2Ds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ULfOGTmh/WigfVcTncZ6zJkPS5/D79ZnHR24Xe6fQMZC6XGa3Nh9V62tOy04OvHc0
 CKOeBnY74SI+O9SJVHF/vB5YFWuxj6EpB99eyUW2iy5qYtjjxLWtVhUWKXutqrqkZX
 csW5LrZqwsE9C6Pl+It283z7tscaFR9+ux0XqdtWA773M4IWI+J+jnNgceTW3Lz8Hw
 nEa+HAhJqQvINk1OXoQ725q3vtjvxr9aXyhRJdQtzht/cvig+urtXf4+tOc+r3lOcl
 R22Y4z7mhXT/9Q/CtpXTuqvcaAsH6Zbtf/M9ZYGGqCNiqAdN+dax9vZGZD2ksEIcKg
 SgkM1EF8D+CTQ==
From: Mark Brown <broonie@kernel.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: tlv320aic3x: add SPI to the DT binding
Date: Thu,  8 Apr 2021 17:54:35 +0100
Message-Id: <161790012550.16915.11806194903790092299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408060741.6879-1-jiri.prchal@aksignal.cz>
References: <20210408060741.6879-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
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

On Thu, 8 Apr 2021 08:07:41 +0200, Jiri Prchal wrote:
> Added note and example of SPI support.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: tlv320aic3x: add SPI to the DT binding
      commit: 38ec3006eccb46a6db6f4a36536f78db8e9042ac

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
