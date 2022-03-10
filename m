Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3F0C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 11:36:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2394718B7;
	Thu, 10 Mar 2022 12:35:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2394718B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646912195;
	bh=4sTbkrwicTF0zdAODbHVXh4dN8uOyHDiMZ9NzTve5/4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BZm0gO7+QsmdpeAmP3C8JAFpMggQ/IWlk4BTZbBumI5zZbZAczsiJ+hv5d0GQUZ6x
	 XIvVUTFtyu7J6DG3QfS4NNIdUae4jQtxN252JyiMGuZp9i6Kd679CF300QqgDzaEOZ
	 NrNKQ4LolhdFWJ1W77a7RD0BdIS3d01Unf5oM++o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24051F8015B;
	Thu, 10 Mar 2022 12:35:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D7B0F8027B; Thu, 10 Mar 2022 12:35:17 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA7A2F80137
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 12:35:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA7A2F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VLcSyXiH"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 247D261655;
 Thu, 10 Mar 2022 11:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D28C340E8;
 Thu, 10 Mar 2022 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646912111;
 bh=4sTbkrwicTF0zdAODbHVXh4dN8uOyHDiMZ9NzTve5/4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VLcSyXiHxfSIi1c/PYzQbevKjcCwpR06VwLHQxLXADkab4AoTHG+onaedVjB2a5Qh
 qYAYwNdnuaui1fF8s0MiecYqpJ+vNBtqSWzPknVI0A3bbTOpDFDmWOddTlGkbtW9/j
 V6raUf8zexhy0IZYLnZydCiWJ9zaKabkSXiYDt+wdsPqnBwjWRolkg3qJ9+8nxSd1F
 xcV0AB09cDtIv29zzJl209gn313txSHPvrr1GQbXguih15dFrnHGfVq4yNzIpuAPUb
 b4bdTBi/aSSeJONnIWKPPtwUp5Sxeq0k84kzv2FO6nz24GXy7FyqIVWmCdG2zZ27B6
 3ZdGTPgGOz9eQ==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20220308202318.401358-1-pierre-louis.bossart@linux.intel.com>
References: <20220308202318.401358-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: boards: fix randconfig issue
Message-Id: <164691211065.13798.10591683148534165680.b4-ty@kernel.org>
Date: Thu, 10 Mar 2022 11:35:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Randy Dunlap <rdunlap@infradead.org>
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

On Tue, 8 Mar 2022 14:23:18 -0600, Pierre-Louis Bossart wrote:
> on x86_64:
> 
> ERROR: modpost: "sof_dai_get_bclk"
> [sound/soc/intel/boards/snd-soc-intel-sof-cirrus-common.ko] undefined!
> 
> ERROR: modpost: "sof_dai_get_mclk"
> [sound/soc/intel/boards/snd-soc-intel-sof-realtek-common.ko]
> undefined!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: boards: fix randconfig issue
      commit: 9779a8e61a83916ccfe7e6ddabcc7638d4bc2ae1

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
