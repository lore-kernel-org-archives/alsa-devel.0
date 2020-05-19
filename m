Return-Path: <SRS0=hLTZ=7B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81035C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 15:46:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FD0204EA
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 15:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OX67bvxS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsbFLkYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FD0204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F553176F;
	Tue, 19 May 2020 17:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F553176F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589903194;
	bh=QsuCDc9hKsH3s+asxIuVdC9YNAMFTujts8h5BMCb/DI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OX67bvxSzX2t56XXPIu+6CPaJcqodHLEVR8qYTFW9xf5XYA54WEYCmRtAdB68SYhc
	 jgnVENCfzdliQXwiGFpA9cfRBzNwYmmv1W+5eAj7LuRHQuzr97UZkvm0OwfMf+lEjS
	 zop5TfDfAIecM7eOYWK6OIA1n89eMMHKkdSY1WMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 869CBF80161;
	Tue, 19 May 2020 17:45:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45F47F801A3; Tue, 19 May 2020 17:45:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 017CBF800C9
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2020 17:45:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 017CBF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jsbFLkYP"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AAD50204EA;
 Tue, 19 May 2020 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589903127;
 bh=QsuCDc9hKsH3s+asxIuVdC9YNAMFTujts8h5BMCb/DI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jsbFLkYPsOSX2VtIkRgwYreXFrnW2As7D3m/rB4nHROjBWye8p0/9SVmXDHxpuZLv
 aH7zvbjqcUTnhAz2AuNlpb0H28FkR0p9w/2j5eYMEssBkEJ5WYN/j15JW4t0efsupF
 7SGr1x8tByCskZN+aNAwB8O/GtGn4DZ8F3WporrM=
Date: Tue, 19 May 2020 16:45:24 +0100
From: Mark Brown <broonie@kernel.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3 04/14] ASoC: amd: create acp3x pdm platform device
Message-ID: <20200519154524.GO4611@sirena.org.uk>
References: <20200518171704.24999-1-Vijendar.Mukunda@amd.com>
 <20200518171704.24999-5-Vijendar.Mukunda@amd.com>
 <20200519105359.GB4611@sirena.org.uk>
 <DM6PR12MB2633F809ECAB00A78B76004E97B90@DM6PR12MB2633.namprd12.prod.outlook.com>
 <MN2PR12MB4488F4D0F47F64F713238219F7B90@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bAr+fMtvBxbbbkvl"
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488F4D0F47F64F713238219F7B90@MN2PR12MB4488.namprd12.prod.outlook.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "tiwai@suse.de" <tiwai@suse.de>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>
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


--bAr+fMtvBxbbbkvl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2020 at 02:40:17PM +0000, Deucher, Alexander wrote:

> For reference:
> https://lore.kernel.org/alsa-devel/20191014070318.GC4545@dell/
> Basically MFD should only be used for drivers in drivers/mfd.  Everything else should use platform devices.

Right, but that does suggest the put the core in drivers/mfd option.

--bAr+fMtvBxbbbkvl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7D/xMACgkQJNaLcl1U
h9DxaggAhDFXiNCPhJxA7yl3kR6qPPccCtw+GZqksr8/Esdtzb+qJ/AcMj8iywLt
LJxcBxXvLSmvJJSQUGYsyX82dQ+5ByN/uuPzWLCTh1baIm6zLz+13YA8fX1oR3D7
gUgJtpm10dh0T5igcX36XAhfcbJqajy8N50VVqWtKc7D/kkrYnJGml3NWYQ3i4NU
UqWmqfEeRt2+dnQJtCATsci9J9NtYEVAtGu9p6OGGvHBqktvoiLh/ZaGLHwz45jr
geNJB9CcD7yL5kO/ViHH8xEXugIeGyVH/dht/B6NeQbcsFzqdIvEP6VxCVOmj08V
IJxVjHKvP6i5G5rCTwWUXq1lh9MR1w==
=uIhz
-----END PGP SIGNATURE-----

--bAr+fMtvBxbbbkvl--
