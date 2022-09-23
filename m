Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACE5C07E9D
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Sep 2022 17:07:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0232201;
	Fri, 23 Sep 2022 19:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0232201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663952874;
	bh=MXUJSh7a67zClSJcrIQ8uTLgyyJ6AiyBVSt6Oo0niKQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ot/d5Y8rE5YZcANZtO+rUEoh/WqRMxb0x6UxQOo6CzFjvTWJ3uP5Ub+l0UtZPMbMu
	 1v3YnstQ+81/BDznbaOnA1K6KiIifqu8WGpIKfKzG2rqmg0xAY3ipLyCoDa4yLJ8B9
	 VzGgNIL1HHD9WiGPv8D92U66CYl8PjeOA5pVj9QY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BB6AF80269;
	Fri, 23 Sep 2022 19:07:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E470F80269; Fri, 23 Sep 2022 19:07:02 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9A35F80107
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2022 19:06:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9A35F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="L5ozGfX7"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D6555B8202F;
 Fri, 23 Sep 2022 17:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F15C433D7;
 Fri, 23 Sep 2022 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663952816;
 bh=MXUJSh7a67zClSJcrIQ8uTLgyyJ6AiyBVSt6Oo0niKQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=L5ozGfX7+BnlhPf8kYmEvlTmsswimIsTUvxP0A7EOs5QLeAU7DTgyL556orPLCbSQ
 jWDSDsvBhmTH3Obu+8JS2+MwezNx17WrUScLZMuKMD+XWhecmwFmPDggjej9KMZvnX
 UWuHqm8QLARl6T/wfwagA01xQoUikW/w0GHMeRwpkbliaQn1Ch7Y/7FHDyWH/0Re1u
 BAAWQSdgKTny+VsvfMFMgNG+euMZ7dTZICI/UTRKqCw9E3up1m/hdqNDZX3Zz6SE72
 +2nPq0IsjkKHj1oSnBS4Bs7GbhOi45JXeystji3jfeCscFIE4hsbCNFzKSCiy/++ve
 RcTxQ5kODrJCw==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
References: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops instead
 of custom ops
Message-Id: <166395281428.610218.2692413378326164473.b4-ty@kernel.org>
Date: Fri, 23 Sep 2022 18:06:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
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

On Thu, 22 Sep 2022 12:35:02 +0200, AngeloGioacchino Del Regno wrote:
> It is possible to use the standard snd_soc_pm_ops for this card:
> remove the custom mt8195_mt6359_pm_ops.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops instead of custom ops
      commit: 14ed837b9740cc6ec25910980d67c22894b4ff56

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
