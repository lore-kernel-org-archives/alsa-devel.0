Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CF8C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Feb 2022 15:21:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F1091765;
	Thu,  3 Feb 2022 16:20:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F1091765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643901709;
	bh=FctJN1sIoIS0ykPIhJCIx5ELzMe65UGssOiXwzd68qg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hlo9K2yK4YIMi/3gY0KJNais+MAEX4xOBr1o1n49Yjd4KAFJuV0SJHzlZUaARtKyo
	 DNd57GDoPYKOBIkSM1kXTtcJ3AnmkJmtQUjRc1JjsJnfBLH8xObgDBqey7AsFi4vqe
	 qksbJ2/5AtlY6SBk/3+02vlcTowZJUGieaNRhRpk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFDAAF8051B;
	Thu,  3 Feb 2022 16:20:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B788F8032B; Thu,  3 Feb 2022 16:20:06 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C6EAF8032B
 for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2022 16:20:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C6EAF8032B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YFRCXwdt"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 56D1860A54;
 Thu,  3 Feb 2022 15:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DC2C340E8;
 Thu,  3 Feb 2022 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643901598;
 bh=FctJN1sIoIS0ykPIhJCIx5ELzMe65UGssOiXwzd68qg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=YFRCXwdtzRppEIpPukxJXc5ARbRELlf72Wb25Ssz8Ys62mOOhx9v2VshG6ogdDC5W
 ISejDX1xo8aKMEXiA6w7BZKpD6L+f1JICXaOWhzyXhA9tGdf8Bm1zbCMMkW5R5D7On
 FYgU2qaSiesupS1nYiqzNgDcbOKKChKFDaXzVqz2kBLZCWs+aHMkD6TE8sGIEmvaAy
 vJY9vMRXeGw8+KKqfjA7dA8ONp/IUIe1CKqCpBLQLNW4h3LbgoD99gXChDluJrbeLO
 ku2DOSComdQsm8yY2+vBYJ7Fne1YKDHEHUz+L7P31veeLAl3rzoV+vDHnmBdvyzJcN
 wcVUceSwKKfHg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20220203115025.16464-1-ckeepax@opensource.cirrus.com>
References: <20220203115025.16464-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: madera: Add dependencies on MFD
Message-Id: <164390159763.786717.14382838277432263194.b4-ty@kernel.org>
Date: Thu, 03 Feb 2022 15:19:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com
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

On Thu, 3 Feb 2022 11:50:25 +0000, Charles Keepax wrote:
> The Madera CODECs use regmap_irq functions but nothing ensures that
> regmap_irq is built into the kernel. Add dependencies on the ASoC
> symbols for the relevant MFD component. There is no point in building
> the ASoC driver if the MFD doesn't support it and the MFD part contains
> the necessary dependencies to ensure everything is built into the
> kernel.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: madera: Add dependencies on MFD
      commit: ec29170c724ca30305fc3a19ba2ee73ecac65509

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
