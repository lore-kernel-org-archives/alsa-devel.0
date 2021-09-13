Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43AC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 11:00:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8B261051
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 11:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F8B261051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F18782B;
	Mon, 13 Sep 2021 12:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F18782B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530842;
	bh=AkP0jovDemSFw2EtzAagzgwX6j/fQza8GDVZEvdK4KU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sSkRPbB670+6uzBhE6gK00SGfOG4bTwrALdnMWzukN6U1MTJZOul6s8uZ6hXa1pq9
	 EPweFKNWjGPa79LInwmppOIx8phwR1lgKQNFfFwpKNRiN9L1Dfy1tSh08h+i/d5hDD
	 38wO9yX7EWxcn1b+LCeB5+PQpgDg8/IKRsTCsW2s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6C2BF80542;
	Mon, 13 Sep 2021 12:55:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1ED2F80539; Mon, 13 Sep 2021 12:55:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 327B7F80536
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:55:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 327B7F80536
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kwiRISb7"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99AEF6103B;
 Mon, 13 Sep 2021 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530517;
 bh=AkP0jovDemSFw2EtzAagzgwX6j/fQza8GDVZEvdK4KU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kwiRISb7qm2rF6Qf3xhnl9h2vkzcF22YRJ6DEgqXM0Jmprw1wEy0RiF2IySCSWFB8
 4feuhLfIajRQqgCnpkBoKP9VVOFLZwWfHZG+Wn6RanhDKoydLprdoKv4us5v31N6ut
 IUO+YOGpXQDts3AqW7EgXrpLy+Bw4Dntp1RVtZsn9rRf0o5hufCTbivpRQrab/RP1r
 03gjbq6TaakJulvNVbl7V+hyOn+4i7Jcjlypzu/TQd/i1Le8e922lkexi8WJLQIGNk
 bv5ku+5uD7r4D1qFAFuDaDW9UI8wIXqBFAszISN3utlBIRToRYpB5+MnWzE6CpW6gA
 k7zuQrxsr8o+w==
From: Mark Brown <broonie@kernel.org>
To: matthias.bgg@gmail.com, tiwai@suse.com, Trevor Wu <trevor.wu@mediatek.com>
Subject: Re: [PATCH] ASoC: mt8195: remove unnecessary CONFIG_PM
Date: Mon, 13 Sep 2021 11:53:29 +0100
Message-Id: <163152996583.45703.15399781135133859191.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210902071440.6087-1-trevor.wu@mediatek.com>
References: <20210902071440.6087-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Thu, 2 Sep 2021 15:14:40 +0800, Trevor Wu wrote:
> The unnecessary conditional inclusion caused the following warning.
> 
> >> sound/soc/mediatek/mt8195/mt8195-afe-pcm.c:3260:32: warning: unused
> >> variable 'mt8195_afe_pm_ops' [-Wunused-const-variable]
>    static const struct dev_pm_ops mt8195_afe_pm_ops = {
>                                   ^
>    1 warning generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt8195: remove unnecessary CONFIG_PM
      commit: 2b9b42c847b83823527a497c323e74d2efced721

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
