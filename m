Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0852AC07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:52:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CFA60698
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CFA60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAFFE169D;
	Mon, 12 Jul 2021 12:51:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAFFE169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626087118;
	bh=DgYeXycIN12L0WSlhLRY1UtMgIe8E09yl5eaBy57a2w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWsdQGmW6P4n6Pzar9IeehsynyenE0DY06jIyvkeK9vXthikhFD0goY1Wl/6LPkLN
	 +sEVnCmKNjYjg07f2msFzRi6z3+ZN9Hbi5v+wnDP6dqxr5keSK9KxSd9I0HoTtJL8n
	 BVYg1fnPmh28uoOEELCnzD0rtAwJWisHdU3eleKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76887F80518;
	Mon, 12 Jul 2021 12:48:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2266F80518; Mon, 12 Jul 2021 12:48:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C891F80515
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 12:48:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C891F80515
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UBHhomH6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 205D8610A7;
 Mon, 12 Jul 2021 10:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626086880;
 bh=DgYeXycIN12L0WSlhLRY1UtMgIe8E09yl5eaBy57a2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UBHhomH6Dvcjwhvl94hPUwnVd70jDjcUA6dpzCArd6lXCH4RoVtna30BG1XBo/ltE
 yC1uwuWud393Kac3igagQZuI53SCPc6Qlog6MPKzuQdHwnQF00nlkUiqlU9JmrazMY
 rPzXbscVd7uf7zFcp9eNuS0zTEYZNKG/HIkjAjY3bjz8XoBb4I04dp8jSqsEvNMWei
 re6xYdaZ0W0egJNr8pWs9TbxuzOAEtJterzyZgVBKcR6L4sLgJZQAh1u+UpD9ibKwq
 Q1lAzxMLKzk4FB0E625zeTUsFUapbRI9czFNpxgD2RhXswnVpT7XsyEEMKZl2DK8yg
 /kJjdVplPFD8Q==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Fix TAS2505/TAS2521 channel count
Date: Mon, 12 Jul 2021 11:46:05 +0100
Message-Id: <162608623152.3192.5932495501881574538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210708091229.56443-1-marex@denx.de>
References: <20210708091229.56443-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, ch@denx.de
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

On Thu, 8 Jul 2021 11:12:29 +0200, Marek Vasut wrote:
> The TAS2505/TAS2521 does support up to two channels, LEFT and RIGHT,
> which are being alternated on the audio data bus by Word Clock, WCLK.
> This is documented in TI slau472 2.7.1 Digital Audio Interface. Note
> that both the LEFT and RIGHT channels are only used for audio INPUT,
> while only the LEFT channel is used for audio OUTPUT.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320aic32x4: Fix TAS2505/TAS2521 channel count
      commit: 3694f996be5cb8374bd224f4e5462c945d359843

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
