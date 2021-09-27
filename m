Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64EEC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:55:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACEB60F9B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6ACEB60F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 026CD16B1;
	Mon, 27 Sep 2021 19:54:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 026CD16B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765317;
	bh=fo8UtX1qyDCUjoGqUbYWVlsvzl89Asms03FvPG0QBhE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kGKvWTO8aaQlOrrSmFgZB7oFpunxoZOTSNGtR7Zcm2U/il5G3BsPOSMuDolijKqL8
	 cpCjG4+EYM5GiU7WQteQyI0Gh/VYcLpgt2XhfFprXQTWy16odKxUSXIWdTZ4fGwiP/
	 I9RHlTZB5u9FJGB16OweOXB+MK9NavZPvBMsWEsE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BCCBF8057C;
	Mon, 27 Sep 2021 19:48:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5709F80571; Mon, 27 Sep 2021 19:48:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE81FF8055C
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:48:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE81FF8055C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QF8cOCMz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5DDA60F9B;
 Mon, 27 Sep 2021 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764880;
 bh=fo8UtX1qyDCUjoGqUbYWVlsvzl89Asms03FvPG0QBhE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QF8cOCMzsi2AMYyy+h5gbgELrmdrEf0RHShbnEusBbThEX2IOu4PYuVtSm/Rp4fyQ
 I7JR5DYZYOy6std6liN79mx9+BsBqWrD5XyCI5Sy1nzCX6bxoe50pNrUR0TlVz2spo
 bQ5A3z7AWXyVSY7bQHS94teMUmc5IGqu9FEjalN6217ut/mah6wo63f7AZd/lxtbr3
 IZplnbwqLXzf2f+BJL8NS/RT1mLIG02hX0rMHfmNszaO0o0D0aaLMr385eTix1aBTB
 XipA4KzyMbOiNkzwRk44kuY28OU0Epou96nbdPdrLK77rq3Jo+Qd6EkXaTfk8gmbaW
 T+7m2jD9JYI7A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH] ASoC: wcd9335: Use correct version to initialize Class H
Date: Mon, 27 Sep 2021 18:45:45 +0100
Message-Id: <163276442024.18200.12102853821778377525.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210925022339.786296-1-y.oudjana@protonmail.com>
References: <20210925022339.786296-1-y.oudjana@protonmail.com>
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

On Sat, 25 Sep 2021 02:24:19 +0000, Yassine Oudjana wrote:
> The versioning scheme was changed in an earlier patch, which caused the version
> being used to initialize WCD9335 to be interpreted as if it was WCD937X, which
> changed code paths causing broken headphones output. Pass WCD9335 instead of
> WCD9335_VERSION_2_0 to wcd_clsh_ctrl_alloc to fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Use correct version to initialize Class H
      commit: a270bd9abdc3cd04ec194f1f3164823cbb5a905c

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
