Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244E7C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Mar 2022 20:38:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61A5F17CF;
	Wed, 16 Mar 2022 21:38:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61A5F17CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647463135;
	bh=AAAhWEJi/anFNCmxfNhIiBbA6Y0GIdzJjvQH3bJNz/k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B+3Macp8HJtR7yrRllMKIOS6ogCZg2UUt2F1RyUqP+ft8yKqfPtAalJwvfrEXBhHG
	 w8VKDlO+ZK1A9UiLWcWWtOhksLq6gkSoXK2YSaqf13uH2eI7Q0XscF7IabuISvqxs1
	 fJ8PzDU4maBcMu1O43GuOa9h3CJvcyJoGTkbJEc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B684F80534;
	Wed, 16 Mar 2022 21:36:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34653F80524; Wed, 16 Mar 2022 21:36:03 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DD27F80516
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2022 21:35:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DD27F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J1gz/E1C"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 09B0861467;
 Wed, 16 Mar 2022 20:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90745C340EE;
 Wed, 16 Mar 2022 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647462953;
 bh=AAAhWEJi/anFNCmxfNhIiBbA6Y0GIdzJjvQH3bJNz/k=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=J1gz/E1CchAXd+lS5jkyTs1XeC9RQX/mBXckYjl3klNfDO/r3soyjfzUEVuoLAAe5
 lC54LRj0+gFBhgxEVGCiiEVKy1CkQHi6qdqB4jgkaJAU2O6zQK+SUggzSRyhr+OeYb
 D1tZT1dpw/XvUm3GMidGdyt2pt8HbPPMw3AeEEufiGmBeZCo26/Geap712HYLSODbi
 kn4cqxQteP+75j+hEOmJUotLedQCYzfET+jXMhIH2VIE7vsiYLI/9P3OmeUFqR2dvm
 /oIyYQQ0iphi3q8Srp4PjtkkFot5tRl0X2NJ9++zaGOHansIttRB0McVx10mQiBtk4
 HfLkkDHibg0wQ==
From: Mark Brown <broonie@kernel.org>
To: Shunli Wang <shunli.wang@mediatek.com>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Miaoqian Lin <linmq006@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-kernel@vger.kernel.org,
 Tzung-Bi Shih <tzungbi@google.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220316014059.19292-1-linmq006@gmail.com>
References: <Yia5XgkGyLbIRc1f@google.com>
 <20220316014059.19292-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] ASoC: mediatek: Fix error handling in
 mt8183_da7219_max98357_dev_probe
Message-Id: <164746295130.1220201.16478310954172024054.b4-ty@kernel.org>
Date: Wed, 16 Mar 2022 20:35:51 +0000
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

On Wed, 16 Mar 2022 01:40:57 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> Fix this by calling of_node_put() in error handling too.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Fix error handling in mt8183_da7219_max98357_dev_probe
      commit: 28a265a1ee11febeec5ea73a804f30dcec3181ca

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
