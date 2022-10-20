Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F339AC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Oct 2022 13:43:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 074FF1EF2;
	Thu, 20 Oct 2022 15:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 074FF1EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666273388;
	bh=9c/1LRY5NqO6ZLKjMcmBS4hszclUETSJ0XifXeavwu0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ugRFBZbjnvoYAAnFOy0k3Ev9lJQgZbSgdBjdpMdbohs/uHKJrEDNiTI6wuMWJhlzk
	 uXzRlEoNqHn9FWteeuWtNdf9jpyRBMsLlLUgD+xDU1JVc4R9WHXOvTMB4FdxjY+pQS
	 2kpJScVOqIRAW1j7yysJwkthyFiVy2F9m0u/sqDs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FD20F8032B;
	Thu, 20 Oct 2022 15:42:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB7EBF804D8; Thu, 20 Oct 2022 15:42:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D62FF80137
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2022 15:42:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D62FF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QBiB9UG7"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6F3E461B32;
 Thu, 20 Oct 2022 13:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBE8C433D6;
 Thu, 20 Oct 2022 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666273330;
 bh=9c/1LRY5NqO6ZLKjMcmBS4hszclUETSJ0XifXeavwu0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QBiB9UG72BpsY1glj3drj0QTKKfw46mCAXUhrnbX0Uo8oNUdZlKYAuYnJDOUoZ26c
 uA1Ki7T5IyZW0438Bkt7ShNxRJS1A1/ecpn11EC97LO1+3GbYsM9IDrS/LgDwJy6KC
 ZqBKNUJlWjlmWX31W46BfMtP7nGw+AK7EEzXc1mryVLWHzJMuMp87qvzWmLHQkGR/z
 elh0aZezJ5UoNHSNqdzA/tEgtdZ1CuMql7+Wn39OPA9ujF2ZD3jYtbWit2IMKMEAP2
 Ps7i4UM2tdJS91lp7KaWqSG3/NhYr4sG8/l9FqtWL2vO8BFeGFqRWgAlYSGAdXGhnT
 lZ18eRodFJoFg==
Date: Thu, 20 Oct 2022 14:42:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 03/10] ASoC: SOF: Intel: hda-dai: use hlink
 variable/parameter
Message-ID: <Y1FQLT9cA0OzeAtI@sirena.org.uk>
References: <20221019162115.185917-1-pierre-louis.bossart@linux.intel.com>
 <20221019162115.185917-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GOraBFWIPo05DHMc"
Content-Disposition: inline
In-Reply-To: <20221019162115.185917-4-pierre-louis.bossart@linux.intel.com>
X-Cookie: Today is what happened to yesterday.
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Rander Wang <rander.wang@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
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


--GOraBFWIPo05DHMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 19, 2022 at 11:21:08AM -0500, Pierre-Louis Bossart wrote:
> Follow the convention and use hlink for consistency.
> No functionality change.

Acked-by: Mark Brown <broonie@kernel.org>

--GOraBFWIPo05DHMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNRUC0ACgkQJNaLcl1U
h9DwOwf9G3mrLWwS3M5gpqoOZ75hHvwp9mzDzatW77GyTLPr0LDViBJODzALXIDf
T/LiKV4p9CVFEmS/HkpD7ECVWkCG4sjiuVbJW3DZ9NxGEF0NoBHzi06IkVeNUYUx
BDk23RWEnPgJ32aQYQZF3+BVBqCr97Vuk9x4lJ0rReWu3f7WAiTHZ2A7N6MDIL75
/KVCB8FYCyIVNeQOFq1s4OZCHMYJTALTp3TAxPCx+clYUo7Y3ExGXk5GFeeXfV2v
+VQASNAkLz3SZmYojIgdE6JVV+JqMXTOLPIbpY6FPr5EXWejIcgQqXTSX3UWPYUF
V2ocMhIx4grDizbVZHOoFi5vfNoWng==
=EAwd
-----END PGP SIGNATURE-----

--GOraBFWIPo05DHMc--
