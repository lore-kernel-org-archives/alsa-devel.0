Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A819FC433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 17:04:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A6F613AC
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 17:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30A6F613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D97541693;
	Mon,  4 Oct 2021 19:03:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D97541693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633367051;
	bh=TCDmtxJg9+bbw+GPtAIBnLLG8h58Y+aBEyzOPC1Abp8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=onfea3WeiyQ5LBBEKLFwGRw5YRKUV5f1VbeTnghVC2Y5r5tglzCs8wPB5VsYkDc7x
	 yh/mDL9I907BhDveATUA1n1u2iZh3HF0IToiYwJC65Akbsc37deQnBnC66anZr88V6
	 7yPD1K+RJbfx0iHvOFhsHwYGxm2ieYm+twFL7p1w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15DA5F804EC;
	Mon,  4 Oct 2021 19:02:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3D3FF804ED; Mon,  4 Oct 2021 19:02:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB9F4F804E5
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 19:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB9F4F804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KM1m3J8g"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EAF761458;
 Mon,  4 Oct 2021 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633366970;
 bh=TCDmtxJg9+bbw+GPtAIBnLLG8h58Y+aBEyzOPC1Abp8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KM1m3J8g56jO2O4acNC9ne8DrtrS36Gk9MPC/AYcwKlOmhJTJBEIUT/cSwz3IlOmI
 xl4BYgxC17SHjtqhxGlLIid3q6ql+g0ywBFIauqWJ+kPXgMAoJCbVbBhCYQu6qmRCH
 3GMOhPTXX+Jwj5WdEureXbhI7VSfZHBAgdMLZ4A7Qez4B1OAQ+Gc94Tv9tqCaid4NR
 F2OVuwZGzHILVVw+krk3L3ZQZ99P/cM/zohakxwQUCJFiUVSnSULmpT8zOXIISYk1J
 ij7BurRHzjKjc8O0BOh6b888QwWIelDOx4DyacE+0fCR+ocZYaGiFod3NQm87bjtGm
 heQ6tiP0VpxBQ==
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: es8316: Use IRQF_NO_AUTOEN when requesting the
 IRQ
Date: Mon,  4 Oct 2021 18:02:34 +0100
Message-Id: <163336659969.3340210.8499979221603399585.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211003132255.31743-1-hdegoede@redhat.com>
References: <20211003132255.31743-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

On Sun, 3 Oct 2021 15:22:54 +0200, Hans de Goede wrote:
> Use the new IRQF_NO_AUTOEN flag when requesting the IRQ, rather then
> disabling it immediately after requesting it.
> 
> This fixes a possible race where the IRQ might trigger between requesting
> and disabling it; and this also leads to a small code cleanup.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: es8316: Use IRQF_NO_AUTOEN when requesting the IRQ
      commit: 1cf2aa665901054b140eb71748661ceae99b6b5a
[2/2] ASoC: rt5651: Use IRQF_NO_AUTOEN when requesting the IRQ
      commit: 6e037b72cf4ea6c28a131ea021d63ee4e7e6fa64

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
