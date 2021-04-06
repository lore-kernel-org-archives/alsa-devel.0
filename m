Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8352C433ED
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 17:42:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0276113C
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 17:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0276113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7085A83E;
	Tue,  6 Apr 2021 19:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7085A83E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617730952;
	bh=gLki/Xmys1/KD/LzsvZQ8VQy1gbMhA3oTJt1qS4L15w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GvzdYRb74Suod8Dvznx4E1dCAUqDad8E8ZeFYnYuFEGZYqpG9O786BvctTMIDrfYg
	 t51MrZfjJ4OBfv/YQmsLP0PqA0QvPYFJjDrDzwxKvsTOOzASxg8IePTtc0yATMmJ77
	 E6pJiq3lPipAzgz2yKK8JpbKi0xt+MZBsjn8Q1KM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F934F80424;
	Tue,  6 Apr 2021 19:40:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88679F80249; Tue,  6 Apr 2021 19:40:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB636F80169
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 19:40:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB636F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cgPyYReC"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF8B7613E5;
 Tue,  6 Apr 2021 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617730805;
 bh=gLki/Xmys1/KD/LzsvZQ8VQy1gbMhA3oTJt1qS4L15w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cgPyYReCuO5YST0aI+xw1Kl1DutdnYyZSvPM4OYYK6GBNZTzvObQDwemy9efjLLOH
 Bs/Boy5472poeWiP7bg5qA03vSrVKiV128Fw00IO7bRRLXDhyH/T1wcUyl+8fFlgsD
 Wkxe1qTb20wh7lXgZA2g06l05Hs8fk8+8V7+dh4TXftjyal+lztRib1Ym5OoL0nC8x
 US2lfygxBe7boBmpthLZzfr7+60oa0KeUY/R1ifDArPEk0PFR0vkmJZXHBh6mIt+bK
 Rb1wKDcF9eepBPyZ1qQ7WAHLF6nT1D6+8Y9PM12X3QHfUNmJ0czh3Bn1+DslNc0fZA
 E/0Rn+nYKIzDw==
From: Mark Brown <broonie@kernel.org>
To: Annaliese McDermond <nh6z@nh6z.net>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "perex@perex.cz" <perex@perex.cz>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 0/2] ASoC: tlv320aic32x4: Bugfixes for tlv320aic32x4
 driver
Date: Tue,  6 Apr 2021 18:39:40 +0100
Message-Id: <161773049107.51713.3511483011411927627.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <010101788984f9d0-64bcaa85-ce13-49dc-bfc6-892a6a4e411e-000000@us-west-2.amazonses.com>
References: <20210331182125.413693-1-nh6z@nh6z.net>
 <010101788984f9d0-64bcaa85-ce13-49dc-bfc6-892a6a4e411e-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: "team@nwdigitalradio.com" <team@nwdigitalradio.com>,
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

On Wed, 31 Mar 2021 18:21:36 +0000, Annaliese McDermond wrote:
> These are a couple of bugfixes for the tlv320aic32x4 driver
> that we discovered after the Raspberry Pi Foundation's move to
> the 5.10 kernel.
> 
> The first increases the maximum value in the regmap configuration
> so that the powerup command actually works.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tlv320aic32x4: Increase maximum register in regmap
      commit: 29654ed8384e9dbaf4cfba689dbcb664a6ab4bb7
[2/2] ASoC: tlv320aic32x4: Register clocks before registering component
      commit: 1ca1156cfd69530e6b7cb99943baf90c8bd871a5

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
