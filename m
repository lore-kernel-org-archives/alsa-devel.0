Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F398C18E7A
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:46:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CDB20674
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MNEPJYiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CDB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 506631607;
	Tue, 10 Mar 2020 13:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 506631607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583844404;
	bh=iLujCNUdbrM1560pSrYPMF/RbCGu2uxgMLVjzAqIGUo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MNEPJYiTE/Nkt+BiRdC2syEtowTQaaTd8ZVR7AqXl37KzyCdEVNCDP+6UL7xp34b4
	 DsZyEDWsJqtwXWueFWaw+ltBmXEevu8tsrEh1/QW54lz5dpgshqKTxmqGFYgQC66+/
	 9wBfAUn2a6NZIcJiuDLXAuEEjZ+Bz9vrpOHiCO0U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA03DF8020C;
	Tue, 10 Mar 2020 13:45:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 646EDF80217; Tue, 10 Mar 2020 13:45:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id A0393F80123;
 Tue, 10 Mar 2020 13:45:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0393F80123
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99C1330E;
 Tue, 10 Mar 2020 05:45:46 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C3C93F6CF;
 Tue, 10 Mar 2020 05:45:45 -0700 (PDT)
Date: Tue, 10 Mar 2020 12:45:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH 2/3] ASoC: add function parameters to enable forced path
 pruning
Message-ID: <20200310124544.GE4106@sirena.org.uk>
References: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
 <20200309170749.32313-3-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <20200309170749.32313-3-guennadi.liakhovetski@linux.intel.com>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org
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


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 06:07:48PM +0100, Guennadi Liakhovetski wrote:

> soc_dpcm_runtime_update() to activate an audio path and update audio
> routing. When streaming is stopped, the vhost driver calls
> soc_dpcm_runtime_update() and snd_soc_runtime_deactivate(). The latter
> doesn't work at the moment, because the DPCM doesn't recognise the
> path as inactive. We address this by adding a "mode" parameter to
> soc_dpcm_runtime_update(). If virtualisation isn't used, the current
> behaviour isn't affected.

So why doesn't DPCM recognize that the path is inactive and why is it
better to do this than fix whatever the issue is there?

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5ni/cACgkQJNaLcl1U
h9AQrgf/Sc9Mk+Um1e7Mmw3pwn9VyqgmGzixwdmdBaCTgbae3Y4hXmlYfKvsAVb9
ghOJ2BoudXaiAC7FKupTIPLbDPTZF2o1i86zsNo+Ee67EIp3mfeUppenO1mGyvCt
0RiEc5XNZBbtGBE/Ux2C4tye+F6nbiI3nMNI/ckWDFoIUAV9+tUZ7lKWzFO1qShC
e4m0yTV+SSo2K18wPt51Bit136WK5rFNw0+CZy9xiW0uwF4tNSIj8ZgCCmD2rj+V
Jsq+VPRBD55SEaXfKPsSWRX29PlzXPCYvX7W+CR+S7K9Lp40QzbTi+SJfELdEXuH
MF2p9fQ1mUC8v1cUT6rTJhqNsxzJvA==
=4sjQ
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
