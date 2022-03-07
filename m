Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32435C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 20:42:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7490C17DB;
	Mon,  7 Mar 2022 21:41:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7490C17DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646685729;
	bh=RH4jSxBsE3z8+OBS4M+nam095nn+1JwbTE+qnLWrtBc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hBQpDnVLDJPQa0qx+oNvNeM7WB0SfJ4aPqts6Myfhot1K5hhPAMuG0AlQZTaDxJxs
	 OK/cKGU42jQL/8jsBeB7SwNonktC89rx75NrOmD21lP4t2mq5lp2Qnah6dZycSqVNZ
	 nj8y+ZkGy9UIix9A2V3PFSQ3d5gX/e8vTplDtY8w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C53AFF80537;
	Mon,  7 Mar 2022 21:39:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68CD2F80524; Mon,  7 Mar 2022 21:39:17 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0640F8051D
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 21:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0640F8051D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kgSbKeo/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D4C3D614C1;
 Mon,  7 Mar 2022 20:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60646C340E9;
 Mon,  7 Mar 2022 20:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646685553;
 bh=RH4jSxBsE3z8+OBS4M+nam095nn+1JwbTE+qnLWrtBc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kgSbKeo/a+DcIvwfAfn/WAXKPVU7RWhdibA3C9HDTylBQuI5HDFF3Xm3EuqrRnBOJ
 BiV3kS+AG/5K2mGOhAb98A71frTqV8V6fUNkgyEDySXeg1Db78z0iptE3qEsHZz6xI
 n79K9K6BITSgyodXCtsZY2NlLi6azu17wd3+bDCJuOghwqL7Si/c2Shw7ZJYPnX2TU
 JJi6uvixgNCgvOU8SFbRyDOt4cAHvCyLzehN2TJjeZ3pYBhZSZFawWTg+rfuTvu1Ll
 hqg4S/0cwTtAlMG0aGRG6Z7fxLFxmOmWTDdkfvknkK/7MdhpR53RzfAt92aGjGWifS
 bgBlhCsJUS4kQ==
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
In-Reply-To: <20220304102452.26856-1-stephan@gerhold.net>
References: <20220304102452.26856-1-stephan@gerhold.net>
Subject: Re: [PATCH v2 0/2] ASoC: codecs: Add Awinic AW8738 audio amplifier
 driver
Message-Id: <164668555106.3137316.5314190084666294576.b4-ty@kernel.org>
Date: Mon, 07 Mar 2022 20:39:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
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

On Fri, 4 Mar 2022 11:24:50 +0100, Stephan Gerhold wrote:
> This series adds a simple driver and DT schema for the Awinic AW8738
> audio amplifier. It's fairly simple - the main difference to
> simple-amplifier is that there is a "one-wire pulse control" that
> allows configuring the amplifier to one of a few pre-defined modes.
> This can be used to configure the speaker-guard function (primarily
> the power limit for the amplifier).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: Add schema for "awinic,aw8738"
      commit: b3284430615c27ca441967f99fbde957b434e092
[2/2] ASoC: codecs: Add Awinic AW8738 audio amplifier driver
      commit: fc14fac286a05d36202f8114d00a9935ca2e0756

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
