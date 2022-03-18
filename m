Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034CBC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Mar 2022 20:59:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FA0217EC;
	Fri, 18 Mar 2022 21:58:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FA0217EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647637178;
	bh=vndqZJnf+mtttA1cvC9HqQR34L16G84VxSZTW5w9S10=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QuG2U+YYp11rwrlP+eHfixEkfvqYMiI3/9lDenxYkDNfWBG/ITvUzYnKG6YFAvdtp
	 Nz8ppYqxzXV83mBCtEhyEsQem6ydDbMuYW1+UauaeA5AtOoK07SZgbhKXZP7xgdZSL
	 F/QF6SAFvtI5KYRb3QkMsh+Wve1zDeLK9ICNVtlw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E2D4F80510;
	Fri, 18 Mar 2022 21:58:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFBE2F8026A; Fri, 18 Mar 2022 21:57:56 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99C9DF80125
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2022 21:57:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99C9DF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bUZMmmfH"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F199B60EEB;
 Fri, 18 Mar 2022 20:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ECCC340E8;
 Fri, 18 Mar 2022 20:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647637071;
 bh=vndqZJnf+mtttA1cvC9HqQR34L16G84VxSZTW5w9S10=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=bUZMmmfHO2JFdxdEIjBGar/c5/UNtTtrztdOstAqdd/YFERWhO3QA3fUJUBA/zgfY
 uRTxYIKUoF+z1k2fFN9GIS9GD/mujbQseJDmjdcwtWZevmwgYasPmR2udlSUDAr1AG
 SuQm8RdYOxRLKpRkQVc10tuns82muVThSF2XIpCNDe9xiay11WZmwZmyEzl4g7x/Im
 TrR69xiR9sgCyPY6K5BzFMoW85GIuuiLjhWsVTNvOUQEZUCq+wtnE8lhat8x4Y6jvk
 6n+bYav1ERkskJb9Z4Y4qXkVGcKmsPTNnS/tM2H4ELPjVJXQg3cCAyKHQDJGCut1F3
 TM3AWL8R9XPrA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220318092609.130901-1-codrin.ciubotariu@microchip.com>
References: <20220318092609.130901-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: print the correct property name
Message-Id: <164763707026.2336370.9467659339240399342.b4-ty@kernel.org>
Date: Fri, 18 Mar 2022 20:57:50 +0000
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

On Fri, 18 Mar 2022 11:26:09 +0200, Codrin Ciubotariu wrote:
> The correct property is 'microchip,mic-pos', not 'mchp,mic-pos', so
> replace all occurences of 'mchp,mic-pos' with 'microchip,mic-pos'.
> Fix a multi-line comment format while we are at it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: print the correct property name
      commit: c639e85e93aa10ea0512ee416eead60da466e161

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
