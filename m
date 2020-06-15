Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D711BC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 23:48:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DA32074D
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 23:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vRDWozKC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMytGS/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DA32074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE1EA166E;
	Tue, 16 Jun 2020 01:47:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE1EA166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592264891;
	bh=wmMrTJlDcXeeLr5UjbU5+uAWskHZyXjosJMgpE4Z/Ys=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRDWozKCdT/XXjebdxj3EZVSsmBufSPqOJAoJOWlDoWhJpYLsweMG1UZP/JhdlNYA
	 ECc5798mkHjzrPgUlr+NbQHv6X9LZJh5nzE2a3qns8fFJ6BUyk38zVKS7Jx/zpw/TT
	 Z4BWILwcHZ1rUmfmEL4FPJjfkMOLWukxslk+xXkw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A6CCF801EB;
	Tue, 16 Jun 2020 01:41:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62CACF80331; Tue, 16 Jun 2020 01:41:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9900AF80162
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 01:40:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9900AF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FMytGS/l"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3B46208C7;
 Mon, 15 Jun 2020 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592264456;
 bh=wmMrTJlDcXeeLr5UjbU5+uAWskHZyXjosJMgpE4Z/Ys=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=FMytGS/l9Q7rfRAWWuUJCjK4MdsYQ2tN5IbvduDrZtNhidlx8yhZFOPzGNUGHL5GW
 v9X3c71oALhFIQgqNdVKcPZ89EWHihH25poCzcxKLBrGUYKbqvAn3F1mFvdoO5iYbY
 0icsalBe+CJcIfNBdvnAOTaxIYIvjfkZiwZSGleI=
Date: Tue, 16 Jun 2020 00:40:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>, lgirdwood@gmail.com,
 matthias.bgg@gmail.com, tiwai@suse.com, hariprasad.kelam@gmail.com
In-Reply-To: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
Message-Id: <159226439189.27409.5559737025420657238.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, howie.huang@mediatek.com,
 linux-kernel@vger.kernel.org, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

On Fri, 5 Jun 2020 18:33:40 +0800, Jiaxin Yu wrote:
> v2 changes:
> 	1. Uses a DT property to select DMIC mode instead of a mixer control.
> 
> v1 changes:
> 	1. Uses a mixer control to select DMIC mode.
> 	2. patchwork list:
> 		https://patchwork.kernel.org/patch/11578309
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
      commit: c46fc800948c2d0afb548ca12453b837aa1ac880
[2/2] ASoC: dt-bindings: mediatek: mt6358: add dmic-mode property
      commit: 6323f13b4d927f52f339f7122676de0b0d1da3c3

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
