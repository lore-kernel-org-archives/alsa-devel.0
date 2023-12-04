Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E038DC4167B
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Dec 2023 16:30:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E95D29F6;
	Mon,  4 Dec 2023 17:29:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E95D29F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701707401;
	bh=kXALvUUA7C60RTiEvlmbNaLVBTs8Swam2ASKbF/SNa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LmJmsDR8Xtz6AJrtqG5vnJx4YYNjIV8GuboLkwxUUiRKK4XSStvSJrY/D6RK9i0rl
	 mYE1ia6l1hXMFfgZtmH7olBu+eWXXpgBZ0tvBOOtO9q8jbx+UUVewPQdXz54chSdCi
	 2+pmqQNG8bKKyRJTMN2gH6scGOP7qCWnwp1Y7Jcg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42067F80567; Mon,  4 Dec 2023 17:29:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C5B51F80580;
	Mon,  4 Dec 2023 17:29:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECB2CF8024E; Mon,  4 Dec 2023 17:29:25 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CF48EF800D2
	for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2023 17:29:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF48EF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aE9JBFdK
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0D1FCCE1002;
	Mon,  4 Dec 2023 16:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC935C433C9;
	Mon,  4 Dec 2023 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701707359;
	bh=kXALvUUA7C60RTiEvlmbNaLVBTs8Swam2ASKbF/SNa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aE9JBFdKF0xPlg3i222eHc8zIytY35eCO0X4W70DEc7oWgBixullGaC8zJU5lSEDS
	 TQZces5L21wq1mYm3b6HatKYGl95A5naY8e3Unq3A8op4DbfpCqzI2wjFfIiotLjtU
	 s6kakKRXyOI1azUCmEAJ+vq6ILYHhWzMVkrxS+gBoIN1l4VskcAfbttWB9i0ERGNVJ
	 xNDBdjLz1GrFwybIVXsK2yOR0yRYz16sw+cuvO+jRvDz/gVNaNNVGRl1TBjHPdT+tq
	 RN93Zh/W2GUQCZJt8IMoDQmG2IvsJI1/NsfI6XlBwQ7m2STP3eMjsk8wxJHv4SsAu7
	 efygr/RUpdH6w==
From: Mark Brown <broonie@kernel.org>
To: David Rau <David.Rau.opensource@dm.renesas.com>
Cc: support.opensource@diasemi.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231201042933.26392-1-David.Rau.opensource@dm.renesas.com>
References: <20231201042933.26392-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Support low DC impedance headset
Message-Id: <170170735755.96782.4583489004118751914.b4-ty@kernel.org>
Date: Mon, 04 Dec 2023 16:29:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
Message-ID-Hash: VJAWVNIGHHWUDQV6ANLDNNLJV5DECIY2
X-Message-ID-Hash: VJAWVNIGHHWUDQV6ANLDNNLJV5DECIY2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VJAWVNIGHHWUDQV6ANLDNNLJV5DECIY2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 01 Dec 2023 12:29:33 +0800, David Rau wrote:
> Change the default MIC detection impedance threshold to 200ohm
> to support low mic DC impedance headset.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Support low DC impedance headset
      commit: 5f44de697383fcc9a9a1a78f99e09d1838704b90

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

