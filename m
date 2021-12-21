Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B1FC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Dec 2021 19:15:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB94B185D;
	Tue, 21 Dec 2021 20:14:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB94B185D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640114113;
	bh=zgeZRVRuafwQrEQMbJc8CNZl8kFQYTvPQfyRtjn3/VM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CovJGngpjd8S+XbACSM16+KORtmoRARvlDv2sMqLZpsZJsuu3q8SbFKSKQ4A/nzH4
	 lUya5FJa+DAmqWIRAoH/0tt2SQZpN0eNANSik8pGG2pNEusfmukXLMuaRgC/JcBlue
	 2XDnqp72kOWEvGx33jqdVfiri4qBkBUrFc1mNk9M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 122F2F80515;
	Tue, 21 Dec 2021 20:12:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDFB0F80507; Tue, 21 Dec 2021 20:12:52 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D24EF804F2
 for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2021 20:12:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D24EF804F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YxKHvZ4i"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7599B6178B;
 Tue, 21 Dec 2021 19:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D9FC36AEA;
 Tue, 21 Dec 2021 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640113963;
 bh=zgeZRVRuafwQrEQMbJc8CNZl8kFQYTvPQfyRtjn3/VM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=YxKHvZ4ib1x6Od9tHuokB1h1qHxqybGhoN7wyIAgjd0TcnUx8xrR180OnZGIqNbEG
 uK+Eyyhyt58sG8LmjJCUqzSFxRImuHJAm/0mrAvSLMSgiXJbOn20qOmKKU/Txs7LAc
 77n+KrSKhsBmM0qegALj+df95fCBoYZTSAh3qj6e3krHmW9V6itRJwfO/pTO++I/4M
 iogMmDPv71uSgy21Ci89XQtVGMaxWikwskmkUg5Pr4UZuXTftki+arO2kEFaJmXyRN
 Wifkrc08Ns4AtDn6NTnFtpzaoAlSDo8x48yBl+biBThOlMfa2LvdE0Dvbu3phCXuRG
 WPcRs34/YYGJA==
From: Mark Brown <broonie@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
In-Reply-To: <20211217150007.GB16611@kili>
References: <20211217150007.GB16611@kili>
Subject: Re: [PATCH] ASoC: qdsp6: fix a use after free bug in open()
Message-Id: <164011396113.93163.3445360337147394616.b4-ty@kernel.org>
Date: Tue, 21 Dec 2021 19:12:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Fri, 17 Dec 2021 18:00:07 +0300, Dan Carpenter wrote:
> This code frees "graph" and then dereferences to save the error code.
> Save the error code first and then use gotos to unwind the allocation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: fix a use after free bug in open()
      commit: ac1e6bc146d45e15f0a5c0908338f918f6261388

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
