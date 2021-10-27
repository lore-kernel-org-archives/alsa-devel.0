Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548FDC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 17:31:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C264860E74
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 17:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C264860E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F19AD16B8;
	Wed, 27 Oct 2021 19:30:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F19AD16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635355887;
	bh=wF4ITQHovrfi+/zFjLWRp1/RkCOOsze0ZdjK6Q3RTvI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l7GB2O8GN/NzkLMVUi7Q6j0KiaMQlxUfwGVV1HcbtHcgJGJb9B7fTibIiGGAHnpYw
	 kOPJlhmjdifsc5ASbed78PnwBY1FTPQdXl5/uAjkZAscmeECq74UJe8NZsh2Gafcqi
	 j4kAcb0aRua6X2hXif1RN+6tO1Dh4ZmxAl/j2e4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4235FF804D0;
	Wed, 27 Oct 2021 19:29:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DFD3EF804D0; Wed, 27 Oct 2021 19:29:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CA47F8016C
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 19:29:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CA47F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AlNsDPBE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E069A610A4;
 Wed, 27 Oct 2021 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635355756;
 bh=wF4ITQHovrfi+/zFjLWRp1/RkCOOsze0ZdjK6Q3RTvI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=AlNsDPBEV84Pene+w55lrYdugdtmn9Sn6nsAUpH0VQ+rOugxtPjcK5mpkbN7tucK0
 OrRA0F6uYaswUBHcViU1yUyWc9c5DT4xNgDRRi2edtBGaN8ukx2f1V7sDjJMN97XD9
 Nf/F9YJOxi1JGSVX47p2BP+iyMoPK55FJy0YhTp9rLSx15wqCkhqd/miC4TDJp+TkL
 Ns9yqQqAM/Ub0PWHXOqG1NT7njNGgmNTftfH2g881weHDg12Zvy+PbGSF3nyUGQjiE
 oWb0/mxwx6oyRCPdlJ2FHgZizSGIdK5K5YqTCBuBk8JpArotEnLxx73LQ5HJhZglNY
 yWOo21a+LXiHQ==
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, lgirdwood@gmail.com,
 George Song <george.song@maximintegrated.com>
In-Reply-To: <20211027001431.363-1-george.song@maximintegrated.com>
References: <20211027001431.363-1-george.song@maximintegrated.com>
Subject: Re: [RESEND, v6 1/2] ASoC: dt-bindings: max98520: add initial bindings
Message-Id: <163535575465.4012075.8539101072953032948.b4-ty@kernel.org>
Date: Wed, 27 Oct 2021 18:29:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
 steves.lee@maximintegrated.com, ryans.lee@maximintegrated.com,
 devicetree@vger.kernel.org, george.song@analog.com,
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

On Wed, 27 Oct 2021 09:14:30 +0900, George Song wrote:
> add initial bindings for max98520 audio amplifier
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: max98520: add initial bindings
      commit: 8af1f903391419809160aef3dac0641fa15680f5
[2/2] ASoC: max98520: add max98520 audio amplifier driver
      commit: f88ee76b8645c6da37eec79cfd45f2cc646bd01a

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
