Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225DBC43334
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jun 2022 19:35:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2329D16B3;
	Thu, 30 Jun 2022 21:34:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2329D16B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656617733;
	bh=wuKRXOfmB8SfRRAwoXNDYkZyOABp9iiRq5kh8gETWtA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jtVRMnHC4Q3jtqd58DUpJDb4+my+8aJCOkp8W1vAm+jqWYqK/wjSK83KSCSMpWNbi
	 iL8QI5XWiE86uL4sOB1Lj97ndOi1s3ikNAY6NAZ031zpw85aY4WqHlwOCrh9Glq7UU
	 bvI7GSot8IyldmM2azBTkHDPsrdjlRTEGvJ1h74I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6E88F804D2;
	Thu, 30 Jun 2022 21:34:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5C4FF804D8; Thu, 30 Jun 2022 21:34:41 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F5F7F8014E
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2022 21:34:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F5F7F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dUP18hM/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7B3AF61EDA;
 Thu, 30 Jun 2022 19:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C204FC34115;
 Thu, 30 Jun 2022 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656617670;
 bh=wuKRXOfmB8SfRRAwoXNDYkZyOABp9iiRq5kh8gETWtA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dUP18hM/+Z0ZRBUe7RjiwFe60fIYiNSC6bQfruGZ1cLgBrtRsa4yPDJD4a0qeyne2
 H8p3DVMlNt7MhoULUhCBI4jVTWxNDW++jS1V9zvjZrNln8Li/suhwZybIW8SAeqxkV
 6kEo+5nofDk6edE5uFCi3odOuZwh5jeEoNPu76v4Gv8lCUFQf6cPQ0UKCyxwthThZq
 /yyUSpzmq1KC0yHC6+IxCc1qSzuKCMFBurkBwdZoa2iJXjuW/0tOG4eswHDjfWUmrt
 NOVJH51XCPeaSn1oMdT+WGZOYyzsJxMhvb4IqzgqT89b8kaKoT3F7tweWXY158bWPw
 1+pZ/+BgC3yxQ==
Date: Thu, 30 Jun 2022 20:34:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 2/2] ASoC: cs35l41: Read System Name from ACPI _SUB to
 identify firmware
Message-ID: <Yr36wcXf1/bNS0a3@sirena.org.uk>
References: <20220630150135.1799535-1-sbinding@opensource.cirrus.com>
 <20220630150135.1799535-3-sbinding@opensource.cirrus.com>
 <2cc37f6d-72a7-9064-cad2-c6c6d21ede61@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6WIiVmLhV0mRmQLA"
Content-Disposition: inline
In-Reply-To: <2cc37f6d-72a7-9064-cad2-c6c6d21ede61@linux.intel.com>
X-Cookie: Today is what happened to yesterday.
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
 alsa-devel@alsa-project.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Len Brown <lenb@kernel.org>
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


--6WIiVmLhV0mRmQLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2022 at 01:35:05PM -0500, Pierre-Louis Bossart wrote:

> It's my understanding that the _SUB method is optional, not required. It
> may be wise to plan for a fallback, e.g to use DMI quirks or other
> identifiers, no?

Presumably the fallback would go into cs35l41_acpi_get_name()?

--6WIiVmLhV0mRmQLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK9+sAACgkQJNaLcl1U
h9C/Xgf/eroOM+YAPUoAaPvxrWc9YxHojGREu1luQnq3pYAoa+AcA8+oOIMLMp/V
iEglKVXB1Lcb9j1XN9O3zFFikHyvlbsYmtZCNgbfJe6cY6ea2TllZDuDixAjtE0D
eJiL89ksDLjfEMqm4LPeCVp/CklyHDA95DJjP7KQWE1G5qNYzXuydDD7SuS1uR1W
CgR8h+r2RHtIOrYVz2zun+HgEnIdjmEscfWCBg0HE9TPndEr6ByxXIkaL0/N0CAY
t2UukWklkWH1bbhqrHCvfBq7uEGs3n8tMuaXxTP9LAaiaoDytDMUuP79zHphoxya
AUJYkR0+xevNWE1S/JCM3F2EeexGYw==
=z3ss
-----END PGP SIGNATURE-----

--6WIiVmLhV0mRmQLA--
