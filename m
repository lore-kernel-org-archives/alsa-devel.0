Return-Path: <SRS0=yf6i=MS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B3AC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 21:35:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A13660F6C
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 21:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A13660F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AC9D1DF4;
	Mon, 26 Jul 2021 23:35:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AC9D1DF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627335357;
	bh=0eUNpaZZ6ueHgtkXpBbhh0wR09QD1sB3ybYVv+8S8PA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CqPY1wk1viN9ucQXKJf9GYZNkCTqouNj3qd/3k1/wUT6az7xwHMIfGTARkiJt7kkG
	 XxC6KApGgpYfG5UM5gX1lzZUvlL/Yd3aWrWVMrhbPQUrOZebLRbojaRN/k6NPaHSgO
	 +AnPJb++nmeMkRqlSJUfWUAHhJ0a7wzckvVDcCJU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92790F8028B;
	Mon, 26 Jul 2021 23:35:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 425D9F8028B; Mon, 26 Jul 2021 23:35:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C104BF80253
 for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2021 23:34:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C104BF80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SKhKEwAT"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8DD260F6C;
 Mon, 26 Jul 2021 21:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627335295;
 bh=0eUNpaZZ6ueHgtkXpBbhh0wR09QD1sB3ybYVv+8S8PA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SKhKEwATCV/CqsbvPKCjIJhsKPeiAcMVIvSwwfR4qtFzGDWKiClqgdzeLTKpqQ0fq
 UaNZ+3SmwvvLtMmWWa7x5u1wmcRAf8J7kpi1y2MR+hQX7Iu//Bw3pzdr4o8EJX9lbG
 9o83WnxtGvQQ/2tpqmnyUgSJv45jMQJqY+7opUDy7vmJDzF83QY4Z7Qkq42OOFd9BU
 en7axm8txpX276V8jA3whDYuTQJQWx4hciFssGezujyD2FXeWmOUYtqr2jjeCYIAG4
 b9GTY6DJpZo3syYLES+u69MtBgAly49P8+gWthTD06irKit7dscAco25t/K49Ldz8Z
 mWaY4uFcaaYog==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Brent Lu <brent.lu@intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_da7219_mx98360a: fail to initialize
 soundcard
Date: Mon, 26 Jul 2021 22:34:42 +0100
Message-Id: <162733475033.22497.13925594372181904569.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726094525.5748-1-brent.lu@intel.com>
References: <20210726094525.5748-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Paul Olaru <paul.olaru@oss.nxp.com>,
 Zou Wei <zou_wei@huawei.com>, Rander Wang <rander.wang@intel.com>
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

On Mon, 26 Jul 2021 17:45:25 +0800, Brent Lu wrote:
> The default codec for speaker amp's DAI Link is max98373 and will be
> overwritten in probe function if the board id is sof_da7219_mx98360a.
> However, the probe function does not do it because the board id is
> changed in earlier commit.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
      commit: 0f32d9eb38c13c32895b5bf695eac639cee02d6c

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
