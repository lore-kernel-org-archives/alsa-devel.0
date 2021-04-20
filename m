Return-Path: <SRS0=gQoH=JR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86747C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 16:20:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98DF613CD
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 16:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98DF613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 702621687;
	Tue, 20 Apr 2021 18:19:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 702621687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618935637;
	bh=wo0Ma+Ga1AFTjgDUVkyTQw4kODt/cwUCMSS14hRgUNg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r8YFcXrRDpdMdIRvNmpBImz5f8iVQIihNNvXfA/TpoNvFPpcH814MLh98PTysYhBO
	 GTVXUMAPXFuPNK/bHQ5LaGutXZmMGcw93UL+SWq5WnpyewVDVdlehAaErf7MVBeEum
	 k18u3npRBjKA5DQ1So0HKBJ5Jm6X/WaBW7I2QCGA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5D04F80168;
	Tue, 20 Apr 2021 18:19:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19FF1F80253; Tue, 20 Apr 2021 18:19:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03E5BF800FE
 for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2021 18:19:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03E5BF800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="us9AuT+e"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9CCF613CD;
 Tue, 20 Apr 2021 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618935580;
 bh=wo0Ma+Ga1AFTjgDUVkyTQw4kODt/cwUCMSS14hRgUNg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=us9AuT+exCEr0zbASBxHw2qmmSsVS6/zUm+sHeS71IHEbaYbXR4fDkSmiu/75SZTF
 6+G6RPoo++S67ORiwwURUJp1//a4XjxY05+h27MdruM4uqj3z724dJM0Q/Buf/zTTq
 unTpAaffQ0S67azl9QCQMqn6OKiYI2x2Dis1VptuWdu7lUDh6uKPcc2IHHXTXecB7q
 u2LNLBzEyg62emP49CkuXf1eaIv6GnhYob09eUIvoiLNtVMfA2c6ddACYxKm9PbB7j
 7sd1hMU1M2HZTpxYqpUlVGxcv1cH9wdZCG91ghvjlWfmn9tSHNBWsrJXOzoPMeRKpP
 MjOwZ1LAUfg6Q==
Date: Tue, 20 Apr 2021 17:19:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [v7 2/4] ASoC: Add Rockchip rk817 audio CODEC support
Message-ID: <20210420161913.GF6073@sirena.org.uk>
References: <20210420160747.22942-1-macroalpha82@gmail.com>
 <20210420160747.22942-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
In-Reply-To: <20210420160747.22942-2-macroalpha82@gmail.com>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 heiko@sntech.de, devicetree@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>, jbx6244@gmail.com,
 lee.jones@linaro.org
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


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 11:07:45AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add support for the Rockchip rk817 audio codec integrated into the
> rk817 PMIC. This is based on the sources provided by Rockchip from
> their BSP kernel.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---

If you've not made substantial changes to a patch you should carry
forwards any tags you've got when resending so reviewers know they don't
need to do things again.

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB+/wEACgkQJNaLcl1U
h9D6Iwf+L1DybQOPGsl6KtAAhQp17fNdKFCqL5+Uil1WOS6NbkToX2lb+DZOK09u
r77tLW80Zlelg1tgjPZNPXWztxH+NMtVq2fyuxvKsHOHkACMLMRYpLgCSgjctYA1
n1pxh74sIshX+rRt5UO40Erek04i3sTq3Z8fS/r/SN3xaDqowhtXgur3dGsfWwlb
TJCqKeAYDlkR7KDxJ+vdanOWIQ8kmHSPwrKNLePrjD8YAx0iTRut7oSbG6EoeFWr
kQ8ZY4dLohmQ8sKjoAlGMqw21MuME4hFmgZuelwpCU0IV2QGqgq2s8wEQQ0SuBZE
W+01hbiShhGlSmt4IGCfYt+xp+yuAw==
=a2sH
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
