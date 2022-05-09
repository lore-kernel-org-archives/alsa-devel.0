Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F925C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 18:48:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F03A16CA;
	Mon,  9 May 2022 20:47:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F03A16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652122128;
	bh=DKJGzDgq2zEzBcaxaB50Lm2Yu0SyjRtR0HtJjptHOjU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LE2P38cANYmITmNBrfrmG32QVZirFrVQlK5AYgW0FSgCA8ewE/abWvtSW+lhY980k
	 iB7otOJYPpNRrdU90IVVe6cSi9Q+kMAFNVulUTJPXa6eFtRr2qXhxj7QG17/GUoPu2
	 MqcjpdmqD9v4zs0DSQbqbBzu9esd45VJ9u0NoOPY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2438F8047B;
	Mon,  9 May 2022 20:47:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 980BFF80269; Mon,  9 May 2022 20:47:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A12BF800D3
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 20:47:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A12BF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IKLObn96"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 59EDB61653;
 Mon,  9 May 2022 18:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09914C385B2;
 Mon,  9 May 2022 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652122036;
 bh=DKJGzDgq2zEzBcaxaB50Lm2Yu0SyjRtR0HtJjptHOjU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=IKLObn96uDGtISHxEaaL4g7d5TaZBNl7cNy9osOIYhqpBMDZYY8DmST6Yvn+LiLVp
 ZK5r3oZStAd5qsORPeAg/PFnH9enWAxyDbHyUZmbUIjjlSKO6oldQ/7dAUiKiuFAWe
 7Vhg/sSN6SGnEjQkYiIGeZsMwxtUTWC18Xsgk9REZTbd0Pg5s3TaAE0IJdvM4dCNff
 /r7cSBH8tSxEdjVB+6XxNUVle7tLJ/UbTpXVN+0BNuHaM8iDnPhn2IDNPKgNDnH4Gh
 S/DKK6luJiL4/ec+H401pP3FYYqjVa6niCcgnX5y/aaRRHnhnCWUePe4xWk9k2oD4O
 XRCWOmUetrXOg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, rander.wang@intel.com, peter.ujfalusi@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com
In-Reply-To: <20220506130229.23354-1-peter.ujfalusi@linux.intel.com>
References: <20220506130229.23354-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: trace: The dtrace is only available with
 SOF_IPC
Message-Id: <165212203473.1274938.11694837063848621577.b4-ty@kernel.org>
Date: Mon, 09 May 2022 19:47:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

On Fri, 6 May 2022 16:02:29 +0300, Peter Ujfalusi wrote:
> Currently the dtrace only supported with SOF_IPC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: trace: The dtrace is only available with SOF_IPC
      commit: e813526e5535ab009e2550e1da63abf297e1af68

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
