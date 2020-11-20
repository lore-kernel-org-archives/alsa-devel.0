Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E91C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:32:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6B32236F
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bQsagnt7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5SZNLLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6B32236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D773D1705;
	Fri, 20 Nov 2020 22:31:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D773D1705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605907965;
	bh=ChN2HwJmi1NiaE5ruSOq55VIUBiypuDKYbGvjhfCUfE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bQsagnt7xKjdnc//piXZLudjQ6/FNXBnxTs8cdNwwHvRX3kO8PzNY28Y5nfsr/zMG
	 T2AndxKjhzrPxydpRzPNgSXFWk1B2XUcU9HxbmWzu7WYfC5MF1wonLNTHwlFAKQ8Xr
	 9RSmoXwSzR2+V3zuuwm0fOwyALsaPt2zWyetTd8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E589F804D8;
	Fri, 20 Nov 2020 22:29:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6BF5F804DF; Fri, 20 Nov 2020 22:29:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B47FF804D6
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 22:29:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B47FF804D6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T5SZNLLS"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 03D382242B;
 Fri, 20 Nov 2020 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605907783;
 bh=ChN2HwJmi1NiaE5ruSOq55VIUBiypuDKYbGvjhfCUfE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=T5SZNLLSgvXsTE/DPUom4tWkzvM+dTF9fgX80/HVIr62l/+P+rVb+uL3EUzmgNIch
 7LwOo3/mqAZ3Z3n1NZgPIjYfRnV09ahGZYwJZ64L7r7sGK8J8G/7Asy9BHDtfGxnY6
 lYkPyjPpK5z5NN//vdgP+Nq8CZVWF+Gw/+7Xmj0E=
Date: Fri, 20 Nov 2020 21:29:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Kyle Russell <bkylerussell@gmail.com>
In-Reply-To: <20201119034106.1273906-1-bkylerussell@gmail.com>
References: <20201119034106.1273906-1-bkylerussell@gmail.com>
Subject: Re: [PATCH] ASoC: mmp-sspa: set phase two word length register
Message-Id: <160590773742.47461.544548810394256009.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, lkundrak@v3.sk,
 linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
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

On Wed, 18 Nov 2020 22:41:06 -0500, Kyle Russell wrote:
> If hw params enables dual phase transmission, then the word length for
> the second phase should be set to match the sample format instead of
> remaining at the reset default.  This matches the configuration already
> being done for the first phase.
> 
> This driver already sets the phase two sample size, so this should complete
> the phase two configuration.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mmp-sspa: set phase two word length register
      commit: 82d1aeb8a40740cf4208ce864cbcaa5e8bbabf4e

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
