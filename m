Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CACC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:41:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CC464DAB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CC464DAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4DAC168C;
	Wed, 27 Jan 2021 18:16:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4DAC168C
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9278F8027B;
	Wed, 27 Jan 2021 18:14:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF9C3F804B4; Wed, 27 Jan 2021 18:14:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8CD2F80277
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 18:14:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8CD2F80277
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="a2eZC37R"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59E2A64DA3;
 Wed, 27 Jan 2021 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611767681;
 bh=KfMAz50ku1hSQxDGlnAcZgG3Vy0gGC7yAETGfIwSWC0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=a2eZC37R5jymFfqbRXOdEFon44/G7IMOC2uicMbU7EzmZmqoPi3XyT4m29BzVzUOE
 4/EfdNb72iddErFWAIQD78QuTX79Zu7XUaqy2fyNxsi45Ug+9WX3U8AW17+B5lZTRE
 MaZpyuo6cGbD6IA8BVUABJtOVENXdxF+NiXrBteqU46cJzh0tujtZOQ4PAEgNWsO7f
 zo4oxu8SfWSc5D8HMdWSomwJF+ZEYl3O7LEsJYVepXA9FFa1MCe0K2XzaLJmHzwaEA
 9Wef/E0ZmXOqAYptOVpfFXEMTXx8qvzlhAw2EumK+7BaqaZu0kmpIWzZp4MCawkZug
 J07Q2JhRkgaDw==
From: Mark Brown <broonie@kernel.org>
To: Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Bjorn Helgaas <helgaas@kernel.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20210126212023.2921168-1-helgaas@kernel.org>
References: <20210126212023.2921168-1-helgaas@kernel.org>
Subject: Re: [PATCH] ASoC: q6asm: fix 'physical' typos
Message-Id: <161176762854.34530.4993148289685566134.b4-ty@kernel.org>
Date: Wed, 27 Jan 2021 17:13:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Bjorn Helgaas <bhelgaas@google.com>, alsa-devel@alsa-project.org
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

On Tue, 26 Jan 2021 15:20:23 -0600, Bjorn Helgaas wrote:
> Fix misspellings of "physical".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6asm: fix 'physical' typos
      commit: 9fd5599a9b2618b315983d8a097e6dead640f55c

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
