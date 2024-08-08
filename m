Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55DFC52D71
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Aug 2024 20:57:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABEBEB76;
	Thu,  8 Aug 2024 22:56:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABEBEB76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723150626;
	bh=gQskhYCKBZdV2vBrToJVCxHeRpxoUra58siSeAn2qU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GCaECQOCejAlKZW8x5VA5MnYJtDpR/gWnE6MtrZE3TsUMmKXoC/3PeR5TFBbMkmT7
	 bs9ryIhrTB81G+PJ9n9FdGUFBEk9TlDOboMPbMI3wIrQl1tdfPk2jkKC8G2ANUrCSn
	 lj3KvxsEh6Yssi+4ITA2pkdsdrGOaItsgaP6O+lc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50191F805BA; Thu,  8 Aug 2024 22:56:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A59B2F80579;
	Thu,  8 Aug 2024 22:56:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 530DEF802DB; Thu,  8 Aug 2024 22:56:28 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D1072F80236
	for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2024 22:56:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1072F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ahluw+tY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3822ACE1381;
	Thu,  8 Aug 2024 20:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736B7C32782;
	Thu,  8 Aug 2024 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150576;
	bh=gQskhYCKBZdV2vBrToJVCxHeRpxoUra58siSeAn2qU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ahluw+tYv3l2devjutWVZeKXGZcIuB5VgXGMlqLxCix9bk5cDGID7DpAQro0YMafp
	 JQ7qJ8HLoW6eSzBGN+KqW7TfTemdkgHpzP0WStcpoBARGvwzUPYx92UcdV1cv5NPIj
	 ptK6YvYvEzfRW0M1hUhKvZtCnuzscZc1jlZNXLHkmNpK9oNZIja3kW7YhDAffyuXhc
	 0mQZjzX1xecJkWnCf5+k6jRUwKjxYlEGUTnd5oMq9EGCKO5ICPp0veE2a9lK4sW/2u
	 T7u0hiTAMAUEmDVlCjO6iLOTkIIotLrrsu0NLnLq+j3q/ywv9VJOGbNTSjJr7H+PQo
	 G6ZOdvao1yKXA==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240807142715.47077-1-simont@opensource.cirrus.com>
References: <20240807142715.47077-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Use regmap_read_bypassed() to wake the
 device
Message-Id: <172315057505.475406.7320183180625957298.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 21:56:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811
Message-ID-Hash: 2Z4QHS3GENKAFDWNJ5BFSWTBTFNVBCTB
X-Message-ID-Hash: 2Z4QHS3GENKAFDWNJ5BFSWTBTFNVBCTB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2Z4QHS3GENKAFDWNJ5BFSWTBTFNVBCTB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 07 Aug 2024 14:27:15 +0000, Simon Trimmer wrote:
> Now that regmap_read_bypassed() has been added to the kernel it is
> preferable to wake the device with a read rather than a write as the
> utility function can be called at a time before the device has been
> identified.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Use regmap_read_bypassed() to wake the device
      commit: 7063a710830a09b01734be7f4ffd23f0ef72a57e

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

