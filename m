Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F32EC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 26 May 2022 17:45:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91C49170D;
	Thu, 26 May 2022 19:44:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91C49170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653587143;
	bh=Z6Psciftp7RG/YX/WH7ayCaEWc97FgoyLfc6zzuQPdk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MUwZbtKcyk4jORKRqTMdTytSTwF2+GZGOV1rgX2fenYPMliWlpWEPlgqyqfmkDRHd
	 ozdB+yfOX3uMC/FiLUq2QY5JNjG4ywgA2DoQMyou1pkIQ4nPaFDG0eVtpmcW/St4qD
	 o+F6IdgrXV3GUlO3qo7efSFb6tm34eK6h7wtJIzg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26787F80137;
	Thu, 26 May 2022 19:44:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F172F8014B; Thu, 26 May 2022 19:44:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 803B6F8007E
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2022 19:44:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 803B6F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iTwlLQXL"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 335C961018;
 Thu, 26 May 2022 17:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23624C34116;
 Thu, 26 May 2022 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653587084;
 bh=Z6Psciftp7RG/YX/WH7ayCaEWc97FgoyLfc6zzuQPdk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iTwlLQXLCcxIdHYJARhbd+yJCx1eEMvlXUH1nsQWLI6tnyWW3mhE9I0pT/M6jRzMH
 854t9cS+7YVJgPYIfmbU0xC4J1J2eBnvaDggwIQGRYPqn8wmmG6ynr+2D4uMqHpsTo
 A9mWSrC7msaggVlxE/7/xklFJRwpUyOjmBP8qtms/9bg+C7YpsqpiOwjq/Pzt14/xK
 U0hJZlO65tpKRWQNHqH/9+YtAf0FjkmhSoz7/VWWEKiOqpNnNxxXo4G3ceSzLq6YzY
 KmQZBCfSfSLzIJ9wu8mreRYCPpDEPb7mYjPPZ0ymc5mP9u5PGlHX+xsnJ2gwnhjUlF
 vxaag4Y1XbZ9A==
Date: Thu, 26 May 2022 18:44:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 11/15] ASoC: Intel: avs: Machine board registration
Message-ID: <Yo+8hvwhvdx7tNGI@sirena.org.uk>
References: <20220516101116.190192-1-cezary.rojewski@intel.com>
 <20220516101116.190192-12-cezary.rojewski@intel.com>
 <20220526162443.GA60418@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eeSbvHgJqt4kZcho"
Content-Disposition: inline
In-Reply-To: <20220526162443.GA60418@roeck-us.net>
X-Cookie: Money is the root of all wealth.
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, upstream@semihalf.com,
 alsa-devel@alsa-project.org, rad@semihalf.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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


--eeSbvHgJqt4kZcho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 26, 2022 at 09:24:43AM -0700, Guenter Roeck wrote:
> On Mon, May 16, 2022 at 12:11:12PM +0200, Cezary Rojewski wrote:

> > +	if (fls(mach->mach_params.i2s_link_mask) > num_ssps) {
> > +		dev_err(adev->dev, "Platform supports %d SSPs but board %s requires SSP%ld\n",

>    sound/soc/intel/avs/board_selection.c: In function 'avs_register_i2s_board':
> >> sound/soc/intel/avs/board_selection.c:328:36: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'int' [-Wformat=]
>      328 |                 dev_err(adev->dev, "Platform supports %d SSPs but board %s requires SSP%ld\n",
>                                                                                                   ^^^
> Reported by 0-day but still made it into mainline.

FWIW given how hard the 0-day reports have become to read I'd not rely
on people paying attention to things that are clearly pure build
coverage based off a 0-day report alone.

--eeSbvHgJqt4kZcho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKPvIUACgkQJNaLcl1U
h9DMZgf/Qdwe2pvnu+6wQk5eIAxPt0Tmh0g4ZNXHdHrmNgWJxDCUvxcyxbwWDKzM
klDpRmJJZYWAHwOgK34mQXwS8alcQpQSCcCm34fyJP4Qyg61m/wHqpiHLcja5Utc
8MTwT4YqxlekfxF0rtnvETbG7bJH8u+h/WAYjLctXNusTZxfA9mbo45QsAQqAK6B
282LBb9fFBZFePlYQwDiwN6TrHZLD890GMCi2P3KMGnYfAXsycmSjJrk/bsymbvH
MT27fy4X1FlCTTeAst6yAYBagGPZZtOQeIwx6NQM/r/QcxNBumtjgPQgPZqIgNMI
JmjPOMXa2ZB4Qw8BME2g9Mi8jyW4jA==
=NSJ1
-----END PGP SIGNATURE-----

--eeSbvHgJqt4kZcho--
