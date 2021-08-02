Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5189C432BE
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 20:46:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4764A60F4C
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 20:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4764A60F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2FBF1728;
	Mon,  2 Aug 2021 22:45:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2FBF1728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627937179;
	bh=knoH2cdCXTM2mbLN1i5m2fnGMDLvpU6bTazpD8ALCvY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ExZIhb7Ib0XlOj+SEsoqwc41P8owq/RT44ZZ+sM1Kfs3Vs7BO8ecd1S6sYU8i3ofa
	 SF0P/3lOFHtfomABwc10+ZP9CtBbiAML1TFVCj1ggboDY526H9otfr4sF8/q1TPMl/
	 2EqW95v+HIFBGRDflYjxT0MnoaHFEtJqrEK1e3qk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E3DAF80271;
	Mon,  2 Aug 2021 22:44:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 805D7F80268; Mon,  2 Aug 2021 22:44:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4BB9F8014D
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 22:44:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4BB9F8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PIKntqSS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4540E604D7;
 Mon,  2 Aug 2021 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627937069;
 bh=knoH2cdCXTM2mbLN1i5m2fnGMDLvpU6bTazpD8ALCvY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PIKntqSSOeVJCJZrboiUiQMe+ehZnhNMRZqzmWtCaWWzVhF+GPu2djKQnb8h8OL90
 qduhWNjrDtqtKHRW8rez+UXZkmXM9funm0bCK2Mz//V4twUpxWJfoNAmmSii4rAgE5
 vatjacrAaVJzjx+VgTb85DL9Jjac1P0W9phQ/pYlh9YNDLP0zskL6cqyC6ArFC4JQp
 jaj9Y7G8Px9mUUxFl6Ja8kus3pn9H1dcO3v7fz7Glw1EqKj1humN9Fg2wC5c9CwUNJ
 AgVXoAbVSvEZfPfGGtbAO0z7jHfS0eAVROhHERjeNar+nHzh8111rYj9SiGNseM1WM
 a8YUyQaLuX0TQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Colin King <colin.king@canonical.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: make array clocks static,
 makes object smaller
Date: Mon,  2 Aug 2021 21:44:12 +0100
Message-Id: <162793640673.55982.9347751869143903771.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210801064807.138641-1-colin.king@canonical.com>
References: <20210801064807.138641-1-colin.king@canonical.com>
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

On Sun, 1 Aug 2021 07:48:07 +0100, Colin King wrote:
> Don't populate the array clocks on the stack but instead it
> static. Makes the object code smaller by 316 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   63668   28264       0   91932   1671c ./sound/soc/codecs/tlv320aic32x4.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320aic32x4: make array clocks static, makes object smaller
      commit: ea9df9840fd5d766b9e98b0073890de4be68b062

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
