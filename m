Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C2AC48BE8
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:55:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A500A6124B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A500A6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEF8A1677;
	Mon, 14 Jun 2021 21:54:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEF8A1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700541;
	bh=OFqLWt9YcU2q5M/HjfpqEhWhcGqRS3yWcy7sAyaGMeE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sYWt9WCm/gov5FKTFuSU8/Ng8UIdO5BFEkwkQ5ztmg75Kd5N49o/u9zXn9zG+oWly
	 j1OXm5+L4nVpYTqdIBJCKbgzXus7xJiM9qSUxScHR0FkE3SONTuUmM489wk2L/yqff
	 PrGJNA4BFO5D4Cee9/He1FB9OhUzIcSkScMK52qI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81412F804B0;
	Mon, 14 Jun 2021 21:54:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 421A5F804B0; Mon, 14 Jun 2021 21:54:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9A92F8025E
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:54:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9A92F8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XXHHa4xq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B0DB611CA;
 Mon, 14 Jun 2021 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700480;
 bh=OFqLWt9YcU2q5M/HjfpqEhWhcGqRS3yWcy7sAyaGMeE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XXHHa4xq/Isu9+95fpnbyi2ZUuVcWVETqOU2y5lYYjop2Z0KMVbhP99crM0rdDsD0
 MmwcnZuz6xNJx8gLnUL3pkCyU4tHYbxoF2AP57ivb7ZUTvaKnJJXfkOtWKM8+gbnVc
 z9vnoM8eg9dpGInpzCPv0moeAhHkdqNPEfK7zZER93LoN5HgFN67rx9M9WKqq8Umfa
 D9QyOkL1yrYAk8h0i2owJypIHiSZ7qPegPaURJ3hYaLaMDtKbiTgoLV35d6zln1GRP
 Sfyk/nM9dKthDNMD0AmoOLGy4NsMvkl6C+RgK/L/ORbju9cSDjO2rGYFu+4hzAMsEr
 89swlSD9TdVSg==
From: Mark Brown <broonie@kernel.org>
To: timur@kernel.org, tiwai@suse.com, Zhongjun Tan <hbut_tan@163.com>,
 nicoleotsuka@gmail.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
 festevam@gmail.com, perex@perex.cz, Xiubo.Lee@gmail.com
Subject: Re: [PATCH] ASoC:fsl_spdif:Remove superfluous error message around
 platform_get_irq()
Date: Mon, 14 Jun 2021 20:53:39 +0100
Message-Id: <162369994008.34524.18042209109927514476.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610040037.1064-1-hbut_tan@163.com>
References: <20210610040037.1064-1-hbut_tan@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Tan Zhongjun <tanzhongjun@yulong.com>
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

On Thu, 10 Jun 2021 12:00:37 +0800, Zhongjun Tan wrote:
> The platform_get_irq() prints error message telling that interrupt is
> missing, hence there is no need to duplicated that message.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC:fsl_spdif:Remove superfluous error message around platform_get_irq()
      commit: 2e8a8adb96a335a04f1697dd4314f5569521328f

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
