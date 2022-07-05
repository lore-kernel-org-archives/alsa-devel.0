Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696D8C43334
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jul 2022 18:53:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F21016EA;
	Tue,  5 Jul 2022 20:52:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F21016EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657047224;
	bh=EWfRq+tWKV+8Qks2XSArxpnIXRNsB+UBf4g4MzjPFHI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CObGSidqYQjZL6QET/aPR26xhS+Z7ziwx561FfN/G7fTP/mu+iy+j2IC4OICo71OL
	 eVnkjbNYT40I+qhc9Vfx8zdX7xg43xJw2Wz6ohDYTLuMmDdkr7bRPrEUBwDqO3PeF0
	 doZgFVEdhCk2Vk4VqHG+Y4dbZsYJ/X6AMya+zSoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4773F80104;
	Tue,  5 Jul 2022 20:52:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01A8EF8052E; Tue,  5 Jul 2022 20:52:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DCCCF804B2
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2022 20:52:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DCCCF804B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JF9LQ2Hr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3E76961A74;
 Tue,  5 Jul 2022 18:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F09C341CB;
 Tue,  5 Jul 2022 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657047138;
 bh=EWfRq+tWKV+8Qks2XSArxpnIXRNsB+UBf4g4MzjPFHI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=JF9LQ2HrBz6obOxva65E3jEGayO18adkIej71mpp+DqqY3953oXUlnj1tUJF7xM2T
 OXFbbVcLYnbt6CbG+b2cBQdzDhZ/gB7/XXuZkBx/pzsorYEs5LrCy8/jNcMfODVTO5
 EmHokIpljGhzPbjG17hel3BXndN5eUncXPSRNykes5sFixf6skQ9CZZqvC6/tzjvHT
 +JBPzYhGhwEJ/G8/n0CSiWgGo5ZZ/7/tR8bHwqfYQioFWw5CvZgc+sSkQc7ZPqPIK+
 vSEYHG1H8zvAtQJ704WIjyGdskePtrVvh4FOZ9dsSuf3TL9djymbBnLY8wi95Z7UaS
 qEK6wlimJVmiQ==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, lgirdwood@gmail.com,
 tiwai@suse.com, perex@perex.cz, cuigaosheng1@huawei.com
In-Reply-To: <20220705005315.663920-1-cuigaosheng1@huawei.com>
References: <20220705005315.663920-1-cuigaosheng1@huawei.com>
Subject: Re: [PATCH] ASoC: codecs: wsa883x: fix warning
 using-module-alias-sdw.cocci
Message-Id: <165704713682.1050281.11385702156184888420.b4-ty@kernel.org>
Date: Tue, 05 Jul 2022 19:52:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Tue, 5 Jul 2022 08:53:15 +0800, Gaosheng Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa883x: fix warning using-module-alias-sdw.cocci
      commit: eec8a5f44e4f68c64ce21d90e438e31e85b92178

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
