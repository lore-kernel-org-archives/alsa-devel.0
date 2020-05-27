Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166ADC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 15:02:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813872088E
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 15:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U4TUCWnK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGmpzXZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813872088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA56417A1;
	Wed, 27 May 2020 17:01:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA56417A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590591734;
	bh=A1rZCKGNuvf1MTV654hcIRa9McjyaPyThd8WHu7x8iw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U4TUCWnKSJsztUcZcW1otJoVPbMVc1eBeKRL4cu8FsJkRm0YcCP7NyQMWt7ZpOee2
	 rJKIOSxG1DREBv37gk1AWywM/p/Es/enf4ckBFQq+ZIZqY6WY3liDZbHbAAIRrJ+UL
	 LOUdRJ9yXhwAnS6ziPRmy1mAkjbqHN2eM3IvXubw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E7CCF802C4;
	Wed, 27 May 2020 16:58:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EB62F802D2; Wed, 27 May 2020 16:58:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1645BF802A9
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 16:58:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1645BF802A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eGmpzXZ5"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 17FF420C56;
 Wed, 27 May 2020 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590591503;
 bh=A1rZCKGNuvf1MTV654hcIRa9McjyaPyThd8WHu7x8iw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=eGmpzXZ5yvoRCPYJlL3WlCT9MB8J7dDGXXkbVHgwB4Qx1mUlhWw1WHaJLZNNjULbP
 qh0bo2V15YxYUewddeFr5AQQo/0mlF8ZYoLZBeO9H2fQDHcnjOQLsRW/kyt+bdAoLC
 s/TJHkmaGqIJkx5RPn+ulOGytU/gu5aHknnSihls=
Date: Wed, 27 May 2020 15:58:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
In-Reply-To: <20200527084326.4131-1-dinghao.liu@zju.edu.cn>
References: <20200527084326.4131-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] ASoC: img-spdif-in: Fix runtime PM imbalance on error
Message-Id: <159059147354.50918.16899788154507501504.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
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

On Wed, 27 May 2020 16:43:24 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-spdif-in: Fix runtime PM imbalance on error
      commit: 53865b3259554389e40aeead392151c819b52a71

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
