Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5EC433E6
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 16:59:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C106564F0C
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 16:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C106564F0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 962301676;
	Wed, 24 Feb 2021 17:58:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 962301676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614185959;
	bh=CSaPMxW/R+nasgbjStE4LdLhn39/QCJMGRLQdV56Nrw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pjIcMIl5Nm5hCg7Y6+GYxQSx8azDPuzSHahtkt379EfYx65Zy5e3vhG2gjpGvrka3
	 bF1V67yUL43YeH06kqE62mX7bgZYbg97LstDPPwrxlekP7BcqUtPhtoctpJfGNfJ7F
	 BMYCWWtPq4aWaXlpA08j0WT4UIqBhJD2AUo1NhnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E21E5F80161;
	Wed, 24 Feb 2021 17:58:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0965F8016C; Wed, 24 Feb 2021 17:58:26 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1287F80129
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 17:58:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1287F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SngYABIA"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF47F64F09;
 Wed, 24 Feb 2021 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614185900;
 bh=CSaPMxW/R+nasgbjStE4LdLhn39/QCJMGRLQdV56Nrw=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=SngYABIABaKgySWl0y6v5midbjvyKPKQZMjOjV4CQAJujTlTKNW9wkbBw1t6RVH/E
 IMVSI5tW5o5TjH4lVu1h6hr/iX/NsF0tOExmvNMt+kmIk3Y33m5UBY5A4mbTZ/puPG
 uPITQtVtffSM07SY58q9LlzjpdTr2oqnsULaDf4ofXJCM8ez1Ylj0a5y2usJ3Q7Pkr
 iEakPLOhJMWglBI+nUxP9JvPtAcQhw05uHn/7AphMcHAPTDoJUiKPuT/db3LymsTKx
 hWiID/tA53yZP8wj/+G9AyOquTQPFSAelcuYVqrlqUJe/+nBkNvG8E7KUlHGMKu5hk
 Eij45/68mvmWw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com
In-Reply-To: <1614149872-25510-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614149872-25510-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: ak4458: Add MODULE_DEVICE_TABLE
Message-Id: <161418583680.1249.97940912482795422.b4-ty@kernel.org>
Date: Wed, 24 Feb 2021 16:57:16 +0000
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

On Wed, 24 Feb 2021 14:57:51 +0800, Shengjiu Wang wrote:
> Add missed MODULE_DEVICE_TABLE for the driver can be loaded
> automatically at boot.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ak4458: Add MODULE_DEVICE_TABLE
      commit: f84b4524005238fc9fd5cf615bb426fa40a99494
[2/2] ASoC: ak5558: Add MODULE_DEVICE_TABLE
      commit: 741c8397e5d0b339fb3e614a9ff5cb4bf7ae1a65

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
