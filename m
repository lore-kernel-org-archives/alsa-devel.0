Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81477E7E631
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Sep 2023 13:02:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F97D829;
	Tue, 26 Sep 2023 15:01:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F97D829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695733360;
	bh=PU0fWrPi2wnyXnpIwY9YIk3MU1KBxKDqXRUb7dlII4M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fLlPJC0QGH8yzUG6sBqylbNAbSg8meu10PA0sJ4XR6TI77dYVxMjRNgglZu70vhoO
	 xfnXCO2qzKlrT7IwvcemLgqdKMWWngWJ0gqzPlC7E0P6VheK0t4cu7Cuikm1g2snDG
	 0YRF3V2we9vZfx291Vwcwo1ulQuoYwYNiAYPuRvc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5AD7BF80290; Tue, 26 Sep 2023 15:01:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A50F7F8016A;
	Tue, 26 Sep 2023 15:01:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA332F8016A; Tue, 26 Sep 2023 15:00:02 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CEBD4F8001D
	for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2023 14:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEBD4F8001D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=b+Ypagne
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id ED792CE1391;
	Tue, 26 Sep 2023 12:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC51C433C8;
	Tue, 26 Sep 2023 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695733147;
	bh=PU0fWrPi2wnyXnpIwY9YIk3MU1KBxKDqXRUb7dlII4M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=b+YpagnepcbUHx80T7k3ml7KCb3JhFC31t8LW9vdMVJk/kcJ5IWDTxpS9u61qoXzE
	 2kXBApS+UwtcgzL4CeoYqjXb0atf/X2582EqKA7bZbuaXzptBxPVdqG2LmTiJRmJLt
	 dEtD099OPi6qilVxVuJ+dlS+9D/2Nh8j+78QtRi9DabSCTCVXqbA5vUoJKNg93hjWm
	 RmmF1zjt3dEybUn1HgY8zR4LwekJgQcq2yexzKaoYuVJv3V4tPW2xJcDHSJ6EL5dz1
	 NY3Wba5i5N7PlxOGWGzplO+FDF2m78r/BZ2MsjCmyZMpc6N3uNXnay5fWP5ebW5Thc
	 YTihssY+1phMg==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1695202992-24864-1-git-send-email-shengjiu.wang@nxp.com>
References: <1695202992-24864-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: use integer type for fll_id and
 pll_id
Message-Id: <169573314495.2623437.8401087365242286082.b4-ty@kernel.org>
Date: Tue, 26 Sep 2023 14:59:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: IWY6NHREZ4TBSA3ALTNLXVE4LQ3MXD25
X-Message-ID-Hash: IWY6NHREZ4TBSA3ALTNLXVE4LQ3MXD25
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IWY6NHREZ4TBSA3ALTNLXVE4LQ3MXD25/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 20 Sep 2023 17:43:12 +0800, Shengjiu Wang wrote:
> As the pll_id and pll_id can be zero (WM8960_SYSCLK_AUTO)
> with the commit 2bbc2df46e67 ("ASoC: wm8960: Make automatic the
> default clocking mode")
> 
> Then the machine driver will skip to call set_sysclk() and set_pll()
> for codec, when the sysclk rate is different with what wm8960 read
> at probe, the output sound frequency is wrong.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: use integer type for fll_id and pll_id
      commit: 2b21207afd06714986a3d22442ed4860ba4f9ced

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

