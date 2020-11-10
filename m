Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0936C55ABD
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 16:03:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4259207D3
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TAfdhd+a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5UIDUn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4259207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BEFF171B;
	Tue, 10 Nov 2020 17:02:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BEFF171B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605024212;
	bh=iADrLn2HoxkSAWgvmWuMUnpsZB/Nm9suSBYYixtnh+E=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TAfdhd+a6IMv0sHplfGEXoNJA5sRbpq8kcRJ8wvXQxGtXiYizH0ktjLCpJGFC6ehO
	 ZeXVronkveWplRz6V6R6j/n7F9+SMYtL6A/0XME8xRIg1yRIZHAEsrY5A6th1JG+P6
	 IKw0uTCbUl+kpSP8v/H4M3hXbFTvWFzNXvhS4E1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DC3EF80161;
	Tue, 10 Nov 2020 17:02:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3B06F801D5; Tue, 10 Nov 2020 17:02:39 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11444F80059
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 17:02:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11444F80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="t5UIDUn7"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 55487207D3;
 Tue, 10 Nov 2020 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605024154;
 bh=iADrLn2HoxkSAWgvmWuMUnpsZB/Nm9suSBYYixtnh+E=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=t5UIDUn7jEsSTtYBucVie6qmVB93TT5AJbE5NbkH8H3ssL21QLi7qn6DpxiKYXOc1
 c0z8fk13IFgYWH38y7/0GGFe/UDJ1pCWA5q3+38khq+5a0fzZufrHY+u/TqoisHXva
 VD4taPadol7mmH8xSdgL9XDAJSga8Mjjkhu1eppU=
Date: Tue, 10 Nov 2020 16:02:20 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lin <CTLIN0@nuvoton.com>
In-Reply-To: <20201102023212.594137-1-CTLIN0@nuvoton.com>
References: <20201102023212.594137-1-CTLIN0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8315: add codec driver
Message-Id: <160502414080.45830.17448982167604918792.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org,
 KCHSU0@nuvoton.com, lgirdwood@gmail.com
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

On Mon, 2 Nov 2020 10:32:13 +0800, David Lin wrote:
> Add codec driver for Nuvoton NAU8315.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: nau8315: add codec driver
      commit: 4d1a9952dda649284413e6ff12b81db3a2bc4115
[2/2] ASoC: nau8315: revise the power event of EN_PIN dapm widget for symmetry
      commit: 9352d45a6e4588b8c7ddded871e08d89e0e6b79f

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
