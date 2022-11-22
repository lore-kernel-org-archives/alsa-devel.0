Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D308C43217
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Nov 2022 14:50:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E0D21633;
	Tue, 22 Nov 2022 15:49:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E0D21633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669128615;
	bh=bKeRPVjJrncT4C0fmvTZ2poFrpNaAGtHQW4ySLc8gUU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tG24jgASzNieRmdnBV/pVdD4ZkZv2VRvGWGmIHJ8HIMYEx3uJEzvM9R5D7u45aeyf
	 nZjM/5cOiiWnMS/eT6nWsG8daxS3acZJt1HFsmRa27shWdB7u1/BYYEwQuYWj3fn9e
	 dyye9sq0OsKQigzXXXd3F1DmqnhqqmQ0zGqG9xTg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F178F8026A;
	Tue, 22 Nov 2022 15:49:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2547F804B3; Tue, 22 Nov 2022 15:49:22 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7359F80149
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2022 15:49:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7359F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qkp7G5LC"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DE74FB81B99;
 Tue, 22 Nov 2022 14:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E94FC433C1;
 Tue, 22 Nov 2022 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669128554;
 bh=bKeRPVjJrncT4C0fmvTZ2poFrpNaAGtHQW4ySLc8gUU=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=qkp7G5LChqlxCNxZPCZ1TRGAmlU997CYbuhQJ6cK0YdwjVtpogmfc5eQQJynKzW0i
 oMS2Z2U60Iq//AlYuXhDULaSNjOex0oguGYP0o/FUDoXcW39hLcUNCASOyIA1aaznT
 0sjpZ3trjAeurfgYg9oyNZedjBW58vHXuQIjQ2dGwOSNvEBm+WGZSbe0GqNqgeZYRa
 qkXTPX0vCkcHrALdAVqVgzz44ot0AEIYWNqmjWNkKS4FsET3+LjFBb1kIGBjLHx9hS
 Ka8E20/E3cO+E4Gh3tU7WCW16CH2eterIC3nY2jha90K8DO+XteuDwIK/ySSCEXaYK
 iDYM+a+o9CPgg==
From: Mark Brown <broonie@kernel.org>
To: cezary.rojewski@intel.com, linux-kernel@vger.kernel.org, perex@perex.cz,
 kai.vehmanen@linux.intel.com, tiwai@suse.com, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, lili.li@intel.com
In-Reply-To: <20221121104742.1007486-1-lili.li@intel.com>
References: <20221121104742.1007486-1-lili.li@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Fix Kconfig dependency
Message-Id: <166912855277.213382.2191182990253588501.b4-ty@kernel.org>
Date: Tue, 22 Nov 2022 14:49:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
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

On Mon, 21 Nov 2022 18:47:42 +0800, lili.li@intel.com wrote:
> From: Lili Li <lili.li@intel.com>
> 
> Commit e4746d94d00c ("ASoC: Intel: Skylake: Introduce HDA codec init and
> exit routines") introduced HDA codec init routine which depends on SND_HDA.
> Select SND_SOC_HDAC_HDA unconditionally to fix following compile error:
> ERROR: modpost: "snd_hda_codec_device_init" [sound/soc/intel/skylake/snd-soc-skl.ko] undefined!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: Fix Kconfig dependency
      commit: e5d4d2b23aed20a7815d1b500dbcd50af1da0023

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
