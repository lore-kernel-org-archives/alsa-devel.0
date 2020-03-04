Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F107C3F2D1
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:45:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF0B215A4
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hif7EzBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF0B215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58ACE1616;
	Wed,  4 Mar 2020 16:45:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58ACE1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583336755;
	bh=dJayMZUPDxmbLeXFkZiZJw9p1oMx6yH1FzUqIj0QRhM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hif7EzBfvWRXv04dW/JQ4T4faif9Qo4N/WLumfIPSL4g9MCyUE8XgOd3j4Dc8beHN
	 tING8AJIS/QI8LGHAbkA8cJdQiX7pbikEiyjEWk2jP70SH1+bg2NKjQi8k6c2sXjos
	 AgIpHDit797yNQUPLOsumpADYVUrHq2tFADD1W+A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8641F8011C;
	Wed,  4 Mar 2020 16:45:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A971F801ED; Wed,  4 Mar 2020 16:45:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 13157F8011C
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 16:44:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13157F8011C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA0D31B;
 Wed,  4 Mar 2020 07:44:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CFE93F6CF;
 Wed,  4 Mar 2020 07:44:52 -0800 (PST)
Date: Wed, 4 Mar 2020 15:44:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: 5.5.y - apply "ASoC: intel/skl/hda - export number of digital
 microphones via control components"
Message-ID: <20200304154450.GB5646@sirena.org.uk>
References: <147efa37-eb57-7f17-b9eb-84a9fe5ad475@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <147efa37-eb57-7f17-b9eb-84a9fe5ad475@perex.cz>
X-Cookie: Tomorrow, you can be anywhere.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sasha Levin <sashal@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>,
 stable@vger.kernel.org
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


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 04:25:54PM +0100, Jaroslav Kysela wrote:
> Hi,
>=20
>   could we cherry-pick patch 8cd9956f61c65022209ce6d1e55ed12aea12357d to =
the
> 5.5 stable tree?
>=20
> 8cd9956f61c65022209ce6d1e55ed12aea12357d :
>  "ASoC: intel/skl/hda - export number of digital microphones via control
> components"

This looks more like a new feature than a bug fix and I've been trying
to get the stable people to calm down with the backports, there's been
*far* too many regressions introduced recently in just the x86 stuff
found after the fact.  Does this fix systems that used to work?

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5fzPIACgkQJNaLcl1U
h9Dv9gf/Zo6deZO28PePM4ljeLF17V7sBRWBsvSmjroL09kiUjDOofrckNa+ndnD
EN5nJq4x2nJn8+9cP1OJnZ8byZOj3Pz1PIGJvb1o92KoJgNCIE0vaWoRzP/5WwS6
RHBiXIA5TYfQ95VTNiCQblTS6cQ+zFh3xkTNTN1K6pRUik1UPtcXvgItXwH4TCY5
KC2xkTguF72fOodW7LYGtarqs6M2oGZMVozPgE4ePP4LOo9TuIYNKis6NcAn0nHV
Z4joo3Xz+2pr23cErldqtTKoamyHfCt5KKo3PExkxcxIp4Nf/ikau7AkfGaCLXE6
EJwvXHeIFjec4f7+dh+wlCxDLUgvGA==
=exwD
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
