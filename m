Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1283C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:56:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24F161004
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E24F161004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 635711670;
	Mon, 13 Sep 2021 12:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 635711670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530581;
	bh=Q5absrfI8fHZmSEfHakac+PXQAsMu32YZoq5qrmLeys=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nTcay4W8WRaq5zqnBa+U62dpe9BuepVYcgOxNPX7JX/kmB+EJNBqL7a7os5Fkglis
	 LdkABAfBsOaG5RPvVIbQRTCoytHcmsDo6IAn7nyq61zKrwtm1jmOAx+oy0CHPqR/jJ
	 VEcRvPon555qUkHe49m/TIw0ylMjey8VY6CWdnlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 587CCF804E3;
	Mon, 13 Sep 2021 12:54:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EE8CF804E3; Mon, 13 Sep 2021 12:54:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E59E6F80227
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:54:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E59E6F80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UDOepgP+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43B4661029;
 Mon, 13 Sep 2021 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530476;
 bh=Q5absrfI8fHZmSEfHakac+PXQAsMu32YZoq5qrmLeys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UDOepgP+ODy7eZvGNENXCoQwDdGg6kheBSQPfhONr0B0b7QTw5Qz4Ocft1Ar4LYa4
 ROySD8uvn36VtEpTpVBh6gH26ysvWys/SpMQNAPfEOiS2xvd2QCX9hwjunkr1kPZEw
 HG0mS9A1jMwvwHhpQJGSptOLIL4hwAFGc6P4NA6el5Wr3no488LG+EQvM/597F9sV+
 LoL5zpNAaYzBlxPJJCWcVP6l0OPGyYbC9AAGDdCEw5wakWFjf5NUSXhLx9DuofLLh5
 UrfmBvTkepN0EO5YuQ90Fd+Zo5mfE0Jx1BE2CSNADe4QLlmSYNzeStZjnJfCzOPdfK
 GKUlC/DkInPwg==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: amd: acp: declare and add prefix to
 'bt_uart_enable' symbol
Date: Mon, 13 Sep 2021 11:53:15 +0100
Message-Id: <163152996585.45703.10982811041582304324.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210907184216.33067-1-pierre-louis.bossart@linux.intel.com>
References: <20210907184216.33067-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Chuhong Yuan <hslester96@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Gu Shengxian <gushengxian@yulong.com>
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

On Tue, 7 Sep 2021 13:42:14 -0500, Pierre-Louis Bossart wrote:
> Sparse reports the following warning:
> 
> sound/soc/amd/acp-pcm-dma.c:39:6: error: symbol 'bt_uart_enable' was
> not declared. Should it be static?
> 
> It's not very good practice to export such symbols that can easily
> conflict, add the acp_ prefix and add declaration in header file.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: declare and add prefix to 'bt_uart_enable' symbol
      commit: 198433023ef962b71f3d4274ca7a4c8f04e7ace1

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
