Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81634E7D24D
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Sep 2023 08:09:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 975FCBC0;
	Tue, 26 Sep 2023 10:08:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 975FCBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695715783;
	bh=aH7ozQDhP9+rq7B4jdXLYIVBH8NAT/Xa3VrnhdITKYM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=i4A8+y6AotOsaA59k/B8fl634upR3MmnKrjk4x4HhjLb3ACL+K0EydZsmVU2rMCIo
	 RW49ro8/WSNmQhBQLXjtWzecthqajZF+KT6jEvx5eTLE2jzYD8qBqZvL+AS6qfDUTq
	 h7oQ4xxZdeFQ6yUMt7pz+Alej/p4yZ/0xIf1c8bM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7084CF801D5; Tue, 26 Sep 2023 10:08:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DD1FAF80553;
	Tue, 26 Sep 2023 10:08:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 672A5F801D5; Tue, 26 Sep 2023 10:08:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B46BAF8001D
	for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2023 10:08:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B46BAF8001D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cA2N1EB/
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EACEF6130D;
	Tue, 26 Sep 2023 08:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BFDC43391;
	Tue, 26 Sep 2023 08:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695715704;
	bh=aH7ozQDhP9+rq7B4jdXLYIVBH8NAT/Xa3VrnhdITKYM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=cA2N1EB/lkUXDBj7skkCBPE9ET93tY348x5+OtyzW0VOVK3FNkYS/qnQKMpn8NfAt
	 SDZeYQGbg8TwoZQ4S2gkmzcY1E5vpWwHCrqFWMJ12/8W3m6B81YzX6NWdUE2lFC+io
	 7Y4RWyuyhQeHVaNVV93n8gqs21mY/Ip1VPtW6J+dhY1U59P9ZQQ7uF157qc9GxqVif
	 nNMo6gK/TfS1KAUv3KjsD65+RzGeF1LXwQFsiooPbYAux7uZd0cJCri2BRJMAoVkI0
	 a7B3WJU+ufJ5mWC1Z6IwhWl9KkZJF4ik/IJX5FFFMAB8RmBAkF2WMDaSkVBLRT2xn1
	 ye1yKzgOK+/aQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, matuszpd@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1695116533-23287-1-git-send-email-shengjiu.wang@nxp.com>
References: <1695116533-23287-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Don't disable bitclock for i.MX8MP
Message-Id: <169571570223.2520438.2470473456796299214.b4-ty@kernel.org>
Date: Tue, 26 Sep 2023 10:08:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: RNEMRR7BADGGHIADJD7FTMLYDDJBZ2JH
X-Message-ID-Hash: RNEMRR7BADGGHIADJD7FTMLYDDJBZ2JH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RNEMRR7BADGGHIADJD7FTMLYDDJBZ2JH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 19 Sep 2023 17:42:13 +0800, Shengjiu Wang wrote:
> On i.MX8MP, the BCE and TERE bit are binding with mclk
> enablement, if BCE and TERE are cleared the MCLK also be
> disabled on output pin, that cause the external codec (wm8960)
> in wrong state.
> 
> Codec (wm8960) is using the mclk to generate PLL clock,
> if mclk is disabled before disabling PLL, the codec (wm8960)
> won't generate bclk and frameclk when sysclk switch to
> MCLK source in next test case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Don't disable bitclock for i.MX8MP
      commit: 197c53c8ecb34f2cd5922f4bdcffa8f701a134eb

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

