Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61B7C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:18:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B40A60F4A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B40A60F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0B4F18B6;
	Thu, 16 Sep 2021 17:17:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0B4F18B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805524;
	bh=z+Swu9fngnnny68fKhXP7hyNI5xiB/rDMvMz/SuSfhY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EbrEobt5F62MYpTENIbdXmex6f28/065WBonFZyMIQcCg3EF060HLz2xF5lrBb4Wh
	 infJLI127b4F8QDSyfNIJNSQNQ+Yxg++ElTAk70hZoNOrUexYgWi+tsPl95T03Oz1Z
	 lOTDNj2wPlZ17F+3SvqgCnJ5hVcUGkAfTGybsIXs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E29EF8050F;
	Thu, 16 Sep 2021 17:15:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF765F800D3; Thu, 16 Sep 2021 17:15:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DA2BF800D3
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:15:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DA2BF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pQFOimdh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27AFE60296;
 Thu, 16 Sep 2021 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805333;
 bh=z+Swu9fngnnny68fKhXP7hyNI5xiB/rDMvMz/SuSfhY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pQFOimdhyJVVJu78eO/GPWfDdS+/6s1gKoW9iYVyGMgeZyUSn/MOpt24rordiG0FA
 Aga92tZi66mOrh7brYFIVfEYZW0toT4C9KtI8ghiuC1u1JFcZrUhMyUW8zjXuJPy/M
 aEQrVO+5auuHCsYMw4L2FnfDtxHWrPvYJGjwa3UDe3BjGCw7q1+xM5cGkXum3Dz6CJ
 Y5ybWs1mmce1plCz2XZL45OnHECxdraCCLfgxsNGI3v8LsqcRz+1qOBzhUNrqgly2X
 Au4SCnyHAGJjOzEFmDIw7Zs9ZsCldh4+IYyZwvW44po6+nYp6K3gC+5R7IFRHJ/5JE
 hvGwi3IchLnAQ==
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: imx8m: add SAI1 info
Date: Thu, 16 Sep 2021 16:14:34 +0100
Message-Id: <163180495858.19842.9823230293550684001.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916073725.359561-1-daniel.baluta@oss.nxp.com>
References: <20210916073725.359561-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 ranjani.sridharan@linux.intel.com, Viorel Suman <viorel.suman@nxp.com>,
 Paul Olaru <paul.olaru@oss.nxp.com>, daniel.baluta@nxp.com
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

On Thu, 16 Sep 2021 10:37:25 +0300, Daniel Baluta wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Add SAI1 instance to imx8m_dai array.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx8m: add SAI1 info
      commit: 243442bcd98f11e21d9827c06a995acf9a6ddead

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
