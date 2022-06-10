Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D571C43334
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 18:23:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46B7A1904;
	Fri, 10 Jun 2022 20:22:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46B7A1904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654885394;
	bh=+jL/FC6xNNAbT8Uw3SBjykGPd+t4UmekGOKQaiNQUyU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eynArtluGfHrUXa/yDvIqMtuL1qbUzm2wWQf189XBoCZ07y+z7TGihMgk+0ENaY2k
	 UWR1nt6fnM9kPc9p9Na/0UcAQb26tN2p6xmQ13H34RHHBAVBcU5izCh96+vvOqStZ4
	 FGecKy5Owt8NCEp2nAcnQgCOhkPdLXCHemrCcoM8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 425DDF80526;
	Fri, 10 Jun 2022 20:21:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4B3DF80515; Fri, 10 Jun 2022 20:21:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1E7DF800E5
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 20:21:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1E7DF800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HXdAhEg5"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B1D3C621CD;
 Fri, 10 Jun 2022 18:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D5EC34114;
 Fri, 10 Jun 2022 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654885288;
 bh=+jL/FC6xNNAbT8Uw3SBjykGPd+t4UmekGOKQaiNQUyU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HXdAhEg5WMuAU4u6m0swWeIb51mKl1BNq1Cn78ib1UmBgP7ti1+jCoF2n6gLD4b+O
 9OSAQVVvNb9j9tn0fnBn2MMyUvdJ0A8Yu6KUvTAGSXu/HeKT9TxhN9sStA9XXN6CEb
 SXsqSi7XTTrYiQsSr1+7O4j2dMaEolosG7xfEOlhljblbuEQ1wEQVemmN+U7xMqN4d
 mHO3LswenshdpTw1P/rBy7fA04jQl4tllJjx2+b2LcLAeb/F1W5HtDHyk2OvCs1OL4
 jSQ6y7RAAIMO3nXZVPNdN7v7NY2CZvGzZn7us4x7dsPbyL2eSjeDcPC1/T0H/FN0UN
 bnfCbfOvYjiiw==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
In-Reply-To: <20220610144818.511797-1-srinivas.kandagatla@linaro.org>
References: <20220610144818.511797-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qdsp6: q6apm-dai: unprepare stream if its already
 prepared
Message-Id: <165488528620.2064162.10605272639883600182.b4-ty@kernel.org>
Date: Fri, 10 Jun 2022 19:21:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, quic_srivasam@quicinc.com
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

On Fri, 10 Jun 2022 15:48:18 +0100, Srinivas Kandagatla wrote:
> prepare callback can be called multiple times, so unprepare the stream
> if its already prepared.
> 
> Without this DSP is not happy to setting the params on a already
> prepared graph.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: q6apm-dai: unprepare stream if its already prepared
      commit: 6548c884a595391fab172faeae39e2b329b848f3

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
