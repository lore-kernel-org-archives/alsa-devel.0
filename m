Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF9AC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 15:04:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8F9610FB
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 15:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E8F9610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 006231731;
	Mon,  2 Aug 2021 17:03:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 006231731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627916653;
	bh=NnxcVtIQ8H09f9yPch21fQNcIfoSSOrNp+cjh//dxaA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tu5U6/lR4g8pis63RqlRGqzj13dv3+3+lpcGZ4OtB8/XO77zvH4PCtueHGxSeK5t/
	 oQdo6+WgaVrGHesXwFCCUE/cBmOrDgBpgyS9QZmCLY7+K+0NNEGqhJL7Bk2RtFo62c
	 dDlJhj7B5BHTMsVT6WD6oDrMAx4eTyxVdmYVQhCQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6247CF8026A;
	Mon,  2 Aug 2021 17:03:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3652F80279; Mon,  2 Aug 2021 17:03:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6ACD0F80095
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 17:02:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6ACD0F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="P3nsPfLl"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFEF5610FB;
 Mon,  2 Aug 2021 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627916573;
 bh=NnxcVtIQ8H09f9yPch21fQNcIfoSSOrNp+cjh//dxaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P3nsPfLli4a8mWNAKvy5aAwivIic5HPW7TBEkNzi3BRGosekAz4siyGZxTnF9WQLk
 OFDpc8yyVsGP4AAF7jiLDjaD8gCe1oPY583hy+wTGSf0TRXdv4tgffzTgrvoYzHpEr
 ep6IHzwwoQ5EoM8B6wR9boCZ9f7Y327VRTTB9Mp+ikpIcsIzq7p4WMYcD3XO5kAL8m
 gSu6KGsld6sWwAu8/bvLcVsIYg+HZmeWLyME2sPRJiimac/DbrJ+drscGABeO3nsgo
 9DOpnXkbS7rO1oWnPvenDjkJgqMZU4Y6xBo4T2k+91CC+dKKH/bOr/Iw6c1fjDnEyU
 oWq76JEku2lOw==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/5] ASoC: soc-topology: cleanup cppcheck warning
Date: Mon,  2 Aug 2021 16:02:33 +0100
Message-Id: <162791613031.1468.13355473007712973727.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87tuk8wfme.wl-kuninori.morimoto.gx@renesas.com>
References: <87tuk8wfme.wl-kuninori.morimoto.gx@renesas.com>
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

On 02 Aug 2021 15:00:09 +0900, Kuninori Morimoto wrote:
> Now I'm posting audio-graph-card2 patch-set, but it seems it needs longer
> discussion. Thus I want to post more easy patch first, and reduce my
> local patches.
> 
> These are cppcheck warning cleanup patches for soc-topology.
> 
> Kuninori Morimoto (5):
>   ASoC: soc-topology: cleanup cppcheck warning at soc_tplg_process_headers()
>   ASoC: soc-topology: cleanup cppcheck warning at soc_tplg_dai_elems_load()
>   ASoC: soc-topology: cleanup cppcheck warning at soc_tplg_dapm_widget_elems_load()
>   ASoC: soc-topology: cleanup cppcheck warning at soc_tplg_kcontrol_elems_load()
>   ASoC: soc-topology: cleanup cppcheck warning at snd_soc_find_dai_link()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: soc-topology: cleanup cppcheck warning at soc_tplg_process_headers()
      commit: f79e4b2a38eda4e365f765d363f47cf0c2183ab4
[2/5] ASoC: soc-topology: cleanup cppcheck warning at soc_tplg_dai_elems_load()
      commit: 65a4cfdd6f2bc04b0c3d3607c48ceeac999c9424
[3/5] ASoC: soc-topology: cleanup cppcheck warning at soc_tplg_dapm_widget_elems_load()
      commit: e9aa139f95f5995d7010f46c285f5b9a19695b2d
[4/5] ASoC: soc-topology: cleanup cppcheck warning at soc_tplg_kcontrol_elems_load()
      commit: ea8f6b29b4a5676ca4b67b571a63ebabec245fd2
[5/5] ASoC: soc-topology: cleanup cppcheck warning at snd_soc_find_dai_link()
      commit: b81e8efa245af00e152a485297c611fe84a514a9

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
