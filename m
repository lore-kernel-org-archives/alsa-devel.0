Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CCBC25B76
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:46:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99C36826;
	Wed,  5 Jun 2024 23:46:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99C36826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717623979;
	bh=yrMbNY2Gr7i5mUw30Jlna/5JAKzdrHFu4hvA2gyNBkg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UaTcBQwt2Yk+0pnqGmRsSlGv4f1d5FBXkSEB0RfT9mFyMI87cnE4wAXrNR45l71Qe
	 hkXygH/YxWQL2gvnEiBz6ePFjrVHOXHB7kE7davcYweysHY93u3SUOPNoZ+e8wkrPM
	 oU40gSajuoBwET8QtgK/moqsDXM/42HsGjDjB978=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94A92F805D7; Wed,  5 Jun 2024 23:45:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D385F805E1;
	Wed,  5 Jun 2024 23:45:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 714F5F8025A; Wed,  5 Jun 2024 23:41:06 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 82534F802DB
	for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2024 23:38:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82534F802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lQxwQXuR
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0106D61B1C;
	Wed,  5 Jun 2024 21:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B38C4AF09;
	Wed,  5 Jun 2024 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623509;
	bh=yrMbNY2Gr7i5mUw30Jlna/5JAKzdrHFu4hvA2gyNBkg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lQxwQXuRvfm9OWCFsbHuZEiWtVU5w6nccY6yS+rlo0rS2J+6lU3V/M6LSrtC2U0NK
	 l9brby4WmHNVoLDfTQn/MnwGvLoeFge6FjifxDqZTg3+7dw2P42pu3rwCcnk0Fo8LR
	 djuvepdmdBlyxG0uerykdOmWo4+bePL3hzmdc8Ei4+0mU7ry8ttbAhtWAxpKXQLLgB
	 Uu+PWn93L1CKJR4v/j05j+462Wa74MvY6sfGYtzT0dzNImxNELgR00pFp1Tt/7C7Zb
	 yS8YotY8URtKUMYU24Enw0Fugh7uPxyYALCETLFebOTPKfkjyghDGIAufUNb5sMnB1
	 Nkj1PnPb5aKLg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
References: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4 0/2] ASoC: fsl_xcvr: Support i.MX95 platform
Message-Id: <171762350655.565712.3068600680938105880.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: 5EMANZ6UJSQ2NNKM34VKUUR3DNWQUF24
X-Message-ID-Hash: 5EMANZ6UJSQ2NNKM34VKUUR3DNWQUF24
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5EMANZ6UJSQ2NNKM34VKUUR3DNWQUF24/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 29 May 2024 16:40:00 +0800, Shengjiu Wang wrote:
> On i.MX95 wakeup domain, there is one instance of Audio XCVR
> supporting SPDIF mode with a connection to the Audio XCVR physical
> interface.
> 
> changes in v4:
> - refine the constarint for 'clocks' according to Rob's comments
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
      commit: fc1277335ffa0d180c76ddccf5fe27fc75674e67
[2/2] ASoC: fsl_xcvr: Add support for i.MX95 platform
      commit: f13b349e3c70320ef5a86edfc888a6feb612abb0

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

