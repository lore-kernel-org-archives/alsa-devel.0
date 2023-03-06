Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0AC678D4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 13:34:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36351111D;
	Mon,  6 Mar 2023 14:33:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36351111D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678109678;
	bh=sjjZ6oVOv9YLH8DLMFpmQEUzWtL1id3MSe7MNtS7IuU=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p7iI3lVxMOhYpmH7G0zwZOAqHwkgSBn7B1/yjfzZ9h6xmqrZVnU3CAjD7u6M+llZ2
	 1aq/YkAHhFjzowcZsWXN2gSEkW4esK9AZJO7BVUoKgfT3N0EkwcHG5/CUymOe7SJJH
	 ozsU8ci9HK6LvxuY89x/dCwVtaXEVwOUkad9mMqA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A55EF80534;
	Mon,  6 Mar 2023 14:33:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CA5BF8052E; Mon,  6 Mar 2023 14:32:07 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1545CF800DF
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2023 14:32:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1545CF800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oPTBK2QX
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 977D060F25;
	Mon,  6 Mar 2023 13:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABA8C4339E;
	Mon,  6 Mar 2023 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678109520;
	bh=sjjZ6oVOv9YLH8DLMFpmQEUzWtL1id3MSe7MNtS7IuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oPTBK2QXElm2jcBCjOy0FYFOhnlR6FEiGYPhaf6S2fqvbVhFKWZu37F7UOGm1ZvSz
	 gKaHrMubrc+4lyAf7rYCL/7X0stEmQtg6vSKyfnOVGvhZxyd3k/Be1hR53vn1ORozh
	 vBfOi5vYPkFD0eSbAWf34eh7pysVJQzCyIaAR+mumJ7+DqkjCheFVlgKOvuvba6bZT
	 oKXRk0Qtr7At7tvysUr6ombG6olBCV9j3PXtvJfSUkC1dNlB+VpRw70xUlstpGs1Dv
	 g1QxqMD3Cgvc5wfpBfzezJEUVsB4P6F/exF4COFmHbMo2FsI8TpK7phW/3WP4cyxrE
	 fhtqSc0Db5fkA==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230301204628.1073819-1-jacob.e.keller@intel.com>
References: <20230301204628.1073819-1-jacob.e.keller@intel.com>
Subject: Re: [PATCH] ASoC: Intel: avs: Use struct_size for struct
 avs_modcfg_ext size
Message-Id: <167810951929.75807.14190162195676943463.b4-ty@kernel.org>
Date: Mon, 06 Mar 2023 13:31:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: NJDYQYO4SY3AA26NGLH3RY2HFKDYRO6G
X-Message-ID-Hash: NJDYQYO4SY3AA26NGLH3RY2HFKDYRO6G
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org,
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 01 Mar 2023 12:46:28 -0800, Jacob Keller wrote:
> The struct avs_modcfg_ext structure has a flexible array member for the
> pin_fmts array, and the size should be calculated using struct_size to
> prevent the potential for overflow with the allocation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: avs: Use struct_size for struct avs_modcfg_ext size
      commit: c9ef0fee3bdf8197538aadc728e475fceba113bb

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

