Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533D0C2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:58:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B8D6124B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B8D6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 704621690;
	Mon, 14 Jun 2021 21:57:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 704621690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700682;
	bh=9BrKXrQD+oi74tGWcEiEkzvbIWYd6bnHC+gYS3fPliA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=esvkdKlZWgos+XfLIyWlkyqsvdg0s3uquFDTfLmj9zicrBcPIILrtubIDvEhsBaAY
	 5t496yj4n6kQUcrV3XKJ1Zdrcw/SYt0EX9WgvBVtFZDqBJSVmCkb5yCfnNwwZeFBV3
	 9mTuXB3CTNnzf5rZac678kLHgOHzMbPFKOoNntcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9CC7F804EC;
	Mon, 14 Jun 2021 21:55:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A882FF804D8; Mon, 14 Jun 2021 21:54:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25BC2F804CC
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:54:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25BC2F804CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ODI9FQJY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F76061166;
 Mon, 14 Jun 2021 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700493;
 bh=9BrKXrQD+oi74tGWcEiEkzvbIWYd6bnHC+gYS3fPliA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ODI9FQJYo22izIiQbHH8d6ufa0jnMTDljnAEcK2Gg/EfeOm2dKocNuE4FPZzNqT1T
 zUNVWg/lm/3+dYg+EKEI1+gu2873WF7ksIHhIP2gEoR5mxwhgJELN33pgEvUtcyyyT
 C/k1zOIVX2vg4uOjc3MfDWaztg80AQe0KTFm1I4YJBeDMYKk7eJ4gTMCoVlkJfIhlM
 BP7z6GjNQI4JLzuA5tt+QCOHfSPSgPoQCLyttWfNG1EDwv0eHCUwiWV8eZm0LAylPS
 fCnT+mVnAYx1WPWPVmIme5CVTCPG8nF5Qbo3/kG3f7AYMKBx23RjYeYNXJvV6JgqJs
 OLgERF4IEGRmw==
From: Mark Brown <broonie@kernel.org>
To: timur@kernel.org, tiwai@suse.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
 alsa-devel@alsa-project.org, nicoleotsuka@gmail.com, festevam@gmail.com,
 perex@perex.cz, Xiubo.Lee@gmail.com
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix error handler with pm_runtime_enable
Date: Mon, 14 Jun 2021 20:53:44 +0100
Message-Id: <162369994009.34524.13362380080934583613.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623392318-26304-1-git-send-email-shengjiu.wang@nxp.com>
References: <1623392318-26304-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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

On Fri, 11 Jun 2021 14:18:38 +0800, Shengjiu Wang wrote:
> There is error message when defer probe happens:
> 
> fsl-spdif-dai 2dab0000.spdif: Unbalanced pm_runtime_enable!
> 
> Fix the error handler with pm_runtime_enable and add
> fsl_spdif_remove() for pm_runtime_disable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Fix error handler with pm_runtime_enable
      commit: 28108d71ee11a7232e1102effab3361049dcd3b8

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
