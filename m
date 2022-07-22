Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6DBC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jul 2022 19:40:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7B04184C;
	Fri, 22 Jul 2022 21:39:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7B04184C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658518831;
	bh=pTCw8ObXsDCRk0h5jJUavUZSjr/XJYr7gxR45qvE8nY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iFlxngLcXhhySjU23PFDIVoB0FAL17+Sdn7MTzgEQ6NXH+jERFaaJ7Ld8knXjubwW
	 2BQUVaIxVm/23hzkIu/ejrpHExKUksfAJkYHkqJ0uW2Rxy9/tHJWuX3sGUCGkx1a02
	 W2IphjNpB9ZbAFEwvJN6ZKzb3HZFUI7DoH+SDD+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BCC5F80246;
	Fri, 22 Jul 2022 21:39:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 286E9F80279; Fri, 22 Jul 2022 21:39:40 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B53D0F8016D
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2022 21:39:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B53D0F8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UDjmED47"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id ECE00B829D9;
 Fri, 22 Jul 2022 19:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11267C341CA;
 Fri, 22 Jul 2022 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658518773;
 bh=pTCw8ObXsDCRk0h5jJUavUZSjr/XJYr7gxR45qvE8nY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=UDjmED47uZ+4Boj+sIyCQNmprg449KHHSlhBH261Qa+HAVgZy1Go92lIzsIU9sVsI
 SQb+2985ikSNT6tvxCIz7vbL0Su/LiBjnOnJjZaV5Ckprqn2fAqE6crpbOIqmTDVMP
 2ne0mNp3nTqGzPLapehEd4A2sm95OzK07BVEVdQw2r+vGUeOB32FkzSAdSS04mwA3e
 OjOvl4mXPpCxz7SObHP2oGfwufxXFLmI9g6Z9PzucP3n0r+QAAKBCu2qQTp3qYmi95
 XIHaX5dX67/7F0L2Iqvb3avwbVyGApFPuKf9iLgyGvzew5Ch+A+SFyfIh5q39z0eoc
 oUBUHMAks2fbQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20220722092700.8269-1-cristian.ciocaltea@collabora.com>
References: <20220722092700.8269-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2] ASoC: amd: vangogh: Use non-legacy DAI naming for
 cs35l41
Message-Id: <165851877179.1163063.11067472493999733976.b4-ty@kernel.org>
Date: Fri, 22 Jul 2022 20:39:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d952f
Cc: alsa-devel@alsa-project.org, kernel@collabora.com,
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

On Fri, 22 Jul 2022 12:27:00 +0300, Cristian Ciocaltea wrote:
> Unlike most CODEC drivers, the CS35L41 driver did not have the
> non_legacy_dai_naming set, meaning the corresponding DAI has been
> traditionally registered using the legacy naming: spi-VLV1776:0x
> 
> The recent migration to the new legacy DAI naming style has implicitly
> corrected that behavior and DAI gets now registered via the non-legacy
> naming, i.e. cs35l41-pcm.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: vangogh: Use non-legacy DAI naming for cs35l41
      commit: b340128432a2b8849cc34f9653d7c43c83102bbd

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
