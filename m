Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9668FC678DC
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Aug 2023 22:38:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B061985D;
	Fri, 18 Aug 2023 00:37:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B061985D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692311921;
	bh=Emr7HE/JJbf3uc9L6KhxZLueQQI7VvbDfxqJ6cAiJFY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vpnskiAAj+s8WY0WqxSsrropd8Hx12xqvWcA9Cw0QDBS6qOVAeOuzwfT7zfZPdS1Z
	 4FxWlWx8lkuPXJyuTqj6+j8r6vxcAXfZ1jkDRl/+PBMst7Un2OHbBMLxoi/L29IKUM
	 O3ZCTRL/fAZ7yCti24mvs1josYGURO07it7KqgZc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F773F8057B; Fri, 18 Aug 2023 00:36:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42D13F80567;
	Fri, 18 Aug 2023 00:36:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0CF69F80254; Fri, 18 Aug 2023 00:36:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3A98DF801EB
	for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2023 00:36:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A98DF801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G+fbN1EY
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 588D363B9D;
	Thu, 17 Aug 2023 22:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E095CC433C7;
	Thu, 17 Aug 2023 22:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692311787;
	bh=Emr7HE/JJbf3uc9L6KhxZLueQQI7VvbDfxqJ6cAiJFY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G+fbN1EY0/iMCPsGOttzs4U39JH0sqe2BtumutREtOKoxLHhein7/EMYBoIlQ1pAx
	 irEK4okwrsKzYGG5L/cBXEbFeeFE79vVvVN62kgfpDjmktHvw9ZAsLEfUWxfvQEzvV
	 BQPCIYZcBwDkXrxQFs6Et0dVNvz3hqnYItntAKn/o1Xw9FjHjqLlSD6aiDBTeDSsmu
	 0ZEZ6amFdSdP4kXYeBpeYh6Py+JqgSf6ZL/3OZltvTqASeIZQirmjgounTukeoHvFY
	 e2qDdz5Vuyny/Fsn/9q0nZnzMqbEYPqz2FWXUhGYAywX+R9pmjwsF139djL+itWpJj
	 UmEBKm7mHP6eA==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
In-Reply-To: <20230816164906.42-1-rf@opensource.cirrus.com>
References: <20230816164906.42-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs35l56: Update ACPI HID and property
Message-Id: <169231178663.153247.13799745756303310449.b4-ty@kernel.org>
Date: Thu, 17 Aug 2023 23:36:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: YXYCAHFN7W7FOIASDDS7T4JJG7OLYNMP
X-Message-ID-Hash: YXYCAHFN7W7FOIASDDS7T4JJG7OLYNMP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YXYCAHFN7W7FOIASDDS7T4JJG7OLYNMP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 16 Aug 2023 17:49:04 +0100, Richard Fitzgerald wrote:
> These two patches add an ACPI HID and update the way the platform-
> specific firmware identifier is extracted from the ACPI.
> 
> Maciej Strozek (1):
>   ASoC: cs35l56: Read firmware uuid from a device property instead of
>     _SUB
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs35l56: Add an ACPI match table
      commit: e8500a70270334b9abad72fea504ef38a2952274
[2/2] ASoC: cs35l56: Read firmware uuid from a device property instead of _SUB
      commit: 897a6b5a030e62c21566551c870d81740f82ca13

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

