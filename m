Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E18C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:19:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0E2206E2
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YX2QlJS5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJKICZoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0E2206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11F6315F2;
	Tue,  7 Jul 2020 16:18:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11F6315F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594131547;
	bh=Bkr1sJE6MHpMBdzGYUrae/nUqd3maLrYPUOVhB4MWYs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YX2QlJS5RUqvb7mlZF13gjV010ce+vlDhoXHIVx469sD31pBXAsM+7vyyGRYXzpfv
	 2aLxOYNEzCiwa0tznZ8t6rl3zGvsZ9kG0TaEI5MpaQ9NbvLC6OCFFUM0KL5HnBWXXq
	 vFKpQsmYHHH8K0cy2Wwmz1+kEX5OYmugv4GMiVcY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40F53F80264;
	Tue,  7 Jul 2020 16:17:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DA03F800D0; Tue,  7 Jul 2020 16:17:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A9B4F801F9
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 16:17:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A9B4F801F9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZJKICZoQ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B72A5206E2;
 Tue,  7 Jul 2020 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594131429;
 bh=Bkr1sJE6MHpMBdzGYUrae/nUqd3maLrYPUOVhB4MWYs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ZJKICZoQrSbQqf5SOF8X8qh1ZY9PMow61xgUmYYc6dGWS+YBDxm8gvfWEIceRxhRI
 ix35QjXVhtOrKFUhATS8QUBJ0EU3P8OueIXNguNQFSsQ2FIP8B3f0ejhHbm5VRUGdC
 lklgqccDf54snCmsiLqm4m9BNC+XwM/Oaoj0GTtc=
Date: Tue, 07 Jul 2020 15:17:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20200626164623.87894-1-sebastian.reichel@collabora.com>
References: <AM6PR10MB2263094DD176499308EC8B2A80B80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200626164623.87894-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCHv4] ASoC: da7213: add default clock handling
Message-Id: <159413142466.34737.7602523074048381134.b4-ty@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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

On Fri, 26 Jun 2020 18:46:23 +0200, Sebastian Reichel wrote:
> This adds default clock/PLL configuration to the driver
> for usage with generic drivers like simple-card for usage
> with a fixed rate clock.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7213: add default clock handling
      commit: 5146b6a92c1194674f21def93d7025c97ed6977f

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
