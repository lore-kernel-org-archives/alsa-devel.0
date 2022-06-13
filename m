Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B71C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jun 2022 16:08:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13B611734;
	Mon, 13 Jun 2022 18:08:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13B611734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655136533;
	bh=eLZFf8N/SxgvHhFTsPd4BAWKftJpjIdWm3a/UFZt56E=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QMUcGGXSzDjcfaDAurW6LfwDy8lpd91dktOPlpaXPbdpxk+d1QGQh+v2phvOJXMIp
	 tH6EGpL4/TesdcIQt+bElumDhaZ/lItqxgH1NKEtmYYK6EBmUqe7GzojwiMxhyMlDO
	 IWXQj0Kwfq5ywc4jPcjMLIRCVE41Idb9tYYE7fZw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 888AFF804C1;
	Mon, 13 Jun 2022 18:08:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB935F804D1; Mon, 13 Jun 2022 18:08:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74915F804BB
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2022 18:07:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74915F804BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UeUg7L1U"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B8EA661522;
 Mon, 13 Jun 2022 16:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9DEC341C0;
 Mon, 13 Jun 2022 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655136475;
 bh=eLZFf8N/SxgvHhFTsPd4BAWKftJpjIdWm3a/UFZt56E=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=UeUg7L1UWm96GBKgOQ321G3oh3rL5PsBtV2QKu7C7lZvy0xwvGkd8MTs9Kuv1635q
 UkU/1c4ywSl+B5iGPDfmRMSiI/j8sWnY10Uzyk3u0jV4JUB6b21q0beEEGf5sj0eRU
 di24K6K1rA0dEUoCe16hZ+hlxkEpH62CuQxxk2DUUMxgK8VzrtoiYjsJfze9clbIBV
 nkl/yu+SXxNYds/IzuXFYLfdBaA0Ig76Cw0uyKokQSUjB8/UpWQaiKvjD3mq3LptpJ
 3UxWlxgUJtEq56qJcvkfgr9TPo8hfvgfWOwwN/tpCZFHpfXJi9S4y7IwkRUL3bx1CC
 4spW8wpGvK/AA==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org, broonie@kernel.org, lgirdwood@gmail.com
In-Reply-To: <20220603124609.4024666-1-broonie@kernel.org>
References: <20220603124609.4024666-1-broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wcd9335: Fix spurious event generation
Message-Id: <165513647404.514792.3630831012367606283.b4-ty@kernel.org>
Date: Mon, 13 Jun 2022 17:07:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Fri, 3 Jun 2022 14:46:09 +0200, Mark Brown wrote:
> The slimbus mux put operation unconditionally reports a change in value
> which means that spurious events are generated. Fix this by exiting early
> in that case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Fix spurious event generation
      commit: 6bda28a2f7113b1c49eb05155ace02b75bccae7b

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
