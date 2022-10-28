Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAB4ECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Oct 2022 16:04:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21D501EE4;
	Fri, 28 Oct 2022 18:03:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21D501EE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666973050;
	bh=wNXKotwuuxgi6yUVKqYwBdPAK78kh9kgseKN/VlZMsQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d+wWZ+AMxK8GngpvaRh+x7O8idnb/9qONhW2BPrXXPqQNx948PAnvMqg8Z8mOSVhZ
	 apewZwOrp/nvC0VmIVI1hu8xtogCIbeMjqdydGVj2oj/c5dEsOcQgG/61qnU3yU9ts
	 /yb8eBEdH2vxCyA/qyJOWYmxOkd+S8aVvgL4pH9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17A52F804BD;
	Fri, 28 Oct 2022 18:03:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26D7DF804DF; Fri, 28 Oct 2022 18:02:58 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D954BF8025A
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2022 18:02:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D954BF8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QoMxNCkb"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0E78CB828F7;
 Fri, 28 Oct 2022 16:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C60C433D7;
 Fri, 28 Oct 2022 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666972973;
 bh=wNXKotwuuxgi6yUVKqYwBdPAK78kh9kgseKN/VlZMsQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=QoMxNCkbqCrOrhXaqnGoLA1VvcD3H75wwfwDf4OmM04KM6glN09KDgQGZ12VkVQVW
 DL+lkbzixjKEznebXjDlvZtDbvqWfHPChXvnNfsQokZPKiB/wg9z0EAZ/GcAeWvTE5
 ySAgSvhMx8cATgMQ3GT/8UMaFY0q3usVtI3roTXE5Un6D21+Ny0cZUDFhLJ3JLP+XU
 5sc0suRcC57UX4gv45jaHbE1WVkH5UN81F+xxVhy2mTRtU/NwE+FJ/wGTVooHxJnaL
 Kw1W3b9ac5bff3ZNOX9/KOwbj4mNNVxaufY5KHuEJMgVtjXHPLemjuDMJbhNzR+dZU
 RMNwt01hsnRLA==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 lgirdwood@gmail.com, Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
 alsa-devel@alsa-project.org, perex@perex.cz
In-Reply-To: <1666940627-7611-1-git-send-email-shengjiu.wang@nxp.com>
References: <1666940627-7611-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Add Counter registers
Message-Id: <166697297135.717517.11089794085800695281.b4-ty@kernel.org>
Date: Fri, 28 Oct 2022 17:02:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Fri, 28 Oct 2022 15:03:47 +0800, Shengjiu Wang wrote:
> These counter registers are part of register list,
> add them to complete the register map
> 
> - DMAC counter control registers
> - Data path Timestamp counter register
> - Data path bit counter register
> - Data path bit count timestamp register
> - Data path bit read timestamp register
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Add Counter registers
      commit: 107d170dc46e14cfa575d1b995107ef2f2e51dfe

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
