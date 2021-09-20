Return-Path: <SRS0=8ObE=OK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C56BC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 15:34:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960E7610CE
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Sep 2021 15:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 960E7610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23D6016CA;
	Mon, 20 Sep 2021 17:33:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23D6016CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632152079;
	bh=f6tcROz9EjoLl2mHaX7AcHG7HmHZI2rJ93ZH3eRTIjY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YCI76oikOSoe/V1Xun52UWjJa+CbDBN9fo6v8var6yOq6AgvMrrCJmgyXXBZxQAkh
	 AAN3XfMbV+0QYeB3Q6JkLEECeqRBIUzABN4A0QTMF9p16Puc/3J1a67mViRFkPVO9G
	 eLuf7bbC7KNZNNYrfV6zw/3wIbiO/rElFv88IFkU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A6B8F804FF;
	Mon, 20 Sep 2021 17:32:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3926BF80246; Mon, 20 Sep 2021 17:32:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABBE4F804BB
 for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2021 17:31:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABBE4F804BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cEwJIBtQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9794B610FB;
 Mon, 20 Sep 2021 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632151914;
 bh=f6tcROz9EjoLl2mHaX7AcHG7HmHZI2rJ93ZH3eRTIjY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cEwJIBtQvFgThdAWISL/tsD43Ik8cgNlVGUSLdokrssFaHehJcZRdlmJgGTdSkrNP
 cxEVoYebYmJAkpwn4Q+Rzfi0FNrXMtHpy1gXuY4S/GDp7/Ng40sao5NNpfbtkUPEJy
 kBvbr0ANdfaO7+ZLISatlXoKydAUaEDT4mxeaYt8VWtpJmmzKsL35k3Ap65gL3QwKT
 7ysggilLWcKtnKufQvsK2LZRmf3CwdPBmET2AVtV6QciB59DCq1lC1RF6AFjMJxcvV
 eEfej8rxtai5NBfiajSIaUF9Y+9jyBzS45gWJVyud+8PnICYrNHKs/y3VYdrTlbSxJ
 +GkXc6y1xfZJg==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: ab8500: Update to modern clocking terminology
Date: Mon, 20 Sep 2021 16:30:50 +0100
Message-Id: <163215150720.38322.5479784152445262998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916141335.43818-1-broonie@kernel.org>
References: <20210916141335.43818-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>
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

On Thu, 16 Sep 2021 15:13:35 +0100, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the ab8500 driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ab8500: Update to modern clocking terminology
      commit: ef92ed2623ead917e4f10465451aa12cd7977241

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
