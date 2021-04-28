Return-Path: <SRS0=9FQT=JZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07791C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 16:56:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA0761400
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 16:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA0761400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EF1716B8;
	Wed, 28 Apr 2021 18:55:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EF1716B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619628979;
	bh=nND/xfSmX/UqvtzYePF0IuTSQeilZFs3wozWSV4iruw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wts2M35SqgFYkuFv2QNUqdHcA702qeBMgxG9gIwfjLHY5ImTpPNsYgKpYbUimv1F7
	 Hzzr0ilXnpGzd6JK+08IYc/z/+T4/cI7zQRD85FevaDLSutgcBMQsZrEliYyMWVYvQ
	 vtT9CG8hwi227h174FK3gHl3/34invthbJBVMdMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61423F802E2;
	Wed, 28 Apr 2021 18:54:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16558F8032D; Wed, 28 Apr 2021 18:54:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01B6CF8029B
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 18:54:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01B6CF8029B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="o1hCPYvx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE79E6143A;
 Wed, 28 Apr 2021 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619628869;
 bh=nND/xfSmX/UqvtzYePF0IuTSQeilZFs3wozWSV4iruw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o1hCPYvxEzcYEEHlTK/rAPMbebjajH53GxQYhrf5Txe8f9yv2j9ilIQ5EFvgZ/XhG
 ExwLKEnPl+q0ZyPGqXIP4dT7BIShG4wUC4ASbkaGXUY9kl8C5+RWLYH85pAz88KY2Y
 Eo0YsZ24KRQcNmuwFL5S82G5X0K6N2PLZucGXAURkDNgP9tPz0pvjnvH/4qyw1GxI/
 0gOSXLOkT6LZUC2q+0XnRWNkyPD48v0l1gpDx46RrTb90sTrFG2+SOf4eCNJ2DkCMN
 VyVyRJz55oQ2KrFwVWFrpzznuvH/EOvUB6GI3EDqSS5d+Hu0Zqe1ZWj/UPxVu8lu3w
 FBcC0+pleo00w==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Marco Felsch <m.felsch@pengutronix.de>,
 tiwai@suse.com, perex@perex.cz, kuninori.morimoto.gx@renesas.com
Subject: Re: [PATCH] ASoC: max98088: fix ni clock divider calculation
Date: Wed, 28 Apr 2021 17:53:45 +0100
Message-Id: <161962856273.49583.7584291336145398688.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210423135402.32105-1-m.felsch@pengutronix.de>
References: <20210423135402.32105-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 kernel@pengutronix.de
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

On Fri, 23 Apr 2021 15:54:02 +0200, Marco Felsch wrote:
> The ni1/ni2 ratio formula [1] uses the pclk which is the prescaled mclk.
> The max98088 datasheet [2] has no such formula but table-12 equals so
> we can assume that it is the same for both devices.
> 
> While on it make use of DIV_ROUND_CLOSEST_ULL().
> 
> [1] https://datasheets.maximintegrated.com/en/ds/MAX98089.pdf; page 86
> [2] https://datasheets.maximintegrated.com/en/ds/MAX98088.pdf; page 82

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98088: fix ni clock divider calculation
      commit: 6c9762a78c325107dc37d20ee21002b841679209

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
