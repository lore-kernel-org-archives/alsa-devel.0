Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E86C4708F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 16:19:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5395561950
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 16:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5395561950
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E58BC170C;
	Wed,  2 Jun 2021 18:18:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E58BC170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622650768;
	bh=H32PM2qecRNYvcKFMj5jWRXRrg43aAUqm+2D/jxKv9U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j5CU+/GhCAExd0zQwp3xQdhrBJP5l1sj/Ye4nyFVNGhCZRH6dpcg/rAwd9H6eBP/r
	 1xmL9VMR8hydYTzSO1AlUYEZtIimaRwKZ4frkJ9mRGzJHn3ZUvv3vWMISOt3DVV0Hr
	 MfmfOkh7KDcDHzQKGvE2HqFfjLAe4lBLg2fY71P4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 957F5F804CC;
	Wed,  2 Jun 2021 18:17:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41058F804BD; Wed,  2 Jun 2021 18:17:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65E6CF80431
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 18:17:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65E6CF80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WcfPF7Mc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FDB86161E;
 Wed,  2 Jun 2021 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622650648;
 bh=H32PM2qecRNYvcKFMj5jWRXRrg43aAUqm+2D/jxKv9U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WcfPF7McSmUw1KIX/TI/lOH34wZWRcEz25+xcSu1iQJVGcIxs+Pjt55PF9UCdWrAK
 j+C2Au7Fov+X2vw74KTFYZ1RuVs0RchIHVkHogmQWWuLgN7MpJiPAHmtOFW+k4lpjs
 miUDN1tcCKruXMQ2Br3RAupY6MB5Nr7m7FA9RRUoSUdVQ8eJ+WqdL4gZpuX2nirUSY
 vT5Q4Jst3KJ6H1VvcIjo9rjrAWWRYLyuuw/7s6+Lt1PoK+hc8kddNkkD9L/8zx7YtF
 EgTeuu+260d6RuImszYStJW/px+77eI3eo7HSxt7JPA4m+Hp+94Haa6UdU3iNnZ2uN
 VsXdha6ieN1/A==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, yang.jie@linux.intel.com, perex@perex.cz,
 liam.r.girdwood@linux.intel.com, YueHaibing <yuehaibing@huawei.com>,
 cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH -next] ASoC: Intel: Skylake: use DEVICE_ATTR_RO macro
Date: Wed,  2 Jun 2021 17:16:54 +0100
Message-Id: <162265045454.22459.4494001129448611734.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524115506.35724-1-yuehaibing@huawei.com>
References: <20210524115506.35724-1-yuehaibing@huawei.com>
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

On Mon, 24 May 2021 19:55:06 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: use DEVICE_ATTR_RO macro
      commit: ae624a38be37e1a3127d5fa32c996e09974bb88d

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
