Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C844CC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 15:04:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C06560FC4
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 15:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C06560FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B402E1739;
	Mon,  2 Aug 2021 17:03:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B402E1739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627916657;
	bh=RhhS5Cqwe5PdUbNw9tYQyCon0mn6XrJaXwI0EMNCLKg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JRV+ZYJ+92yh+y7i7eOPkqzvNUYyWhWC6ASF+Mz2PGkY1ymBGhhua7geMJD+YTJbe
	 Z+USzt8AMWsTpjdtclZZXD4jH7x1A8t6nmLe2LVwtKjhp2X23NrUZqPktSZTvhKrvt
	 goXGXJx2uhrq8CMPQdncgeOLoN3KxfDJw4WQiwYQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EFA8F804E1;
	Mon,  2 Aug 2021 17:03:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20BC9F80271; Mon,  2 Aug 2021 17:03:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C844F8025F
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 17:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C844F8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DvMx9PBj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE96E610A8;
 Mon,  2 Aug 2021 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627916576;
 bh=RhhS5Cqwe5PdUbNw9tYQyCon0mn6XrJaXwI0EMNCLKg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DvMx9PBjecx3EVjBgiJZef5UBzA6M/1ked/ShK/VoDKxICO/6kxC99yXwiNwLfo7b
 4avBl0u/+61HCUzhPjhaUgEmkkOCVNVKbQsp2SxkgtvOn79VBkphppiZacDIOPiRYZ
 BeMuRgogWYM6AQ1U0c94Lely20inW9Z/+ShYI1iCtUHzk7SFE45RU8A9GmwAOJIST5
 NgEPzzo+IXSyeYQRiuhhJMZ2HwvyTuwKIY75Tv63GTsafsbsJXv4ybhZ1PA/GAe9l/
 /zXSvbCjDs8Y6atDSWofzkKcpXphdHkqYUNQmcJSaPhgOBgMUo/4lPefUbNztYmq4m
 g1zNZ2YXEWMuA==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2] ASoC: amd: Fix reference to PCM buffer address
Date: Mon,  2 Aug 2021 16:02:34 +0100
Message-Id: <162791613031.1468.15530322169024146309.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210731084331.32225-1-tiwai@suse.de>
References: <20210731084331.32225-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

On Sat, 31 Jul 2021 10:43:31 +0200, Takashi Iwai wrote:
> PCM buffers might be allocated dynamically when the buffer
> preallocation failed or a larger buffer is requested, and it's not
> guaranteed that substream->dma_buffer points to the actually used
> buffer.  The driver needs to refer to substream->runtime->dma_addr
> instead for the buffer address.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Fix reference to PCM buffer address
      commit: 8b5d95313b6d30f642e4ed0125891984c446604e

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
