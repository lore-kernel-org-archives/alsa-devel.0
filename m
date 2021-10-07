Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55341C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 21:42:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15D760F23
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 21:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C15D760F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 565EA168A;
	Thu,  7 Oct 2021 23:41:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 565EA168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633642964;
	bh=4vRh1y+xg/pfgwZWyOIc9oYS+SyNhWVKlApXMzlafFM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZwI6+O3M8GMoXyrWdP/C95P5NP1nBJTRPPc1BVH5xs+GywVMAl13M02/JtPrZmKF2
	 0Xprdhq4UAHnirJBHsEfDM55rltRn9mz+2sw6iglkfywQb5IVwtPfSoFuzslP6aJcg
	 qul6cnQgJZd2RJeclT5ceJOspwwAVUhDJPvsay4Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 167C6F80533;
	Thu,  7 Oct 2021 23:38:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 222A4F80528; Thu,  7 Oct 2021 23:38:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D7FEF8051C
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 23:38:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D7FEF8051C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qk+xMv47"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F86B61245;
 Thu,  7 Oct 2021 21:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633642690;
 bh=4vRh1y+xg/pfgwZWyOIc9oYS+SyNhWVKlApXMzlafFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qk+xMv47J8u8vh4QEs92r0oEkKY4tQReLijaMwkLCJDbxpMGAKb6Is8y7+feI7RvE
 pp3akkZeROrwMosXVTOt/Lu0ulZX5o5Btdvkp+5bqj+mSqlPQBwTV9+93UfpPS5Ypr
 qryJocO/3lgs+VVhBWxpxs2kHfZchef/OnAgIZ+rphytjuU09fRPtvlS65wUMe5nkd
 GXdy6kCg0TUpp6xa+G/hmE6d4h8DBGsp0rJe7zsPS+Ykshz6PtrWg1Uo2zB0fGksxm
 rhlSNRO1xEJEGjZw0CVezPdJXgonfmA6MakV2ZHUr5Yd6r2gYJ17CWMLuLdEBII3jf
 yAWq16282CdKg==
From: Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org, agross@kernel.org, rohitkr@codeaurora.org,
 robh+dt@kernel.org, perex@perex.cz, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, swboyd@chromium.org, plai@codeaurora.org,
 srinivas.kandagatla@linaro.org, lgirdwood@gmail.com,
 judyhsiao@chromium.org, bgoswami@codeaurora.org,
 linux-arm-msm@vger.kernel.org,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, tiwai@suse.com,
 bjorn.andersson@linaro.org
Subject: Re: [PATCH] ASoC: wcd938x: Fix jack detection issue
Date: Thu,  7 Oct 2021 22:37:34 +0100
Message-Id: <163364264608.649699.14554141644947512653.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1633614619-27026-1-git-send-email-srivasam@codeaurora.org>
References: <1633614619-27026-1-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Venkata Prasad Potturu <potturu@codeaurora.org>,
 Mark Brown <broonie@kernel.org>
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

On Thu, 7 Oct 2021 19:20:19 +0530, Srinivasa Rao Mandadapu wrote:
> This patch is to fix audio 3.5mm jack detection failure
> on wcd938x codec based target.
> 
> Fixes: bcee7ed09b8e (ASoC: codecs: wcd938x: add Multi Button Headset Control support)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd938x: Fix jack detection issue
      commit: db0767b8a6e620b99459d2e688c1983c2e5add0d

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
