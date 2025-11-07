Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EEFCCF9F8
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Nov 2025 15:15:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02806601FF;
	Fri,  7 Nov 2025 16:15:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02806601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762528551;
	bh=EbnfNKkSepBd/7qLPuAJsdb/5Ar1OyTON0O/zB8u33k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RhIj60cSNGExh3HUiY73+WPnttICxQWvA8wWGtkf2Hb9WI07sGqtIs7ABtIuF/koN
	 MT89mAgs4B3TGuW140hnGPAiTqT0YP926EIisaz+1hjeAaznSWIobKGQ8gD/IOzXrT
	 lx/tCjHsIl6u8/WtSffD2gEb6U/5igdVzHmJvp3Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C76E9F805C9; Fri,  7 Nov 2025 16:15:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 653C7F805C5;
	Fri,  7 Nov 2025 16:15:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20668F8055B; Fri,  7 Nov 2025 16:14:51 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 476BDF80100
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2025 16:14:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 476BDF80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gm/zFBIp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8244D41704;
	Fri,  7 Nov 2025 15:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DF3C4CEF5;
	Fri,  7 Nov 2025 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762528484;
	bh=EbnfNKkSepBd/7qLPuAJsdb/5Ar1OyTON0O/zB8u33k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gm/zFBIpAC+oEM0mMOWDYFMkB4cyLYmu2pRfdxna/9jh3TU8UdmPLQ4QaYaxviaY1
	 iBw1PiS/jk0tnaIMVwOh18TUOcl5Mwe9CJHwBfOj1w9PFR/xMzmmD04I39IBLKjkCn
	 yMha62fbnnVznawIPKE5BQUgmklkbCX+xaOD9VLafFJEis3btz48auUtznHXvkGb7t
	 JjxDa09aD3af/j8N6Dkx+iY9+al8b5gze8UT9/YUsWJ/fnrhGonJgYvFAZot9nQzqS
	 jg3DMnwzzX0Kp7HvdLoCxxnIbxAWGk6s7T2K4suxsWJo50TL5MxPw8+ELw+FDGoz0r
	 UNFRGpvpHgfpA==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, tiwai@suse.de, 13916275206@139.com,
 13564923607@139.com, alsa-devel@alsa-project.org, baojun.xu@ti.com
In-Reply-To: <20251107054959.950-1-shenghao-ding@ti.com>
References: <20251107054959.950-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: fix getting the wrong device number
Message-Id: <176252848127.2504843.9477294733658012266.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 15:14:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3
Message-ID-Hash: XYOWN2TTOHNHRPZW3HTFOUXQ6AOKM6FF
X-Message-ID-Hash: XYOWN2TTOHNHRPZW3HTFOUXQ6AOKM6FF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XYOWN2TTOHNHRPZW3HTFOUXQ6AOKM6FF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 07 Nov 2025 13:49:59 +0800, Shenghao Ding wrote:
> The return value of device_property_read_u32_array used for getting the
> property is the status instead of the number of the property.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: fix getting the wrong device number
      commit: 29528c8e643bb0c54da01237a35010c6438423d2

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

