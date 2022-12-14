Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908FC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Dec 2022 13:33:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8053D2A1A;
	Wed, 14 Dec 2022 14:32:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8053D2A1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671024786;
	bh=ZYr9Q/8Dak2rzozKFGnSn4t8C3Nckcsozp4ynaU2ZZc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/HMcjbwmyp3QfwFozTouOuU7m5aiB0Krekn6GJ1b9tsJ++4FJIspk+pLywDyCKGB
	 4eBVM950dMJXQ+zjLlxQFRl7Q1hx2QQBiB0yIfsUUq292N4/tnDkwDlyrJ8MKmXXw9
	 CdjGq5bOLsD6Z98NqC80OdBw1njkkevSLIXXCxO0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF438F80524;
	Wed, 14 Dec 2022 14:32:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92249F80520; Wed, 14 Dec 2022 14:32:03 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDAC1F80520
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2022 14:32:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDAC1F80520
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Q1RfAlmt
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B3B17B818A5;
 Wed, 14 Dec 2022 13:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723A4C433D2;
 Wed, 14 Dec 2022 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671024719;
 bh=ZYr9Q/8Dak2rzozKFGnSn4t8C3Nckcsozp4ynaU2ZZc=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=Q1RfAlmtJ8n8rU9JRMKuwkUIc1baBoRtMkgfHk/Rv1WAWgpPfotHX8RoyUyVGnwsT
 popMCTg2GgmjZI2AraHwzGszqqXmEEmy5gtCjK24yr9qqSNyNH8zShiZnnTz42oVg4
 TFAqXcpSJaeo1n0s614zRNaOGje16OB7chOx+wYciLsuotbuRuSwLlINjpzCt+9g+9
 fdsUG0wFpcQmiPDiK6ZQ4yx7ORwU0pqqMR2NV1B7Y6e70iA7sDyAceG1VMJZDfWxzT
 3r3+AVF64tSMtPtE0HjxkaGnypjO+Fzj7Z8i5Qk/kcy5D9n4E8bqSeR80pzIWXkbmt
 3CYSkudta7hUQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de,
 sugar.zhang@rock-chips.com, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Wang Jingjin <wangjingjin1@huawei.com>
In-Reply-To: <20221208063900.4180790-1-wangjingjin1@huawei.com>
References: <20221208063900.4180790-1-wangjingjin1@huawei.com>
Subject: Re: [PATCH v2] ASoC: rockchip: spdif: Add missing
 clk_disable_unprepare() in rk_spdif_runtime_resume()
Message-Id: <167102471719.27755.15684745065318413232.b4-ty@kernel.org>
Date: Wed, 14 Dec 2022 13:31:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 08 Dec 2022 14:39:00 +0800, Wang Jingjin wrote:
> rk_spdif_runtime_resume() may have called clk_prepare_enable() before return
> from failed branches, add missing clk_disable_unprepare() in this case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: spdif: Add missing clk_disable_unprepare() in rk_spdif_runtime_resume()
      commit: 6d94d0090527b1763872275a7ccd44df7219b31e

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
