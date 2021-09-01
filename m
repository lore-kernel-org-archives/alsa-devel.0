Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D58BC4320E
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 16:32:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E771B6108B
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 16:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E771B6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C0A23E;
	Wed,  1 Sep 2021 18:31:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C0A23E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630513969;
	bh=y1c/D5zmMC7JOawbBXs6fSznzulN2NVBOiAlLNEuXjQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=awSxzn3uJ7Fw4rgSb7GgFvp3ZdwXW3AagBzP2hQVneA1R2QMwWBQgRlvzyO/E61Do
	 23qPkGDFu0JnqSF2il2zNjuYzyVLYzdykeJQWgBom9cvTZ0SjsjwL3koxihowsMHSH
	 c+qNy+WICCXZ81nFEjS2ugKtxVkQ8dllwX2IOtyc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED050F8020D;
	Wed,  1 Sep 2021 18:31:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9EA0F80254; Wed,  1 Sep 2021 18:31:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B881F8020D
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 18:31:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B881F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nJfILASU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64B0E61058;
 Wed,  1 Sep 2021 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630513911;
 bh=y1c/D5zmMC7JOawbBXs6fSznzulN2NVBOiAlLNEuXjQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nJfILASUEEvPpkbVT3jXOHbnpOLmaCtRY+zj8Hkk/381At+HqeYDbjdk6jg4zpBGf
 oisPk9SEFbfgBc/f34pmOy0jFLgSzl2B5C5jmLA/UTGh7QrocNq0PV8gw7dge9B39S
 XMahVwAjFGVzfAnoOO5FMROUS+hpQLG4cKmPOED4hCsV0/Cwq72QeCYp4gKm8lXsbE
 R1nb2xuERJUBkpc0trcENT9pTJi5KsKV9MTLMPogur073v23ZFW72HnxQw8csxlE6I
 Ni19M9xpCn/tlBM6UL+6+P5xdiO8D39XPgLo5beT2/rjM92oiEo3VQy+SQbJjz/xNV
 10AFAhYiDS3QQ==
Date: Wed, 1 Sep 2021 17:31:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v2] ASoC: rockchip: i2s: Fix concurrency between tx/rx
Message-ID: <20210901163119.GA39417@sirena.org.uk>
References: <1630305525-65759-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1630305525-65759-1-git-send-email-sugar.zhang@rock-chips.com>
X-Cookie: Walk softly and carry a BFG-9000.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, heiko@sntech.de,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org,
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


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 30, 2021 at 02:38:45PM +0800, Sugar Zhang wrote:
> This patch adds lock to fix comcurrency between tx/rx
> to fix 'rockchip-i2s ff070000.i2s; fail to clear'

This doesn't apply against current code, please check and resend.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEvqtYACgkQJNaLcl1U
h9BxBgf/RAh8wv4l2S8GAWfb2mR6GABSQYH7DftN+pPbe66GT0X+/FYi45mTxL/D
9i3Ya1ynoYCArBhICLM6UCKgYLLRE2pgT6EYyGK8u6aBrpT6XzHDx/cB1oBsZY18
avB/Jl7c6nbNRcF3njxkB2WmefKJ9HW3aNh6QyDxz2s0u78vzj8yWzkjBsAKETHC
kHD8dEAI9pTx6lX35vqzUv0chFU1xgBa4BrWjZRAiMu1W7HCrJeIIoe+K5LbZh6/
Wo2x+YRGdtbaq6vQ0pZCGcPFL25u+JSnEI0o5aMyhNtUh4n8IFnuhI0fzMSpDkFK
JA35vTg1ULgBhuAvLtJW28lVK1J0Iw==
=4hGe
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
