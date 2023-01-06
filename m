Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6B4C54E76
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Jan 2023 17:06:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9C131485C;
	Fri,  6 Jan 2023 18:05:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9C131485C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673024770;
	bh=yzUgOX03REvnqdWszk7eSyOU7gDnqqziGYE0sY8A/R0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=COBEeErvV3ky4es2xXxiNPdoVnqXBH0ZSggqR4+T+ZoV4XZpLGEjKHIsNhZ+EDS4x
	 US/g+X2Df+Z2lYum3DE/+ufUZ+UhXN7Hj7qEPMSW6/W8H/NasDQBCZd4JLKRezSLMS
	 +QxzonAQM0Rztm6KGfQgIanElr5BAXA4YES4PzmQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F4F6F802DB;
	Fri,  6 Jan 2023 18:04:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6683F8025A; Fri,  6 Jan 2023 18:04:54 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 301ABF8022B
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2023 18:04:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 301ABF8022B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HjHzhgaw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 53C1BB81D5B;
 Fri,  6 Jan 2023 17:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26358C433F1;
 Fri,  6 Jan 2023 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673024691;
 bh=yzUgOX03REvnqdWszk7eSyOU7gDnqqziGYE0sY8A/R0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HjHzhgaw1XooiPR5KvpTtcJGy4ufiqh/xYMReh5Qb4WXyFSPRBNkgA7iBAWRrJ+Xx
 2upZw+vnbP7NTdDqrsUybXj1AtlTaZAIJPuFweRoYYOAhABXYBo0uipqml5tt8sK0G
 TVMWPOHjRPMVpZZUL9ppIJ+53UR9XhMJsJZfzGFdx7+MR92xzrQYYnp6x3ECNFuEkw
 kUJgU5RG1s0sH86ENqLJZ07MenIbXt3bZe6ftnXDMTy9j9UrT2lxhcEEqSDSAM/IxA
 jUC6KsyvPIwik4C8NzKX5Vav64JFUaEsAMXYCwqmwJse8F7Zm1/sJpN9H99p4MwgfN
 62oIoq7PKR9RQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230104145708.25051-1-pierre-louis.bossart@linux.intel.com>
References: <20230104145708.25051-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: amd: ps: use static function
Message-Id: <167302468987.215080.18138342775610314637.b4-ty@kernel.org>
Date: Fri, 06 Jan 2023 17:04:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-214b3
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Cc: tiwai@suse.de, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 04 Jan 2023 08:57:08 -0600, Pierre-Louis Bossart wrote:
> Sparse warning:
> 
> error: symbol 'acp63_fill_platform_dev_info' was not declared. Should
> it be static?
> 
> Also reduce line lines below 100 characters.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: use static function
      commit: b118458936785bd104e95f09abd52525c0a84616

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
