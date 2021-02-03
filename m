Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2E7C433DB
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 21:09:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A0861477
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 21:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A0861477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 721F716CF;
	Wed,  3 Feb 2021 22:08:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 721F716CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612386536;
	bh=+rn0LCbLBO+fOUWb59umUhA0fyCXbMfXrEtASG0C1bY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zr9NuaMosnAiEWa1vUD8pj9vZWKfyTpygEdQZDnaPcgTksaC1IJjdXrHzMm51CQP1
	 9uilIZnUH9oatXD3xLv716a6USRWptImVOeDgHM5U9sT5uAtS3XezwHFpdxZgQ0Bnl
	 K4mvjov5OhMinLuSls/GC7X+Cpux9Y4vPz9ZUklw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D172CF8015A;
	Wed,  3 Feb 2021 22:08:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D67ACF8015A; Wed,  3 Feb 2021 22:08:03 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DEA9F8013C
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2021 22:07:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DEA9F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Amk47k4q"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E37D461477;
 Wed,  3 Feb 2021 21:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612386475;
 bh=+rn0LCbLBO+fOUWb59umUhA0fyCXbMfXrEtASG0C1bY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Amk47k4qHIGFt0jKgqcDoXtxRCPaln1MUu5kfVAkIRn5oG2zFjTRhCjR/LCLpihE6
 HGIEc5tpbhClmW02frndgsHjxSu4j+ePmR/BmsV1lCNWXSfhk8faHXOfw81EAkMHgG
 tiX/ThYhI1c1WOjq1ZquThpz0rMXuXRBBMdn/Iz30rk/D/w5dW1HhB2VNE6TF0kGI7
 +6yq1sEzQihFc+9Vi6CHz+3vakM71bTb3UmWq/PGo4MAvgB8sEpJq/mXpYNwzZVoOE
 7u14tOrls6qWdsy364XyjYuM2qXn8K+fHRYYKVkqoyQLEPLHJtvdHmwpkeKfqYUQOF
 gkzHIaNlQ6k4Q==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a6t1aihl.wl-kuninori.morimoto.gx@renesas.com>
References: <87a6t1aihl.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/5] ASoC: soc-pcm: cleanup soc_new_pcm() and bugfix
Message-Id: <161238642667.34424.351766395973652443.b4-ty@kernel.org>
Date: Wed, 03 Feb 2021 21:07:06 +0000
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

On 22 Jan 2021 10:13:04 +0900, Kuninori Morimoto wrote:
> These are soc-pcm cleanup patchset.
> 
> 	1) - 3) : cleanup soc_new_pcm() function
> 	4)      : cleanup dpcm_runtime_merge_xxx() function
> 	5)      : bugfix of snd_pcm_limit_hw_rates() order
> 
> Kuninori Morimoto (5):
>   1) ASoC: soc-pcm: tidyup pcm setting
>   2) ASoC: soc-pcm: add soc_get_playback_capture() and simplify soc_new_pcm()
>   3) ASoC: soc-pcm: add soc_create_pcm() and simplify soc_new_pcm()
>   4) ASoC: soc-pcm: use snd_pcm_hardware at dpcm_runtime_merge_xxx()
>   5) ASoC: soc-pcm: fixup snd_pcm_limit_hw_rates() timing
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: soc-pcm: tidyup pcm setting
      commit: e04e7b8ccd4912e6c823bf7e66f302a53396fb77
[2/5] ASoC: soc-pcm: add soc_get_playback_capture() and simplify soc_new_pcm()
      commit: 7fc6bebd5831a788a74e019e39c43c014a96a110
[3/5] ASoC: soc-pcm: add soc_create_pcm() and simplify soc_new_pcm()
      commit: 2b39123b134e10a3817156bd9b157c9b8f950d6f
[4/5] ASoC: soc-pcm: use snd_pcm_hardware at dpcm_runtime_merge_xxx()
      commit: 4b260f425497b105acc2baa9d97ef781ef0c667d
[5/5] ASoC: soc-pcm: fixup snd_pcm_limit_hw_rates() timing
      commit: dd5abc7834ffae1ca6c399583353e00886817181

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
