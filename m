Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00433C07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:58:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6D560FEB
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6D560FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 617601654;
	Wed, 14 Jul 2021 17:58:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 617601654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626278332;
	bh=SKCnb/eIuTrVyunpch/wIe19Xz1rsgxRCQg61kM4o5Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G3F6+vtd1qKwpFowS7Pl0nEXzaraJkfSb60USwbT/z5TM4Jblt8IM0qW8/FTeQTBe
	 SisG7hF8SW1vNY9TsNEXgCy7UfRUFBppl7rtdyE+6V9ZIk5IUMRwR0Tgz4icSOVFOb
	 OfrQf/evDt2vLev94rhsF+mGF1ndqXec7IVg1KBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27040F804E7;
	Wed, 14 Jul 2021 17:56:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 169FCF804DA; Wed, 14 Jul 2021 17:56:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B8D1F80300
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 17:56:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B8D1F80300
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J3G8yvhX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C76660FEB;
 Wed, 14 Jul 2021 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626278180;
 bh=SKCnb/eIuTrVyunpch/wIe19Xz1rsgxRCQg61kM4o5Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J3G8yvhXUAmhRLOFvwIkrw+DX/J7EymymYfHm3RspRr24QPHVsZxHEh0TVTC+f31v
 NHHjT3N09kaS14Rr1vaejUP8nkjnty3JyItST0/u6F8hjlhbkwhqT8g40kba7312/L
 SXf6xUBJSNwJ3tRCComaFi9TKmzPYQdvzYpOkdJfwOQ04BH+i9+BXF+Oh3TfACo2X2
 a1yFuBPoA0FdqwNmisv0NAA+OiGc4ejVuQaoFtnE+mZqEPJmWtyjB/lyRZ17zQX9Uh
 r97+AMZ0CfbdGnkAYUuXlqkDZx/uk8sNPeGrOgr+GY+lxyeHl7G7ooNWb4o5g0vvPg
 ew/tqTSJT5YCA==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Dmitry Osipenko <digetx@gmail.com>, Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: Re: [PATCH v1] ASoC: rt5631: Fix regcache sync errors on resume
Date: Wed, 14 Jul 2021 16:55:21 +0100
Message-Id: <162627737185.54838.4180550842494082478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712005011.28536-1-digetx@gmail.com>
References: <20210712005011.28536-1-digetx@gmail.com>
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

On Mon, 12 Jul 2021 03:50:11 +0300, Dmitry Osipenko wrote:
> The ALC5631 does not like multi-write accesses, avoid them. This fixes:
> 
> rt5631 4-001a: Unable to sync registers 0x3a-0x3c. -121
> 
> errors on resume from suspend (and all registers after the registers in
> the error not being synced).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5631: Fix regcache sync errors on resume
      commit: c71f78a662611fe2c67f3155da19b0eff0f29762

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
