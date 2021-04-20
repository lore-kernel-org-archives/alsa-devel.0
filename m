Return-Path: <SRS0=gQoH=JR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7835EC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 18:37:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EB761002
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 18:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EB761002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48421168C;
	Tue, 20 Apr 2021 20:36:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48421168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618943828;
	bh=HKbpvXHLAM1t6ElsV1/iQQwWGgvzf7wQs80yEisnqXE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PHkMOITPtW55SFC+ClyoXkur1yFZ+lzju2p3jTAwiJOxFMxZOpMW1MciqGP06anxx
	 bR1zqVH8G8j8yo98g4t61ZfsJ3puuqMo9hRsjKaBrHVcfWyu5p8pDMuXyf8ZjiwrSs
	 GukJL5EWNQ4kKMnmirC1tjp6cF2zupaonKPZwBww=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DB9AF80253;
	Tue, 20 Apr 2021 20:36:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55251F80273; Tue, 20 Apr 2021 20:36:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36106F8014D
 for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2021 20:36:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36106F8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bDvBMfU/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FA5861002;
 Tue, 20 Apr 2021 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618943770;
 bh=HKbpvXHLAM1t6ElsV1/iQQwWGgvzf7wQs80yEisnqXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bDvBMfU/nYYjhMV1nzlTSo3wP+ReFOqoM1bWFCM5ZYJ5i8neT7NWtkTqvmS/8MYPq
 c38hXu4fB4EbgZhGNa16tfvSOGC33vwCwRGcwVI1lKa0fcQshaxot6RhHP4xkx2j4A
 DUNVpR3qad+OBffW9RTy8NjEh6DE2B1fB1Z3c8yBjo0PnIcu/cXIM5gO4MynyAwNhD
 2jcG2nl+xDGbJXfuIB3P0FFnlpqowQWa3r7YKTrDmVTnWsi3iuvuRsV8NzVorEYda6
 YpwIzWRcznIKsOVI0620zJDQIbpnCF1dsht5hYI3qU41zgFFdA/kWaxx09v0BPziCr
 BMa7/raGiXO0g==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com
Subject: Re: [PATCH] ASoC: ak4458: enable daisy chain
Date: Tue, 20 Apr 2021 19:35:32 +0100
Message-Id: <161894359362.35105.6842999052342514382.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1618915453-29445-1-git-send-email-shengjiu.wang@nxp.com>
References: <1618915453-29445-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Tue, 20 Apr 2021 18:44:13 +0800, Shengjiu Wang wrote:
> Enable Daisy Chain if in TDM mode and the number of played
> channels is bigger than the maximum supported number of channels.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4458: enable daisy chain
      commit: 7342db3cddcd1d8ff54f4dff8c942e04232f1d6d

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
