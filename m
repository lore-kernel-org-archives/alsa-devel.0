Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6401C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:56:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F6464DD6
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F6464DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 585DF1695;
	Thu, 28 Jan 2021 21:55:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 585DF1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611867407;
	bh=1tbtuFQkxbc4ZnV8cTnHuV1+0RiZFgiK3PLGpUTpqzY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QsyMZJZyj9OTzXyRR36DtnvA0FZifKJ7bl0ImhYbl5upvldJgno0nQqGhAJk4QfWn
	 4ZxMtRrga/NxZM8u2/nfUod8e8Xoqrx4PPscB6zPBl9EwON3Wz+M3jid+w+B8gXM0X
	 Gsz8dtw2mrHohAtyb5keIUThjIQFkokQWpvHdHFw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F12CF801ED;
	Thu, 28 Jan 2021 21:55:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5F7EF80217; Thu, 28 Jan 2021 21:55:28 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3A69F8015B
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 21:55:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3A69F8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T8GRz5W4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F41F64DD6;
 Thu, 28 Jan 2021 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611867321;
 bh=1tbtuFQkxbc4ZnV8cTnHuV1+0RiZFgiK3PLGpUTpqzY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=T8GRz5W47Ps3HktkyrIxm0ogPUgwEeF57co8nvyKTuWV4GLA6SuVYJfOCAfUz7lkP
 37fR6EkachvJP8xeJNwWF3ZsMNpTcIMPX/nIbQx6GRgIGeDguB5vKcdC60fq7BZDa5
 Vpxn8N+ZDSIza/Syw4SKvrGRlaf4jDAhFet+sfTR5lZclHYTkDwhUh7TZH1EkF736V
 fFoVrogFxTQ27HHzICx2jY2t69R1xzJRC2v7+ZtDTnqsBJM/eD+1ezxg5xurdyjA/5
 YN0OfrUeCl6ZYKIPJ1zY7eHkGrAn5/DF31FCAQU6so5jspaToAaceVSqsGMO/0vp6K
 Y2fKp+tR1XUFA==
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20210128093850.1041387-1-kai.vehmanen@linux.intel.com>
References: <20210128093850.1041387-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC: SOF: use common code for DSP core pm
Message-Id: <161186727763.43763.5863459561857832758.b4-ty@kernel.org>
Date: Thu, 28 Jan 2021 20:54:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com
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

On Thu, 28 Jan 2021 11:38:45 +0200, Kai Vehmanen wrote:
> Series to refactor the DSP core management:
>  - move tracking of powered up DSP cores to common SOF code
>  - add logic filter unnecessary power actions
>  - modify existing implementations to use common code
>    whenever DSP cores are powered, so the state in common
>    code stays in sync
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: SOF: Intel: hda: use snd_sof_dsp_core_power_up/down API
      commit: f6c246eacb62977dea5c9c65ac6fb4921cad5bcd
[2/5] ASoC: SOF: Intel: hda-loader: keep init cores alive
      commit: cedd502d18b5b7a913fa13fa18a037cc51b1798d
[3/5] ASoC: SOF: update dsp core power status in common APIs
      commit: 42077f08b3f1ba891dca1f8f479810f16b7d6cbd
[4/5] ASoC: SOF: Filter out unneeded core power up/downs
      commit: 30876e2a06f35b525dc71f94dfc3c6f329e55a28
[5/5] ASoC: SOF: intel: hda-loader: use snd_sof_dsp_core_power_down/up APIs
      commit: 92c6ec606cd12c16091b70442da536bdeddb1f7f

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
