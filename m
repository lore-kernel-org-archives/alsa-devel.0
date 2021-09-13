Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600B9C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:59:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951C3610CB
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 951C3610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21729166A;
	Mon, 13 Sep 2021 12:58:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21729166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530785;
	bh=adzHkMe7QmqPw8mLlHRzTAcZPu5KFFN4TF0NE5fBBzI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hvcDqWn1T8j7oeyK5vgMkRfJMbTdek0opIP3jyXN8Fx6dcZ/xzs8ThJCx1Ltz7Yh/
	 JIc9TCJy/22NOdVdZrIZZ/7YS/F3/Agw6+nhj7IajLmyUl7dqUmInbb/86CDf8+HVH
	 HAVo92LzT3h7Jv81g4tzbkshb4StNMxt3WbItSEc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48CA1F80535;
	Mon, 13 Sep 2021 12:55:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9B2AF80511; Mon, 13 Sep 2021 12:55:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77049F80510
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77049F80510
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="j8Ntwz91"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E90861004;
 Mon, 13 Sep 2021 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530504;
 bh=adzHkMe7QmqPw8mLlHRzTAcZPu5KFFN4TF0NE5fBBzI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j8Ntwz91WlimLio4nImgaFi/iKuvbcXXcsfwl/+3mdXBR6WtISZlRBF9WYxKnj0PI
 iqihBxsZWawgUnhmJp8KLd9knRR7kL3jJy06N8qwYplhfmPn+EbVqdJhCg3E8Ye58L
 aTRTMIXtz6so53Of6/XP/YQdO1lAcn17qHE3GvS7MSzqb9L2wvrMdIZixEcUU+nmdF
 MAM+tKWA644giBPOl2YJa+QTVyndPvljFoHMIlBNeswnlDF76gUz1XoFZGUVIMRSrH
 Yyn8Z6VMncU42MfgtJ0tLf8j51eul68NtespESTVcRVltD3yrBIqHKCqmflY4KxxwK
 K3AWl5v1bW4Gw==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org,
 Colin King <colin.king@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Fix unused initialization of
 pointer etdm_data
Date: Mon, 13 Sep 2021 11:53:24 +0100
Message-Id: <163152996585.45703.6144242874194833843.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210903114928.11743-1-colin.king@canonical.com>
References: <20210903114928.11743-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
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

On Fri, 3 Sep 2021 12:49:28 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer etdm_data is being inintialized with a value that is never
> read, it is later being re-assigned a new value. Remove the redundant
> initialization.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Fix unused initialization of pointer etdm_data
      commit: d67bbdda25c4156da079312a3594a41770123abd

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
