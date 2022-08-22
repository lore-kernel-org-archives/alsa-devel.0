Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3331AC32772
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Aug 2022 14:25:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE12A16BC;
	Mon, 22 Aug 2022 16:25:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE12A16BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661178356;
	bh=PiktLoy2IS2EfJ927VEsYS/q/dcy6NlvZDENwVBGB5w=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mZZW52mhZJvhepfGVh7fqPAGd9X0Oz57tWs+MBnOl7ddknACdJ4wANRmiUE/jjIZ3
	 OrBTeaCDt1+GkEg5Ah76YRs6xrcmPkSIs7eiPeGcbBqR0/0dyAjWI8G6aNKqlkh8lt
	 jQB7YcNPQJgrL7w1ZRiTr2uI8QQ3g+cRjFltgxks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91385F800A7;
	Mon, 22 Aug 2022 16:25:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48979F8026A; Mon, 22 Aug 2022 16:25:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D409EF800A7
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2022 16:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D409EF800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QrLNpasp"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C6E1D611B4;
 Mon, 22 Aug 2022 14:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76526C433C1;
 Mon, 22 Aug 2022 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661178296;
 bh=PiktLoy2IS2EfJ927VEsYS/q/dcy6NlvZDENwVBGB5w=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=QrLNpaspeL5WMdkHA6jOAuKWgVw6AhxGf7tvw7BFaQKSi5e39Y64Djfshm6Hd7R6V
 qjMKDcayPGV/zSVRoM0ycZEgEMlnq3oxrz2B2uo2IhOQRCnBD4dCg+03+YEO9BCVTC
 S1TF4oSRjiix1IBqYBB2lYLIpgvQN7gful9RrCpxu3LO/euPnX7ESoRyRWagLU0/Os
 w0rRFOOwuegGf6D2GvTuTLATG29byW+WMjKLMGi+EtPGzc4LDEp3WdCq51sNbMSy4N
 J7nJcovexmOE21p4iydqe3JWbvGvT4xrZHI9fYbPC0n667UQn1A5e6t9Rd06Ip6ngB
 T+vcq5dDUmLVw==
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>, angelogioacchino.delregno@collabora.com
In-Reply-To: <20220820071925.13557-1-jiaxin.yu@mediatek.com>
References: <20220820071925.13557-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: fix DMIC record noise
Message-Id: <166117829418.94797.5869443265207499782.b4-ty@kernel.org>
Date: Mon, 22 Aug 2022 15:24:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 chunxu.li@mediatek.com, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
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

On Sat, 20 Aug 2022 15:19:25 +0800, Jiaxin Yu wrote:
> When the first DMIC recording is power down, mtkaif_dmic will be reset.
> This will cause configuration error in the second DMIC recording. So do
> not reset mtkaif_dmic except in "MTKAIF_DMIC Switch" kcontrol.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: fix DMIC record noise
      commit: 221ab1f0bf46236cf1a3fef5298ff5894acfb0c5

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
