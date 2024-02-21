Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEFFC48BC4
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Feb 2024 00:50:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DB62B60;
	Wed, 21 Feb 2024 01:50:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DB62B60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708476616;
	bh=oM+KCx3nQTgWbrIql5fYXL5IEUhqztgZwF6GnB3LzlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GBWj047CzoOKkuAHBNe5jjc+kpqI2G6C2ja1xcjqDUAiPdNa045Z6e62QJNgrHnkD
	 fY8R9pRv8kIdCtG6jG2v8o3V1Y5g84caDF+oDSi9pLhVOD0hrpYMFoKI/LV52wcykg
	 WKsMS2AmrbBSREgdiMkgdyFeRIrhzPOKQE6DNAGY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 957C4F80570; Wed, 21 Feb 2024 01:49:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93C3FF805BA;
	Wed, 21 Feb 2024 01:49:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5F51F804B0; Wed, 21 Feb 2024 01:48:53 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ABD42F80496
	for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2024 01:48:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABD42F80496
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VpzPSUsp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EB62561365;
	Wed, 21 Feb 2024 00:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CA6C43390;
	Wed, 21 Feb 2024 00:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476525;
	bh=oM+KCx3nQTgWbrIql5fYXL5IEUhqztgZwF6GnB3LzlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VpzPSUspBXQF+y/drt5tsedNFHJHbiuam7DRPZ5IpGByGPxU0CTkDqAIX1q/gg9rp
	 41c/yOm0OSGXMOOTqe9pPkItKnnp8aeY9pvbndXJqjZq6N4SPfE2J1wPPxnHx9aeQD
	 SBMWkKQ69Z3llsBMle/6YDh3lDKUbpL/KuX1lwy6W5QCW/LBOt4FlrgeWZCwiwZZon
	 60+Yq58DnmrV5qtcu2d2QTmwpyuc1I+Mtt4zoar8gvjGL5dUHpFkXkl8lfK6oCgE7L
	 FsNBCR4oMlblSdU9rxtWcTxGPpBBYot1EfceI786XcwRljsdejVeeaa20vIRNat8Dd
	 UG8JiaI1jlkIA==
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240216101157.23176-1-vitalyr@opensource.cirrus.com>
References: <20240216101157.23176-1-vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Remove redundant delays in suspend().
Message-Id: <170847652448.70487.17999741329629264318.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:48:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c
Message-ID-Hash: DWJ2U3JIWNNB5E3WELKTMRFBY6276K4V
X-Message-ID-Hash: DWJ2U3JIWNNB5E3WELKTMRFBY6276K4V
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DWJ2U3JIWNNB5E3WELKTMRFBY6276K4V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 16 Feb 2024 10:11:57 +0000, Vitaly Rodionov wrote:
> This patch will remove redundant delay and minimise
> total suspend() function call time.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Remove redundant delays in suspend().
      commit: 3b4ec34602c562fa8fa59dd8545ac7f3cdfc235e

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

