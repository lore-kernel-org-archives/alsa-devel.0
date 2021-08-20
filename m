Return-Path: <SRS0=b+Zg=NL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832A5C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Aug 2021 14:40:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F9A61131
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Aug 2021 14:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 84F9A61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9806C1614;
	Fri, 20 Aug 2021 16:39:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9806C1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629470448;
	bh=0xLUIq3Z7VXfpnT7QH9mKB5yupvV+kR+aDBxMjCCqNU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MNoniSZ2ShhrSDwTd6JBm53/XB+OmBOQs9QVVKpqDzw7NTLyU3wbPL72hqG1GCiLT
	 TlWDP4NRQD1v+8M6XqU8v3+wJJpCX+TJLEtXWwqQn8PPeZ7E8pfGKjP8QDmZZ6HmbJ
	 4pEv85f/R/LJNitWOHS1jz4oAUiMUxSmKlN8yEgA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34931F800CC;
	Fri, 20 Aug 2021 16:39:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78358F802BE; Fri, 20 Aug 2021 16:39:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B336F80246
 for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2021 16:39:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B336F80246
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PbpbvYH3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A52C66113D;
 Fri, 20 Aug 2021 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629470386;
 bh=0xLUIq3Z7VXfpnT7QH9mKB5yupvV+kR+aDBxMjCCqNU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PbpbvYH3rzAt76mN9WgxKV5hK+gpmXXdqACUmVjOH1vjZzDUoj3awT9foU6EnhWhK
 /OtL24RcL2YD/KyPc8ALVpIvdW0wIAqR0rfoWos9jB41MHmGIpgw8+0vlg5HHcKLX+
 RcNggwNLuu2mR72rwE/3yx/lAB5QMp9eARp010xTypw4vwCJTsdGhgZweKT4QHmh7/
 BBb6MzWrELj2F7rfbPqrxx1An9zAe9tO7YsuNI9M9OGUq2w39YvT/NmQm9edQyKc8m
 vxJyBLq1n2G9yGmG1+VoGgm0+92GHHeN6vi4v78IOJ4rCcFVA32RdFVhyGEGBR5Iii
 0GLlkYu7VL+gw==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: adg: clearly handle clock error / NULL case
Date: Fri, 20 Aug 2021 15:39:12 +0100
Message-Id: <162947011160.28998.589558690156326062.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87v940wyf9.wl-kuninori.morimoto.gx@renesas.com>
References: <87v940wyf9.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On 20 Aug 2021 13:08:26 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This driver is assuming that all adg->clk[i] is not NULL.
> Because of this prerequisites, for_each_rsnd_clk() is possible to work
> for all clk without checking NULL. In other words, all adg->clk[i]
> should not NULL.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: adg: clearly handle clock error / NULL case
      commit: cc64c390b215b404524725a94857d6fb58d9a62a

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
