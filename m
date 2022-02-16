Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3592BC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Feb 2022 18:03:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDCDC191D;
	Wed, 16 Feb 2022 19:02:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDCDC191D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645034612;
	bh=XD/nyKzA7YBuZeYgwMrWbmDBjd9uoqzMMHucltaUhbA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pkZZjpj/earbths5cCB/945B0Z91/XCjCJ2X9tCWLdqundL/ztJ3V0X9YAjDqaKt0
	 TUv0dN+kx4odt2f7oTjie1DWw1mst+HxRUXDiU51GvE5Muoa1XYDEV8C+BbwQcMKcF
	 JCAlDeP0gm9qTCMbWr4rU5fhqJZyFgJdY+7Nd2E0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C6B2F80118;
	Wed, 16 Feb 2022 19:02:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5DF4F80118; Wed, 16 Feb 2022 19:02:05 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C475CF80118
 for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2022 19:01:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C475CF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lsw7TqR9"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 24CA4B81FB5;
 Wed, 16 Feb 2022 18:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB183C340E8;
 Wed, 16 Feb 2022 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645034516;
 bh=XD/nyKzA7YBuZeYgwMrWbmDBjd9uoqzMMHucltaUhbA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=lsw7TqR94cuOYN7RpzTW0pZPBDQHuB7PtYzjwIgTlGKRpktVRzhP2C56iSvga3j/+
 robxjMFO4g9WJhBW0ssmsERgjqVGry8g9Rm0fkBJTjYMxc6QsZkl/bT2Vvjl6PA23g
 31v3QApr2zv8lB4q/zPzfPnxHJGBOYkrzNP0Bqcx0b0NbQrR1xXa8Q4GFflB8Nqy51
 udE5m+K0XuHsgGuB2f6a6tQ1W/2Cf3vHwlyc2h22j3A4uF0Q8WASBwTffK6UMFm+ep
 XF++5GCHzMpfU67zVarNFv9Xwyx3wPd5t2cn0GaE45EOBeLouGZaxZiRF/hwFTrkSc
 sS1X1SFuxeKZA==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20220215120514.1760628-1-festevam@gmail.com>
References: <20220215120514.1760628-1-festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: cs4265: Fix the duplicated control name
Message-Id: <164503451555.3088802.5545811785236254940.b4-ty@kernel.org>
Date: Wed, 16 Feb 2022 18:01:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@denx.de>,
 ckeepax@opensource.cirrus.com, flatmax@flatmax.org
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

On Tue, 15 Feb 2022 09:05:14 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, the following error messages are seen during boot:
> 
> asoc-simple-card sound: control 2:0:0:SPDIF Switch:0 is already present
> cs4265 1-004f: ASoC: failed to add widget SPDIF dapm kcontrol SPDIF Switch: -16
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: cs4265: Fix the duplicated control name
      commit: c5487b9cdea5c1ede38a7ec94db0fc59963c8e86

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
