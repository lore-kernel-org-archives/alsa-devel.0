Return-Path: <SRS0=ggqu=GJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12688C433DB
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jan 2021 14:59:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4295423110
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jan 2021 14:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4295423110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AF8E843;
	Wed,  6 Jan 2021 15:58:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AF8E843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609945183;
	bh=fs4tnAAHZc6P9CcCZmtXnqhshJdz+3INo0fDCULFaD8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNPLKXA9lkWgpH1DgG0ucWfmCrQynbc2BX6aM3s6FWL225ps+mGohmVlOGIsz8fDO
	 QvwbZbn7L0UnpI8eBKuG1gBDC0mBAXmkAaAVCnv/E67na9Y9ju6tHZ2Gt87BB+GyIh
	 IbYiNtuUQAcCDw2PgRfj4Mmx1Aeil0tnOGw7ffQQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91844F80165;
	Wed,  6 Jan 2021 15:58:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93E83F800DD; Wed,  6 Jan 2021 15:58:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9701F800DD
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2021 15:58:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9701F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="grRap1qA"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5D8723110;
 Wed,  6 Jan 2021 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609945121;
 bh=fs4tnAAHZc6P9CcCZmtXnqhshJdz+3INo0fDCULFaD8=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=grRap1qACe13qOi+OZcRSFbPBF+dIr/ws3L/0hIw9hJfGzIKvP7l6ogZ4IDw43yGy
 2LHdh5/KkLIX5OZy0HUphNkwfKucd730v8Tp6LLuzacbNiujVv7S8AcFgKaat4EO7E
 y+/PvinZw7ISykZaboaWt60Ak3aP6L6FH/2ur96+2LlVa2dRoeg/GHIVTXjbL9m+/N
 lmUrNwQGiW3vl9pfoybJQC9JwzVTaaO03pya7nRF3kZVYLga8QDzM2brjULMEAV5En
 tz4bM66daxGgVwHYO/b7ctz5giI8LEijCXhmI8MPhXeH67zs/Q6iAskX79k3QrpAy9
 gww2PkLy1Faag==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>,
 Dan Williams <dan.j.williams@intel.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-rtc@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-spi@vger.kernel.org,
 linux-ide@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, dmaengine@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Matt Mackall <mpm@selenic.com>, alsa-devel@alsa-project.org,
 linux-mips@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Vinod Koul <vkoul@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Alessandro Zummo <a.zummo@towertech.it>
In-Reply-To: <20210105140305.141401-1-tsbogend@alpha.franken.de>
References: <20210105140305.141401-1-tsbogend@alpha.franken.de>
Subject: Re: (subset) [PATCH 00/10] Remove support for TX49xx
Message-Id: <160994509314.52132.9683741232298303961.b4-ty@kernel.org>
Date: Wed, 06 Jan 2021 14:58:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 5 Jan 2021 15:02:45 +0100, Thomas Bogendoerfer wrote:
> I couldn't find any buyable product other than reference boards using
> TX49xx CPUs. And since nobody showed interest in keeping support for
> it, it's time to remove it.
> 
> I've split up the removal into seperate parts for different maintainers.
> So if the patch fits your needs, please take it via your tree or
> give me an ack so I can apply them  the mips-next tree.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[10/10] ASoC: txx9: Remove driver
        commit: a8644292ea46064f990e4a3c4585bdb294c0d89a

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
