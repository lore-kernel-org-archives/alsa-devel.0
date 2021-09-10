Return-Path: <SRS0=kM0A=OA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E1EC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Sep 2021 16:11:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1857D61207
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Sep 2021 16:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1857D61207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B287216B5;
	Fri, 10 Sep 2021 18:10:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B287216B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631290281;
	bh=6iwvSZ8jp5kA04e1JPK/6mq3OGC3NvF1BQ05VjMVO44=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ctYCco/1zi6+wfkGw5sGLTKF94A48RWAWO77PVGjLlWyfYQUqZ02PmIN0ni39Rok1
	 bugBTow49P3iA1PjUlToc5J8iRwdnM9oNgM9PzD0H3/Zu18Wf9FJB3o3yXjn5J7ggZ
	 ptZhcXqZDgnE9ob+Mrt00TrrG9hW7EbRPHBwYgTU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D7AFF804E5;
	Fri, 10 Sep 2021 18:09:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0A1AF804C1; Fri, 10 Sep 2021 18:09:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87E20F800FC
 for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2021 18:09:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87E20F800FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pcC5QJb8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A12E6120E;
 Fri, 10 Sep 2021 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631290168;
 bh=6iwvSZ8jp5kA04e1JPK/6mq3OGC3NvF1BQ05VjMVO44=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pcC5QJb8RtxJmQaU4B5d5Mdkn6sEJg/KPx0G91ox3184J8N9EzSFWxk1eXPcICBee
 5lf5KiqJ4ZGpyLfB9y4kmS1RDe1WrgMXHcvTgNxxhK/efnCZlLHkJ3hIKBmQWcJEIq
 rhW/CKt+6BNFS5Ag+AT3v2njZlt8s2Qq+w8uswkVawHiDsBYHyR7KI9yVvbR+HYWn0
 36TfFaWGnw9VSy83g2InmoTMWH+YX6o0/Y224ROLV844IKkTqdGfXcygRq7SrJQp+4
 9mTUQwhdbb/hUZkwEXUyiBcH6+eB+64m72ZG2vma4t0LBvc+/vTohNZPz+hMQ5f/Hu
 x8AqofQYhapoA==
From: Mark Brown <broonie@kernel.org>
To: matthias.bgg@gmail.com, Trevor Wu <trevor.wu@mediatek.com>, tiwai@suse.com
Subject: Re: [PATCH v2] ASoC: mediatek: common: handle NULL case in
 suspend/resume function
Date: Fri, 10 Sep 2021 17:08:45 +0100
Message-Id: <163128974014.2897.15699318985041527361.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210910092613.30188-1-trevor.wu@mediatek.com>
References: <20210910092613.30188-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dan.carpenter@oracle.com
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

On Fri, 10 Sep 2021 17:26:13 +0800, Trevor Wu wrote:
> When memory allocation for afe->reg_back_up fails, reg_back_up can't
> be used.
> Keep the suspend/resume flow but skip register backup when
> afe->reg_back_up is NULL, in case illegal memory access happens.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: common: handle NULL case in suspend/resume function
      commit: 1dd038522615b70f5f8945c5631e9e2fa5bd58b1

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
