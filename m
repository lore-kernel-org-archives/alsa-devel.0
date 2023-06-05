Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117ABC77B73
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jun 2023 14:57:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79F84820;
	Mon,  5 Jun 2023 16:56:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79F84820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685977020;
	bh=dsKLKUnSC7Lzve2PHpaN+dv2LWO64PBoXx6bYC755Pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZDEs9AWAtxwWEUfBehgWpMsDeSrVBQBWM9pkZak9iE8sztT/zAs7RfkRIPpRNHU89
	 wZkx54nzINXVkeHYC5ASgClHzJeQ+tlf6MtGs8iQWcBrRI2ms1ZDjJC67cTjLlO8jD
	 Giiw44jysUvqEEveF94v/O5brY+haeEiqAwsYkkA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7505AF80527; Mon,  5 Jun 2023 16:55:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 073ABF804DA;
	Mon,  5 Jun 2023 16:55:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47B81F80199; Mon,  5 Jun 2023 16:55:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 42029F80155
	for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2023 16:55:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42029F80155
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=S+ftYoYQ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A5DB96265A;
	Mon,  5 Jun 2023 14:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE453C433D2;
	Mon,  5 Jun 2023 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685976934;
	bh=dsKLKUnSC7Lzve2PHpaN+dv2LWO64PBoXx6bYC755Pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S+ftYoYQpGacxIKa1yAwv29a0D6wK+DJ8wWpQS81Tn5VEHNH5AgLMa/6KT2WcIagp
	 PYvpxKY74SRtx2px4TO5oGTiNPZFtOH5g1J2LMTirs2dR21jf/bS2+oS1wpX1ZxJlb
	 s24I+RSMcID6gT51C2FznLmM1yULh21mEM+pWlppWUktdAiwWAv4EMxCsTpkmQu0hF
	 kSLzQKgVykmHaGWoXwiullH/KtGtSDjT3cwOpfjShLeukH1kiFgvlK4OVLv/vaQeId
	 dHM0BEhKEGzuzqFYF87Mkco4taALMOroPQgNoND5sxIqXmG0NYk9g0R1SuBgfgRdve
	 vmTK05vOr3/fg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230605085839.2157268-1-arnd@kernel.org>
References: <20230605085839.2157268-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] ASoC: amd: vangogh: select
 CONFIG_SND_AMD_ACP_CONFIG
Message-Id: <168597693169.38149.4954524469531400415.b4-ty@kernel.org>
Date: Mon, 05 Jun 2023 15:55:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: JJHK27FWNIZBMLYXB3QZ5SXXMLCMCLIR
X-Message-ID-Hash: JJHK27FWNIZBMLYXB3QZ5SXXMLCMCLIR
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JJHK27FWNIZBMLYXB3QZ5SXXMLCMCLIR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 05 Jun 2023 10:58:29 +0200, Arnd Bergmann wrote:
> The vangogh driver just gained a link time dependency that now causes
> randconfig builds to fail:
> 
> x86_64-linux-ld: sound/soc/amd/vangogh/pci-acp5x.o: in function `snd_acp5x_probe':
> pci-acp5x.c:(.text+0xbb): undefined reference to `snd_amd_acp_find_config'
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
      commit: 812a05256d673b2b9c5db906775d1e6625ba4787

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

