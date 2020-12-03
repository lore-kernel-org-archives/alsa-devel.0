Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A964C433C1
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:20:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BE220798
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BE220798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72E0B1819;
	Thu,  3 Dec 2020 15:19:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72E0B1819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607005237;
	bh=UGXI/PWxHamoJW1r5FzJR33V/RIy/77lneQFYlAoCmU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JCkxxEZ2FYpZVbAkVQj2gUHDvoCu4ULkKIW8WGgMOu5IpFW6f9PsIBTh0K886P6qb
	 u6V6AveOPhRrKcFUSEQ/kM9rqevf8ZY6leKCwhbC1a5DonvtOaITCnohtp1lV5S7/Z
	 tibG4g1ghSaukM8CXJsGfbnivopPDZjKdCiNOr7Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0CE5F8025F;
	Thu,  3 Dec 2020 15:18:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6F4DF8016D; Thu,  3 Dec 2020 15:18:54 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57B59F8012A
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 15:18:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57B59F8012A
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, perex@perex.cz,
 Shengjiu Wang <shengjiu.wang@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 timur@kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 tiwai@suse.com, festevam@gmail.com
In-Reply-To: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
References: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Add support for si476x codec
Message-Id: <160700512198.44361.18384133171951697931.b4-ty@kernel.org>
Date: Thu, 03 Dec 2020 14:18:41 +0000
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

On Mon, 30 Nov 2020 11:57:47 +0800, Shengjiu Wang wrote:
> The si476x codec is used for FM radio function on i.MX6
> auto board, it only supports recording function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl-asoc-card: Add support for si476x codec
      commit: 77f1ff751037fcd39c8fc37b3c3796fb139fb388
[2/2] ASoC: bindings: fsl-asoc-card: add compatible string for si476x codec
      commit: 0b3355b070434f9901f641aac9000df93e2c96ad

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
