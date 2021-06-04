Return-Path: <SRS0=evnw=K6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F5C47425
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 16:33:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18F7613F4
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 16:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18F7613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82F451730;
	Fri,  4 Jun 2021 18:32:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82F451730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622824428;
	bh=VVDwBOYJlwtQ+NvG+nh6ewV59zoduApWF+wXmmPHwX4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X5cpC5nAA4KcbUwP4aLCEq/mG0R49Lp++dUXST3jB7Ui7+JWZ63MB+VsjN68acpmZ
	 DoZtAB58/Ml3+rpfbP5S2If8FKjlPx5Nv72ZZQK8uZPo1RDLElFMc9hBLa4yNPjhVT
	 Rx4woBBMRPzB/VUWC3DGbj+Es6olQruB6DSqyafo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07F01F80424;
	Fri,  4 Jun 2021 18:32:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83912F80424; Fri,  4 Jun 2021 18:32:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E50EF8016D
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 18:32:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E50EF8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="s0oIRGE6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6782F61153;
 Fri,  4 Jun 2021 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622824369;
 bh=VVDwBOYJlwtQ+NvG+nh6ewV59zoduApWF+wXmmPHwX4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s0oIRGE6/X4aG2o5pEbogpEBFp5m+ztFKFdbZPKQ5vhn55nUarK87MJoOH2UY7Tqj
 sUnQ9quZsatXGL5Dt2pwMYWVnpXIOLU2Y6MRsSDaLr7jdJS/vwmLSHkV6MedXtj8rZ
 zdcRfL7tJ8iSOEENJVaQFllTnhqIWH8nE2kr7Hib1hke/EnL/rFdDlisQ2or5pvhEI
 UIwXiIKGoHvV2uPupDhgjk9vxwIc7BO6EBtPLxPVi8UHuLD+AwjIFGYtX2gEGMuBlO
 Z0IBlGppsCTgvFjYhzgzNETH5cTu6uWcZOsRoVjGyFgQ2P/ECBnBSsv1aRQs95ld7O
 MiMD0SvkAG+oQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, alexandre.belloni@bootlin.com, perex@perex.cz,
 Bertrand Jacquin <bertrand@jacquin.bzh>, srinivas.kandagatla@linaro.org,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com
Subject: Re: [PATCH] ASoC: snd-soc-lpass requires REGMAP_MMIO
Date: Fri,  4 Jun 2021 17:32:27 +0100
Message-Id: <162282419357.38836.17547225118877457445.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210603221816.2642402-1-bertrand@jacquin.bzh>
References: <20210603221816.2642402-1-bertrand@jacquin.bzh>
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

On Thu, 3 Jun 2021 23:18:16 +0100, Bertrand Jacquin wrote:
> With CONFIG_SND_SOC_LPASS_RX_MACRO=m and CONFIG_REGMAP_MMIO undefined,
> build fails with the following error
> 
>   make -f /var/tmp/portage/sys-kernel/stable-sources-5.12.8/work/linux-5.12.8-stable/scripts/Makefile.modpost
>     sed 's/\.ko$/\.o/' modules.order | scripts/mod/modpost   -E  -o modules-only.symvers -i vmlinux.symvers   -T -
>   ERROR: modpost: "__devm_regmap_init_mmio_clk" [sound/soc/codecs/snd-soc-lpass-rx-macro.ko] undefined!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: snd-soc-lpass requires REGMAP_MMIO
      commit: e78f36bc13591e8d23948996ab6d195f1efa8f40

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
