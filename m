Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4B6C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:58:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE14961029
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE14961029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 804E7166E;
	Mon, 13 Sep 2021 12:58:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 804E7166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530732;
	bh=qVDEd4KPGzwlXD7REl4gi3XNnBFXMku8Vz1o29jsDWo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mtP8enkoXkBvjtZ/wHdmsrp1d+nibZllIxG87qq3oBlqG0ThMXzIClJAI2DWG+aY1
	 mdPTaKVjBLw/bi0/FAocoFa6S/CliyiQDUdCD5ccesNoECwsSOMNjr39z46jlpx1yI
	 ebpoWEPWbLCU/zxXn4Xb19DnYZWjVmS8wL+/zJVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02BB0F8051F;
	Mon, 13 Sep 2021 12:55:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76F07F80510; Mon, 13 Sep 2021 12:55:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFE85F804FB
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:55:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFE85F804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Kn0pYiZ/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 759906103B;
 Mon, 13 Sep 2021 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530502;
 bh=qVDEd4KPGzwlXD7REl4gi3XNnBFXMku8Vz1o29jsDWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kn0pYiZ/IyDNur0YZLsxyjXh+Ej6lL1Bg+fVYqkCh5e9kkHMXFDzm4C3ZsHvsOYeJ
 +rbpcUPsDLtJYwYYJo9xukdBBq/3pkn18zo8SnHY0g/c5yjHhZrCJPVYmlAohMuayz
 Z2zP4hn8k9dMysdbEG4JT20NvPSG+dFFMntoVh9Jd3dw3d+N2iUOio6jhZ02nC71zT
 WCC4MYRZP8CT9bRuHofdoEF7zP/jwDVw7ffDvz9as6MrpEs/W+L/CH8Duk+ZJFZAYw
 WBQ5v/XpEay2L25mKi9krzGUM5sUyLkzLGtR0faaZx9Uj+pyp6Ym+2X5ZG8tUn9AvM
 i2wy/e0j+jZSw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Remove unsued irqs_lock.
Date: Mon, 13 Sep 2021 11:53:23 +0100
Message-Id: <163152996586.45703.9396342816792427705.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210910094847.3430413-1-bigeasy@linutronix.de>
References: <20210910094847.3430413-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
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

On Fri, 10 Sep 2021 11:48:47 +0200, Sebastian Andrzej Siewior wrote:
> irqs_lock is not used, never was.
> 
> Remove irqs_lock.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Remove unsued irqs_lock.
      commit: c3815f8bc777370999ced0b6b6f846094b33d583

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
