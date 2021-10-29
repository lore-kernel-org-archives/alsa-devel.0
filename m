Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89EBC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 20:56:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17B961075
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 20:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E17B961075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6A731707;
	Fri, 29 Oct 2021 22:55:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6A731707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635540999;
	bh=pOJQpgaSJK6t2EtQjZhIopjYqTh/FOv6CfFCmJ6dhqE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gmvhuU7qdsrc3nFvArocSxhAeGe9qVDBpUg1FZ5a8NwzgCDi6ADQytrCq2eVgcXqv
	 iHY2UDUNyPALIFPQizyUg31m4pjRqerVrjIUjPbJ7EPawbGDYZPL3MOqop8EjfufG2
	 dYnjIiu2vKjjK8EOTnw6sDJQJTi92+suy+7rcF3Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 012DCF8025A;
	Fri, 29 Oct 2021 22:55:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E13C9F8025E; Fri, 29 Oct 2021 22:55:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A576F800F4
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 22:54:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A576F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uS4HqaU8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8172A61075;
 Fri, 29 Oct 2021 20:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635540895;
 bh=pOJQpgaSJK6t2EtQjZhIopjYqTh/FOv6CfFCmJ6dhqE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=uS4HqaU85jBAkWVmi6fs6wzFG4WpNMC6VW447pGwOE+NKlvNBnhPvm4cdRS9InG/b
 bu11Ky4Ccr3F9Uxf3o0vtuSd8WdKyd1/a3UHaV0bGxVu06yq/MDsME2H3tBuy57bv1
 vA9X1746ZihdPiJJ2FbJZBAqTnotLaPRDkY+Ev2nE9shgUngx7bk2bQ7R5f/yGDWop
 yY7j2BGx55uz5QNVZagVJsUqtBoUojgqvBzcLAw5OwpeMHaK1POpmF4WM280kHuCmV
 cmwcZBniKmeo2aWcem3Q3sYFU63/sRXLGjFNS+BMC8BeTLzbDjyZrG63CPi5u/A6bW
 /Su2O7yYK4MCQ==
From: Mark Brown <broonie@kernel.org>
To: Trevor Wu <trevor.wu@mediatek.com>, matthias.bgg@gmail.com,
 robh+dt@kernel.org, tiwai@suse.com
In-Reply-To: <20211020071428.14297-1-trevor.wu@mediatek.com>
References: <20211020071428.14297-1-trevor.wu@mediatek.com>
Subject: Re: [RESEND,
 v2 0/2] ASoC: mediatek: Add support for MT8195 sound card with rt1011
 and rt5682
Message-Id: <163554089329.1997146.2620727675711869109.b4-ty@kernel.org>
Date: Fri, 29 Oct 2021 21:54:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, aaronyu@google.com,
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

On Wed, 20 Oct 2021 15:14:26 +0800, Trevor Wu wrote:
> This series of patches adds support for mt8195 board with mt6359, rt1011
> and rt5682.
> Patches are based on broonie tree "for-next" branch.
> 
> Changes since v1:
>   - refined code based on Pierre-Louis's suggestions
>   - added missing of_node_put
>   - fixed wrong fixup assignment on HDMITX
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8195: add machine driver with mt6359, rt1011 and rt5682
      commit: 0261e36477cfa2608468c1300e30cb667c5e1269
[2/2] dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1011-rt5682 document
      commit: 6c8552ebba7742e7128134859846e17edbfdf222

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
