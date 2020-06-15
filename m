Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1FAC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 23:41:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAD5207D3
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 23:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M3YTpwLs";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xweG4/5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAD5207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 777721676;
	Tue, 16 Jun 2020 01:40:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 777721676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592264505;
	bh=oW9qoyqhic+SD36ZSuXB/Hfr7ESAOoH5X3cPqByf2gE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3YTpwLs+Et3X6zRGRhCADJImBzYa+4vjeui9PS4iajj/r1Cga/ei8ebbR7Ru+bKq
	 I25vHdlhQIX0YNVIPEO4plL2zBfeUm3qfJ2OooM6DnuNGJ/wl/c4cfeKirW4Z6UETV
	 oyyLeTCxrRREleskqld6wghrH9g4EYbIg6kd+Auk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40ABAF800CD;
	Tue, 16 Jun 2020 01:40:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEFB1F801EB; Tue, 16 Jun 2020 01:40:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D684F8013E
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 01:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D684F8013E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xweG4/5R"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 85247207D4;
 Mon, 15 Jun 2020 23:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592264399;
 bh=oW9qoyqhic+SD36ZSuXB/Hfr7ESAOoH5X3cPqByf2gE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=xweG4/5RS2Z5RSPt9NqYbAjZ2KcUXpz9SzEjlwUFVfNpY1azZVLedvt0/CErz3I6D
 dC6NMaR3snwd5gUu8ZMwFzyUPJabHjuKwwEZ3Or07gHVchDm7BNhG+MaR7QY7tHTRh
 S9Ydlo/Sdbnvxc962bHmU9f/FZCVR7dzkzqc3Nfc=
Date: Tue, 16 Jun 2020 00:39:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87v9k7w90s.wl-kuninori.morimoto.gx@renesas.com>
References: <87v9k7w90s.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 00/12] ASoC: soc-component: collect component functions
Message-Id: <159226439189.27409.6970843975826387921.b4-ty@kernel.org>
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

On 04 Jun 2020 17:05:39 +0900, Kuninori Morimoto wrote:
> We have soc-component.c now, but still many component related
> functions are implemented many place.
> This patch-set collect these into soc-component.c.
> 
> v1 -> v2
> 	- remove soc-compress.c exchange
> 	  (But I have plan to repost it)
> 	- fixup loop break issue on some functions
> 	- direct return on some functions
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: soc-component: add soc_component_pin() and share code
        commit: 4ca8701ee3106943c84d011c86a7ae41aff72e17
[02/12] ASoC: soc-component: move snd_soc_component_xxx_regmap() to soc-component
        commit: c7d75b5938e38a48e5fdac44f88fc5882f1f7bed
[03/12] ASoC: soc-component: move snd_soc_component_initialize() to soc-component.c
        commit: 536aba1dd4939bf647f5d182d4f101ae548e6505
[04/12] ASoC: soc-component: add soc_component_err()
        commit: e2329eeba45fdad5eeb2bec5c61f8cefbee69cb8
[05/12] ASoC: soc-component: add snd_soc_pcm_component_prepare()
        commit: 4f39514f36980a4b20a754a5d51486a5999c8380
[06/12] ASoC: soc-component: add snd_soc_pcm_component_hw_params()
        commit: e1bafa828e3a0622ac24d238e00937f3059ed585
[07/12] ASoC: soc-component: add snd_soc_pcm_component_hw_free()
        commit: 047511198639649bdaacb1a34d9691429ccc5698
[08/12] ASoC: soc-component: add snd_soc_pcm_component_trigger()
        commit: 32fd120475c1b8a83d28bfedc2b95ec981fbb809
[09/12] ASoC: soc-component: add snd_soc_component_init()
        commit: 257c4dac8b7877c865e734533b5f62769c64afb6
[10/12] ASoC: soc-component: merge soc-io.c into soc-component.c
        commit: 460b42d162e3cf634586999e6a84e74ca52e626d
[11/12] ASoC: soc-component: merge soc_pcm_trigger_start/stop()
        commit: 836367be289d5b130769fd7c46172557e614a148
[12/12] ASoC: soc-component: tidyup Copyright
        commit: 45108214dbfdba4a07061d2a4db6dc12475049f2

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
