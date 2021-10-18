Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0618CC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 15:36:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C913F610C7
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 15:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C913F610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF04217EA;
	Mon, 18 Oct 2021 17:35:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF04217EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634571379;
	bh=JibSQjxE3eYl/3LJTIS9KI3uMWewWr7xZzBC0dfWGTU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYi4q1i6QVVOmqOd2XeRGSC0F6fInRPu7xvjCrMhTv8266MWB0I1eOTZq73gT+xVi
	 1sWRvk2bVkkEzrjTBtJkY6a2ljTHww2wdfunJXK/jhOyhX3VMS7IllE1EPnUb03c0V
	 9D7oo1sAR/Aw/5qTQ46moKC7FCp00ohG3S/o/RaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 367E3F80217;
	Mon, 18 Oct 2021 17:35:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5B6DF80224; Mon, 18 Oct 2021 17:35:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 286E7F80159
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 17:35:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 286E7F80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aTiMfr82"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51C95610C7;
 Mon, 18 Oct 2021 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634571320;
 bh=JibSQjxE3eYl/3LJTIS9KI3uMWewWr7xZzBC0dfWGTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aTiMfr82haKToQNJsWafwbAPkKDz4OMKjDlHN4AzHZWc5OGHEx82vqxPis3A44u47
 h1o4bOWucgwPQn6QmLRZbtQKZuEfMAcpjDqJKKyrUsBYSoxIg0EIYaAX5EaSSDIUiA
 uN6kHbOPl5GghmzEGqONfQrl6TqOiZfNmzByK3qCWtqrTV7tpWc+KadjH2v+zKBOYk
 ZGD1CkuzrJFqwJczsZDjgw66Js23G5MkBCE67oKtBiuVePB6F3mhBgGolnGblLo7uc
 xF+lD1MKKB52R66Qg+yvvfIK5YzQJpLYX3V7YP7y0kVZ8OSLexRWMSqaeDdExrKdob
 oiJjtsXY177ww==
Date: Mon, 18 Oct 2021 16:35:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Move soc_intel_is_foo() helpers to a
 generic header
Message-ID: <YW2UNRAWUphJqhyW@sirena.org.uk>
References: <20211018143324.296961-1-hdegoede@redhat.com>
 <20211018143324.296961-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pdySZJpBnvtzNFGZ"
Content-Disposition: inline
In-Reply-To: <20211018143324.296961-2-hdegoede@redhat.com>
X-Cookie: I program, therefore I am.
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Gross <markgross@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
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


--pdySZJpBnvtzNFGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 18, 2021 at 04:33:22PM +0200, Hans de Goede wrote:
> The soc_intel_is_foo() helpers from
> sound/soc/intel/common/soc-intel-quirks.h are useful outside of the
> sound subsystem too.

Acked-by: Mark Brown <broonie@kernel.org>

--pdySZJpBnvtzNFGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFtlDUACgkQJNaLcl1U
h9AmLAf/akoQqvZR7V/vLj9gdKLLnHFVYPkDDXQ/rV347EYuW1MwbPWahTmi5Ptx
BK063G0PZVbcYuqyrJWFbGMZRnbqLOPITzjq7z0qsMvNfSpS6emjT+jlTA7gGxGa
22tp9TkO2QxeQ1ZK6qXF6ppQHI7VunrVNkDHdGjFGpNtNrHJ/BrTfsEswMXvPaYd
nIWF0qzlS6v2Vy9CV1xuZXtdIUuME3UIPHBaEyr5K+Rszj2S0A6pGVM/mVLA4CUe
BQ5GFTEMgjMJgz4zNvtv3+QGn3C+QgeP3fzROg3Gnv9xFGpk6ia1yvuvcKAslAgL
ABlCBNnMRMeYtS3E5k56LuwghbwTFA==
=jPfX
-----END PGP SIGNATURE-----

--pdySZJpBnvtzNFGZ--
