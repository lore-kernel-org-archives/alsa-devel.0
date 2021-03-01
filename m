Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A79CC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:42:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F2D60232
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F2D60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA77016A1;
	Tue,  2 Mar 2021 00:41:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA77016A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614642152;
	bh=Var5V4UX8ayY2DMJvUyh2FLgHVRopIc0hWgIqgBnnuY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PnN+yHm4uQFyax9XrfuYrO2E/8n1jG6AQg36b+rb70ud9w0lMIObZmWI65KnSf3mj
	 0QL77r7CRz/3SSV0eHE3eta1NCV5VsMvYWhtvvbWl2PBEizejKoyASnzQGfAe20QaG
	 6t4xIESWCkQHpPmYXq2jAlivPl6Sh/jmHO0XPLkM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E243AF8050F;
	Tue,  2 Mar 2021 00:37:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EE86F80510; Tue,  2 Mar 2021 00:37:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0079FF80507
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 00:37:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0079FF80507
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HfWETuDG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A36C614A7;
 Mon,  1 Mar 2021 23:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614641823;
 bh=Var5V4UX8ayY2DMJvUyh2FLgHVRopIc0hWgIqgBnnuY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HfWETuDGAvVL8aN/yP/lgZrARU16kWUWcYn89NIt3V9KhvwhYbkQ2uu46g4yJEDiM
 WNSY1FR/CfEQMB05IQyfuE05uxon+sbQQCW83fzMs5JAj5z3ONTny68qm5JCUGYqUs
 n5bTeYAEBZ+X/fulMYETTU4Fz5Pdvx1DB+wb/pujFNMAJkj3JeEKYFyPB0kkvFIaGw
 XTc3rnsf96RU9mZbxgJWlgRAHnfDn1g8gDvweZ3oc2Yj15kd/anl6z8I07osTw8yT3
 LuIijav01DCjv8Zo+k6FTg+vIS1RizG1YKale28qx0MWgVwdaLerHzU04frToGmwi7
 lAycmFW0Il7DA==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87tuq5vsin.wl-kuninori.morimoto.gx@renesas.com>
References: <87tuq5vsin.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/5] soc-pcm: tidyup snd_pcm_hardware setup for FE/BE
Message-Id: <161464168098.31144.7087379834488958018.b4-ty@kernel.org>
Date: Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On 22 Feb 2021 09:46:24 +0900, Kuninori Morimoto wrote:
> These patches tidyup snd_pcm_hardware setup for FE/BE.
> [1/5] changes behavior, but I think it is bug-fix.
> 
> Kuninori Morimoto (5):
>   ASoC: soc-pcm: remove strange format storing
>   ASoC: soc-pcm: unpack dpcm_init_runtime_hw()
>   ASoC: soc-pcm: add dpcm_runtime_setup_fe()
>   ASoC: soc-pcm: add dpcm_runtime_setup()
>   ASoC: soc-pcm: unpack dpcm_set_fe_runtime()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: soc-pcm: remove strange format storing
      commit: bae5b4aff2ddb784a536f1960ce415ac5c1ceed8
[2/5] ASoC: soc-pcm: unpack dpcm_init_runtime_hw()
      commit: 75c4b5945d017d4c3beb892a58498202a23803e9
[3/5] ASoC: soc-pcm: add dpcm_runtime_setup_fe()
      commit: 9337e738b96d37de3afa3333961a2af4a2b1dc9e
[4/5] ASoC: soc-pcm: add dpcm_runtime_setup()
      commit: c813f6ed347cd610c239ff8027e8f403cd193648
[5/5] ASoC: soc-pcm: unpack dpcm_set_fe_runtime()
      commit: 6503916cefd802994870fe1e7cc6ad282549139e

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
