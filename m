Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A078CC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 18:14:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A4F610E7
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 18:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16A4F610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60AE218D7;
	Fri,  3 Sep 2021 20:14:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60AE218D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630692896;
	bh=HV5QwvXd+G5X5BE1dhVVGio0bsaKoGZQ54JzrFuQYv0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p+hEh0eDf8aF/zzQaYJLCIZZuf+ACenFj5GVr3UqjK5/KGERlgxmfOGkq9Xim+GYV
	 IGJSsqfqqIoxVjYN6fxbQ24ZZVKE2OkwSgX+HaCU8f8pSDQ0c7bgoXy1EZDQb9Px64
	 0AFttLT84v+TmTGyI/k7iOYIVx2Bsf5/y6PzsRMI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEB2FF80227;
	Fri,  3 Sep 2021 20:14:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D188F80254; Fri,  3 Sep 2021 20:14:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23F36F80088
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 20:14:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23F36F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Lciq/IIh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B4C160FDC;
 Fri,  3 Sep 2021 18:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630692839;
 bh=HV5QwvXd+G5X5BE1dhVVGio0bsaKoGZQ54JzrFuQYv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lciq/IIhEguLoSiuOCa3XnH+5hiXq2Wu1ONakJhGocr7FJdzgxKE4kURLzk4xQ4VB
 Y8/2+KZQSSO3t43Lp8CWIXOzwuPAEnzEp2vJVnsbgEi2aPjZVuwCd+3SZs2hPscwZa
 XoXam/PdM0Bws8VmCfY0b8smn4vrsTBx72sfmECTcSE63UYe+gyPJmlF86RSY27gNs
 JUvcpfmIrjM1PBLHsUOdJLZZUhdNMntp/mgpfmeIbB/OjxuPFfJox82Rk4p6LgLOsN
 WSaPfB8bmkyKOiRk9tMp51gEu3vEPqTurOqCy2h4yWuvBCIdTJxEBp4HWECVcKIKQ4
 MCQw79usdNxrg==
Date: Fri, 3 Sep 2021 19:13:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 06/13] ASoC: tegra: Add Tegra210 based MVC driver
Message-ID: <20210903181326.GP4932@sirena.org.uk>
References: <1630056839-6562-1-git-send-email-spujar@nvidia.com>
 <1630056839-6562-7-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NDuspjMMC1Ui5ypn"
Content-Disposition: inline
In-Reply-To: <1630056839-6562-7-git-send-email-spujar@nvidia.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, catalin.marinas@arm.com, tiwai@suse.com,
 lgirdwood@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 robh+dt@kernel.org, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org, sharadg@nvidia.com, will@kernel.org,
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


--NDuspjMMC1Ui5ypn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 27, 2021 at 03:03:52PM +0530, Sameer Pujar wrote:
> The Master Volume Control (MVC) provides gain or attenuation to a digital
> signal path. It can be used in input or output signal path for per-stream
> volume control or it can be used as master volume control. The MVC block
> has one input and one output. The input digital stream can be mono or
> multi-channel (up to 7.1 channels) stream. An independent mute control is
> also included in the MVC block.

Looks like it's also got a little bit of other DSP in there (a simple
EQ?).  Not that it really matters.

> +	if (reg == TEGRA210_MVC_CTRL) {
> +		u32 val;
> +		u8 mute_mask;

> +	} else {
> +		u8 chan = (reg - TEGRA210_MVC_TARGET_VOL) / REG_SIZE;
> +		s32 val = mvc->volume[chan];

It's not clear to me why we're using the same callbacks for the volume
and mute settings - there's no shared code on the read path and only a
tiny bit on the write path.

> +	err |= regmap_update_bits(mvc->regmap, TEGRA210_MVC_SWITCH,
> +			TEGRA210_MVC_VOLUME_SWITCH_MASK,
> +			TEGRA210_MVC_VOLUME_SWITCH_TRIGGER);
> +
> +end:
> +	pm_runtime_put(cmpnt->dev);
> +	return err;
> +}

_put() should return 0 if there's no change or 1 for a change.

> +	/* SW reset */
> +	regmap_write(mvc->regmap, TEGRA210_MVC_SOFT_RESET, 1);

What about all the cached values in the regmap, won't they get out of
sync?  Especially things like volume and mute, it looks like the mute
just gets written directly to the regmap and not otherwise saved.

--NDuspjMMC1Ui5ypn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEyZcUACgkQJNaLcl1U
h9AgMggAha/hIL9322l4CAz3Clg/xsZLabDdWCuHA9GA1Ze39XOrtPyBmwNyBOyj
Re3PVvnBfeCzpGooqKXpTcdKaxiqBnF2ewOPcTLNrG3gnuAYR8X2NDbzFHd6rr3e
frclpdZMOypNILokwrytDJG1ssscBTapV5KC3xjwQjqSAp2ckVRGgg+5SE++B1BV
yrZuTVHJtmK3Sk78YYcYizgOndIGAOFHX48tLa81LaiSWUlePraGXtEXa8pzmSN0
uJkPyzGdiTK4bLBJgC75bOMuy/oI2Q+nsG/K6+grY7VjcuZaS94qsjngFJCdgz4U
U3mbKcLaeF8Ov8lIpr4tKJn0THvJdw==
=uPdC
-----END PGP SIGNATURE-----

--NDuspjMMC1Ui5ypn--
