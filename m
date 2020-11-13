Return-Path: <SRS0=KFnC=ET=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A16AC388F7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 16:51:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830AF21D1A
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vD2nLzQ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtsQVcZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830AF21D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72A86185A;
	Fri, 13 Nov 2020 17:50:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72A86185A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605286265;
	bh=k8Q80xFk7VPbPap5OWcJpcOxNEQNtKQE0mErV8+haQo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vD2nLzQ3GtpQeIFa8Ef5tODzZ7cYFbTbs7CW2Ztyizi+WAwMFY1OjRcT5PrDFlcXy
	 2P04/RR3rsh6/Y+MvomIOc5Gmhn0gMgVbqCFxrr5uucvs72P7ZE0SanuKk1stUjz+z
	 Mmh3yU0q8RYorjuWiEJoSf/AsGHdZY+Cu2m5WIa4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C73ECF80086;
	Fri, 13 Nov 2020 17:50:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6171DF801F5; Fri, 13 Nov 2020 17:50:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 277BFF80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2020 17:50:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 277BFF80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PtsQVcZo"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37046217A0;
 Fri, 13 Nov 2020 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605286202;
 bh=k8Q80xFk7VPbPap5OWcJpcOxNEQNtKQE0mErV8+haQo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PtsQVcZoOEFBpYKgSLAsSIrqlNVlSKYF+kx1qtP0J/h7Hb5GbtXmtZKuGA55AQWhA
 N9s3tOcDrfKVFdETYb65guigh77R6qacz0ebgUDs+eUIYd8ewJcJRStBiYbYTaoscH
 DMlAjakjFcZVfOoE9iNNISEhd8zQ4IGJ5eIFFGoI=
Date: Fri, 13 Nov 2020 16:49:46 +0000
From: Mark Brown <broonie@kernel.org>
To: "Rojewski, Cezary" <cezary.rojewski@intel.com>
Subject: Re: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Message-ID: <20201113164946.GD4828@sirena.org.uk>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
 <0a0854d1ddaf4f9b81ef5569a7d501a5@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <0a0854d1ddaf4f9b81ef5569a7d501a5@intel.com>
X-Cookie: No solicitors.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "tiwai@suse.de" <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 01:06:48PM +0000, Rojewski, Cezary wrote:

> For a very long time upstream was filled with "flavors" of drivers for
> Intel solutions. Having three available for BYT is a very good example
> of that. The division of what goes where wasn't exactly explicit either.
> This all leads to confusion - while community and users may feel
> confused about what's recommended and what they should actually be
> using, surprisingly (unsurprisingly?) developers were too.

=2E..

> Patchset presented here goes directly against that goal. We, Intel
> developers, are tasked with providing reliable, working solutions
> exposing best possible experience for our customers when dealing with
> our products. And thus solutions provided are called recommended. We
> don't deal with flavors and try-it-out-on-your-own-risk.

My feeling here was that this is helping with this goal in that it's not
changing the defaults but is rather pushing the decision making process
=66rom build time to runtime.  This means that distributions are able to
ship the preferred implementations for all the platforms without causing
any issues for the hopefully small set of users who need or want to work
on a different firmware, if they've been doing something like sticking
with an alternative firmware for old users since things were working
they'll be able to smoothly transition over to the current recommended
default, eg leaving old users on the old firmware by default.  That's a
bit of a niche use case but then hopefully all use cases for selecting a
non-default firmware are niche.

It also means that people don't have to think about this so much at
build time, they can just turn everything on and not worry they'll cause
problems for people using the binary and still get the recommended
runtime behaviour by default unless the user actively does something.

At any rate I'm not clear that I see this actively causing problems.

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+uuSkACgkQJNaLcl1U
h9B4Vwf/TSAjm4ENkwP1NjGr2ERGqssZfIH7o/VWPqIFpgHq/W+hdPDiPbthtaXH
Bk9hDcME2f5tcaVJD3hGC/nzmObFSmsEf0+sjfZUNfwDw3+ZCDqDnxs691kGOQIh
EaWafy54RVVHHxad+sQh24F+E+PkEkwzxQDbtY/5aASf6TG15kdVKtoeghEmgrgn
bszIYaT7353VtvmLuX2pHuhDx8Pdq1oQ/TWF4Xcg7vD4YtHdtlWjfaSBwoqORAzP
L8ygkV5BMXz/ZdmGtncjm+qeMbt8mYKjEFJKRGSc1zlfCzY0lIgh7kKFZ1pd5pyU
MFOSFhU+/Xct/Zr5l5+DgNF5sYPZKw==
=Xhl2
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
