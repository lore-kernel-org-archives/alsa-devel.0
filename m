Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6500EEE499B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Aug 2023 22:41:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8DA0ED1;
	Sat, 19 Aug 2023 00:40:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8DA0ED1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692398494;
	bh=Nse0OqiDeeow9aGXLambsveAhmESpWwoMJRYkKm94GY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SmRN6t2lFhZh+MnLLcDoIVOmTdSjPXHXmLdazfCOqqROZ9OGjflc1XtxlF37RQajf
	 QPV5o3WANoy2Vk67R1stOBjmAUzgvs7aSScS30fgcKqVUwfqHhgU02azOQ60X//3+y
	 dYZXRG9GnIoLZIDlh46IlEwO2bfIqO0HhOW/j3tI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC422F80254; Sat, 19 Aug 2023 00:40:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E087F801EB;
	Sat, 19 Aug 2023 00:40:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20B2FF801EB; Sat, 19 Aug 2023 00:40:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B4402F800EE
	for <alsa-devel@alsa-project.org>; Sat, 19 Aug 2023 00:39:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4402F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=t56wwAfc
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 99A6C636D1;
	Fri, 18 Aug 2023 22:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66585C433C8;
	Fri, 18 Aug 2023 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692398392;
	bh=Nse0OqiDeeow9aGXLambsveAhmESpWwoMJRYkKm94GY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t56wwAfcAmfQWhjpJxgGFzvwq+pOwBd4VpjxrobuEcfkrZc86Pn5dnkPXEQazUvCy
	 2nc0tXtHujhFb2TNY+lwOW7eB2rgHlo9Dk4nx0gttFg56LybLIwgu2yPYv4M8PN9jF
	 N4gX2WlgwpEh/GqaVtQuZBhLknO5KCc2VrxcpssAbMaiPJZL7UzzzNtCCtBm4ERk+E
	 ZWy/48LbOW3P1E0mQprN1I3XhhGLhYc+n7bHPPxksyhMkHFEZdj12F0M05h7NpmNuR
	 aiUBJCKIlDVuUsof9uaNKds3XTXDneCOmYxlOoWzL2woj6k3YJPB41o2Dja/i4fS3q
	 suuulY23eC/zA==
From: Mark Brown <broonie@kernel.org>
To: lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, vkoul@kernel.org,
 lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v7 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-Id: <169239838812.91093.16710150349963610066.b4-ty@kernel.org>
Date: Fri, 18 Aug 2023 23:39:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: A6MPM3QAQ7GLVXUCFUJYRE2EJT6U6TUB
X-Message-ID-Hash: A6MPM3QAQ7GLVXUCFUJYRE2EJT6U6TUB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A6MPM3QAQ7GLVXUCFUJYRE2EJT6U6TUB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 04 Aug 2023 11:45:56 +0100, Charles Keepax wrote:
> This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> branch.
> 
> This series is mostly just a resend keeping pace with the kernel under
> it, except for a minor fixup in the ASoC stuff.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[5/6] spi: cs42l43: Add SPI controller support
      commit: ef75e767167a8f30c7690bc4689dba76329ee06e

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

