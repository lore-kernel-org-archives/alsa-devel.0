Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F6C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 15:36:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D3861939
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 15:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D3861939
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A371D1676;
	Fri, 19 Mar 2021 16:35:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A371D1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616168199;
	bh=5kvDHsPwWDrn3KMbFWJCU9NRRLiI2OW3w9k8vo9YXQQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1x1C17kl9XEVmAj4Kz5kLtQVMpXCXlvn9VvO5D9mE49+4eIvZCDVKMKcX14LlpSW
	 msDqkzcepGDAiieVQpfMTUa3XGzjUVZTMtc/4Nu2ESZYCCJlv/5w5FMfhJSi+hdICl
	 gbZNjXg0eWAz5IttQsgNXOCkQyU/TAnbH1CpcukQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0E05F801F7;
	Fri, 19 Mar 2021 16:35:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3A11F8021C; Fri, 19 Mar 2021 16:35:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E53B4F800BB
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 16:35:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E53B4F800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="grirJIce"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB30D61944;
 Fri, 19 Mar 2021 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616168140;
 bh=5kvDHsPwWDrn3KMbFWJCU9NRRLiI2OW3w9k8vo9YXQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=grirJIcelreWFHA7EIL6DoAvdpJlR5H5B1s0bcEVfrE/JhOglLd2CIj+5fb9/q0As
 c1Gf9Yi7DAYBccPmxT2gOEw5SGO+H1MiFST/AxCAD/gglNJ4Cy/Aef83dgr4+ZZt+l
 ekwCee5lJ4atbDXF5sIZoVUSR2WgU10JqUo0lfxZnQD3OA4r4RE62q1IRhOSceM4rH
 FITnYXUiVgbQHih/T7Id4MvvYDhgFtHDake2qlRD648M10Fe21aC49t8ay9MoChe8C
 T5mhakiPIauT3EcjTb/9+idJbBx4rHAbZZvmr1J2ezedv0CxSqAYr3LkCnqaH9Nxu0
 UKr6zxty7e0+w==
Date: Fri, 19 Mar 2021 15:35:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 1/3] ASoC: Add Rockchip rk817 audio CODEC support
Message-ID: <20210319153536.GF5619@sirena.org.uk>
References: <SN6PR06MB534234153792718C0417BD52A5699@SN6PR06MB5342.namprd06.prod.outlook.com>
 <20210319133010.GE5619@sirena.org.uk>
 <SN6PR06MB53427CA1401DE0FD5D0C8042A5689@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <SN6PR06MB53427CA1401DE0FD5D0C8042A5689@SN6PR06MB5342.namprd06.prod.outlook.com>
X-Cookie: No purchase necessary.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com
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


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 19, 2021 at 09:16:23AM -0500, Chris Morgan wrote:
> On Fri, Mar 19, 2021 at 01:30:10PM +0000, Mark Brown wrote:

> > Looking at the MFD driver it seems to already have separate regmap
> > configs per device supported so it shouldn't be too intrusive, just more
> > detailed data for the device - the main difference is that you've
> > explicitly listed all the valid registers whereas the driver didn't
> > bother for anything so far.

> I can add them to the regmap for the mfd then.  I assume when I tried to
> reference the MFD's regmap earlier and I got a kernel panic its because
> I was trying to write to registers that weren't defined?

I'd expect undefined registers to generate errors, not panics.

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBUxMcACgkQJNaLcl1U
h9CPRQf9FBhxPk+Y5EJ/ZSdcWz0fW1alr3wmEtsOCkD+68nWTyAXaN2QNjMjsiqZ
09982poC9l8Sxfe0Wrgk4HoNrJOctlRUGxjpCgyON+esoFFIq/xRJMmrlwive39I
23yqyfpzF7inEpo7fH3XC0HFGHZdQ76lKtpXoXqF/998IUBpzcoQkSWvgy2e56v6
JvXT+59fFYPEXI6vg0D1WJy1ugIclBnUbZli0uuiHWUDggw7HwdMY1xlfaRB0Wrb
E7nNdRE6Po1+XxST3yk5pM2BEhATPMMF58ANutoqTdj3naOnu9Vb9GWlLhamHWTq
v6TIdDxNy4K+HYpE41vnRIw5d7+lXA==
=SrWt
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
