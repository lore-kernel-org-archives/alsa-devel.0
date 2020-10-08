Return-Path: <SRS0=AlSY=DP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3447BC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 22:03:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4544D22241
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 22:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g6HadJzv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGHKyqyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4544D22241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 729C7167A;
	Fri,  9 Oct 2020 00:02:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 729C7167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602194594;
	bh=MPxM2gLgmMP0I4gy/iiaZnzLDBW/JXomkzNAtNr7u8A=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g6HadJzv50n5qimErxjGI121T26s+PGU4Exp9Kb8wpUWKzjH3XyvsRzjRFQFIzG+3
	 sOd/5UeAeJ7a+kiLi2T4V2GmmZcx+rOi221E1Vj2BDgxTxdwljExlGdyydy6xSXge2
	 xNYGA18E/NwOTuV7DW9GPSookyVx/3kya2M07I44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 003DCF80167;
	Fri,  9 Oct 2020 00:01:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7BC41F8016C; Fri,  9 Oct 2020 00:01:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E23EF80167
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2020 00:01:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E23EF80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WGHKyqyF"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ABE3B22241;
 Thu,  8 Oct 2020 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602194491;
 bh=MPxM2gLgmMP0I4gy/iiaZnzLDBW/JXomkzNAtNr7u8A=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=WGHKyqyFvRPEL3MT2Z/MSbiqFqx9ul9F+SBG9QX3GQ4PEOPHWiNK8vA2cM6GCQ0k5
 Wy7PA6TfNPXf81amalHxc5hbGxji6Z24vwsq1iWi1JrMiQRRQq7YWKueNcWbG+doGQ
 XltsVwltz/19LGSgJCNOxlSMfdNs3hNmlGq8Fi9M=
Date: Thu, 08 Oct 2020 23:01:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20201007135701.20372-1-cezary.rojewski@intel.com>
References: <20201007135701.20372-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: catpt: Fix compilation when
 CONFIG_MODULES is disabled
Message-Id: <160219448332.29664.691503813674841632.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, rdunlap@infradead.org, tiwai@suse.com,
 lgirdwood@gmail.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 7 Oct 2020 15:57:00 +0200, Cezary Rojewski wrote:
> module_is_live() is available only when CONFIG_MODULES is enabled.
> Replace its usage with try_module_get() which is present regardless of
> said config's status.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: catpt: Fix compilation when CONFIG_MODULES is disabled
      commit: f38d43dafb0ccd85034fe22647d353ee8be03ab6
[2/2] ASoC: Intel: catpt: Add explicit DMADEVICES kconfig dependency
      commit: 56a53ece74e4a5d47f6915f6b81623cec5151f09

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
