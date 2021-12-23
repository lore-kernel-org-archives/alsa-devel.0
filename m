Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8099C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Dec 2021 19:40:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A25DAE9;
	Thu, 23 Dec 2021 20:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A25DAE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640288431;
	bh=NXKPcFkHdy31EhKH/FMtlR3cjqWl/bNcNYvTSC2jU2o=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Se5wjIvE5fcbWXWnBy1YATjuVtuCfSp0z6g2NT7Ss5prnWlHteVskqgGWBv9I47rd
	 /CI4RcGE+D1retecVuXMD1fvUZ8o1t+ShfRARo9B1ZRdCkknDBLifCLgTbEMHGxSh6
	 V68BUtX3sKejSTZ3Jh2kJM/bO7dmWw4j2FJAwq5A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D27F1F80105;
	Thu, 23 Dec 2021 20:39:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9FC03F80105; Thu, 23 Dec 2021 20:39:38 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFDBFF80084
 for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2021 20:39:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFDBFF80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JZ31nVQN"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 31B4FCE21B2;
 Thu, 23 Dec 2021 19:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EC9C36AE5;
 Thu, 23 Dec 2021 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640288367;
 bh=NXKPcFkHdy31EhKH/FMtlR3cjqWl/bNcNYvTSC2jU2o=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=JZ31nVQNXLP8rowM79W9RZo5V3ohrOaMCEqTxFiDfadUoLfWB3NyDo+w26jAzB4aq
 ZjpRYfe9uTmF/BmF454DFDI5OR/GA0SYKZDlbqUNZD1nzRliuoRq6k6dIGbqVK8JEp
 ZJhqwC7TDK/sFW+kcvZGhfv+JzxAV38tF0w93zNXhE8EuZisI+H9PsZA8nF8OT1SND
 pK1ZawJOWzeD3G1H222tSV+KQX3yXbJXSewOZP4Nhctrt4YW/9BuQPtg1MO+uJsWko
 RdFvx+Exg6q8F55PKgBxP1zPiVQalsbFke6J2NUdZmBrBv2Tr/6JSmv3Ts32+gQLht
 vFg2/850KYOZw==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com
In-Reply-To: <20211214040028.2992627-1-tzungbi@google.com>
References: <20211214040028.2992627-1-tzungbi@google.com>
Subject: Re: [RFC PATCH] ASoC: mediatek: mt8192-mt6359: fix device_node leak
Message-Id: <164028836574.13551.15479631717321569277.b4-ty@kernel.org>
Date: Thu, 23 Dec 2021 19:39:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 14 Dec 2021 12:00:28 +0800, Tzung-Bi Shih wrote:
> The of_parse_phandle() document:
>     >>> Use of_node_put() on it when done.
> 
> The driver didn't call of_node_put().  Fixes the leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192-mt6359: fix device_node leak
      commit: 4e28491a7a198c668437f2be8a91a76aa52f20eb

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
