Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B91C6377D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 17:11:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB1361183
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 17:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB1361183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 187E416C8;
	Thu, 22 Jul 2021 19:10:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 187E416C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626973884;
	bh=S9RLm3DeCynN9zkZ256FLf6Mf+VCn99E3vt5kQyes6c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wwhv++Lv5khjza7bbZlkzI8LDoY6vTY2ueOZnit181jdN9LgrJQRG83DAxMvep8Bv
	 nm4bVrL53OzgjlUjeH7ZEzD5sBl5QGSNvzeg5Irdr0oQHiUPfJebrauY7+sap79Qvv
	 PEP+oWfZI6MVtmJtU/+8PP9MnIxkIXGNviCQt0Os=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A00EF80227;
	Thu, 22 Jul 2021 19:10:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CD1EF80256; Thu, 22 Jul 2021 19:10:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDBF6F800F2
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 19:10:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDBF6F800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SQ6i9hrO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 880FF613AE;
 Thu, 22 Jul 2021 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626973828;
 bh=S9RLm3DeCynN9zkZ256FLf6Mf+VCn99E3vt5kQyes6c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SQ6i9hrOpByFJvENrXxAm+UmW/0r7dBui3Wcka9bhsVvNMEpPUyhPYhwLlrQNP1Xo
 zhIVVepNL6GnL0EWw29hb0zLP5GhSAfVwIT/6x02583VN+ujUjiiKtwQZAwNorjW5T
 Q19gBHS5TkIOYXL5RymXGhkUjlos/UDmqHSWZolEv5rping4y0LLPIuY6CFb9RWJ8i
 pmMlfEbw3KoXEaMRh8GzW2hYOYw+CApYPYPnQh9rHc0EXn22TgwnvbU9myoLodztFj
 xjlcVvR68duiYClJsykVcdkTf03UF+1kzC/MzM1YYJme7nXs7014WxgcL4P45xPmRe
 iC9c+oceRSQEA==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: amd: renoir: Run hibernation callbacks
Date: Thu, 22 Jul 2021 18:10:01 +0100
Message-Id: <162697068326.1747.9231043846370414318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210721183603.747-2-mario.limonciello@amd.com>
References: <20210721183603.747-1-mario.limonciello@amd.com>
 <20210721183603.747-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

On Wed, 21 Jul 2021 13:36:03 -0500, Mario Limonciello wrote:
> The registers need to be re-initialized after hibernation or
> microphone may be non-functional.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: renoir: Run hibernation callbacks
      commit: d00f541a49406afc2c091aac121e29b3b61480a2

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
