Return-Path: <SRS0=Qkbk=MV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD4C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 16:41:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5E860EFD
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 16:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F5E860EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9311217B2;
	Thu, 29 Jul 2021 18:41:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9311217B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627576917;
	bh=U0R/r/foYlfwkOscqf6KiXDujDojG+Hqa8VkU2XkPDU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nYJBX0rhKy57jxegp4PIBLE+QhfHW7eKgC38l2NWjBM8WE9guwiUQM7ZJNQJJECph
	 21jYWvKQgmY5fm3XwUmgGwyF0ElZLXj/S15lL23ohOJ/AVkxoiOyr1rHFl7ObUztaT
	 vq870Fe8wUz5jK631fTRz8ASR2YjfwAgMK9CJIMo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 424E8F800E9;
	Thu, 29 Jul 2021 18:40:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10DDFF80258; Thu, 29 Jul 2021 18:40:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9499F80258
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 18:40:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9499F80258
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="byFuzIP5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68FF760F0F;
 Thu, 29 Jul 2021 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627576802;
 bh=U0R/r/foYlfwkOscqf6KiXDujDojG+Hqa8VkU2XkPDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=byFuzIP5Rp1XILovz8ekfTsshsx2cxMhVG4T5m6GGxdiahyujxq7JGuNmKLCWR2vd
 Uw7n40YXQK0sBfPEQT8ZwKsK6x+sgVvdhcpMpl+P5dFW9Wc7Ms61ZsZp7Vo+/1CQni
 9/pJzSs4VvCfqjBijtSQLrdIXwUrE+rrx/zaJaccIh35yXZufiqxX4S8tHY4uIfRcB
 3fB2Y/Qli77vhFxANN0kpHCq+IKV6ZH6k8rF3SVhdkk6i2sCWD0HNUvMO/rb5dWDrw
 CbRT+wmAZX1xT8QiEgcjpJCgPpAxY4swRziXNp13x/5i+2SptChfC7C71ihOvLsW2L
 ZwRj+zfpxTYSg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Takashi Iwai <tiwai@suse.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: samsung: Constify static snd_soc_ops
Date: Thu, 29 Jul 2021 17:39:46 +0100
Message-Id: <162757633787.53168.13521018691964426558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728172548.234943-1-rikard.falkeborn@gmail.com>
References: <20210728172548.234943-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
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

On Wed, 28 Jul 2021 19:25:48 +0200, Rikard Falkeborn wrote:
> These are only assigned to the ops field in the snd_soc_dai_link struct
> which is a pointer to const struct snd_soc_ops. Make them const to allow
> the compiler to put them in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: Constify static snd_soc_ops
      commit: 2080acf3d18029ca52189a14b2ee462ea89c5d06

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
