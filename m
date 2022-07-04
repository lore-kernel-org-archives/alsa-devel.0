Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C93C43334
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jul 2022 16:00:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EACFB1727;
	Mon,  4 Jul 2022 17:59:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EACFB1727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656950423;
	bh=1E1E7hQgiteHL2Gs8XLqTIBhCoUZep/DLAZWhET/WuI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c/eEBvsSCYAqGdqDTaH2xUgFXYxkazowmo9MEDrta8vIMx9KGFanEtYjjdgMji6EZ
	 l90azYerefoCzGId9O6dEkn+rNGBr7BuRCFy74hE9E/PtVFhJmQxt5WdjLoPXgXQ+z
	 2epzwvLGU/1LRKqG2FyiankyzOY9o/yUNRFgv9Y4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B7E4F8055A;
	Mon,  4 Jul 2022 17:58:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF67AF80557; Mon,  4 Jul 2022 17:57:59 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D051F80165
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2022 17:57:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D051F80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="N2xnvGJr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7B8B5B8115F;
 Mon,  4 Jul 2022 15:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED676C3411E;
 Mon,  4 Jul 2022 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656950275;
 bh=1E1E7hQgiteHL2Gs8XLqTIBhCoUZep/DLAZWhET/WuI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=N2xnvGJr8PmDQcW+8VqQwBy0czRaBGH237+6xYUWZKLxtcpOEyy/1bapz+Z/EoNoU
 Rk0Jca/ijfd/bHAGvrTpC6bTzigkl6zkbqF3vgen9XmldWlFwD9HxfL+OVY9YoMhvc
 QAymAMWrJW0EDclvAQJ/PoBbmA5z34d+ZKJKWAQDhCnhMUmo6C/VaT1r0tDxmXMpGR
 0HUKxb14RYB7XQpMl6Cu3xg23WBeL7l4bKsYmOv6509pNZj0jZach/2w+nAEBClpPZ
 aMtEiChH/gqqhdth7VhGMNhAbxEwQz0tSsYS+9xQMESVuOfJKAMxYB04rKwWV1UDRh
 j940EY8OqsFEA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, alsa-devel@alsa-project.org, shengjiu.wang@nxp.com,
 Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com, perex@perex.cz, tiwai@suse.com,
 festevam@gmail.com, nicoleotsuka@gmail.com
In-Reply-To: <1656899417-4775-1-git-send-email-shengjiu.wang@nxp.com>
References: <1656899417-4775-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_micfil: Add legacy_dai_naming flag
Message-Id: <165695027267.481068.6982856158106721474.b4-ty@kernel.org>
Date: Mon, 04 Jul 2022 16:57:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Mon, 4 Jul 2022 09:50:16 +0800, Shengjiu Wang wrote:
> Need to add legacy_dai_naming flag otherwise there
> will be issue when registerring component, that cause
> the probe failure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_micfil: Add legacy_dai_naming flag
      commit: 978bd27c9aed13d7d739bdcdcf98cbca9106b0ec
[2/2] ASoC: fsl_asrc_dma: Add legacy_dai_naming flag
      commit: 446499743b26958a58891a8f9a061deb5cce7c82

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
