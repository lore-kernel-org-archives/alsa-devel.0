Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0533C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Dec 2021 14:40:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 297D01FD6;
	Fri, 17 Dec 2021 15:39:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 297D01FD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639752000;
	bh=1py8YEUc7+RRZPmDp5N21wqmzTdz/wNKodlBuKPl3zI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BiDCKlRrqhetYoWlA2ofLv+kPUnQFTIF68mJp5sU3v31166ogdYuBz3QSbBjAoNxf
	 lKKyfXV85L2fZY/4sernFGHDbEzLog6OdKYtzQHUfSZPXjXY2vHwy7zEedoj3SXZYm
	 QtBMRneQHA1sjqC3MH5zcXDSexCj0e3dhLYy8F1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAAFFF80148;
	Fri, 17 Dec 2021 15:39:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39383F8014D; Fri, 17 Dec 2021 15:39:05 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2F1AF800B0
 for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2021 15:38:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2F1AF800B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="irWYCY2G"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E29F362236;
 Fri, 17 Dec 2021 14:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A36C36AE7;
 Fri, 17 Dec 2021 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639751936;
 bh=1py8YEUc7+RRZPmDp5N21wqmzTdz/wNKodlBuKPl3zI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=irWYCY2GgMeUK3h2Cp8DbOddu1vAd2pRFBlxpZQXyj7FtUgnqx48/NgRo/VvXkSr2
 C/AYE6X4Zz5QJDlyl+Sdmr2jFEpY5VB1n04gHSpsWTcRls5JMe9B8+cWtCcwF44eS9
 73bll5arhRpWcB/BRSMOFEXAMgKsdoZUt4f5vqxBeBHuA+CxrkBR1xqrW46eOdvqPe
 O1vrwmoOHUw/qAOjybuLOIbjffc79qdw04zUWDVLi3nAiJmKdtrsS5lSXwSUJIUcV6
 682IW6NemXia4vecHXLkbdZXzble22bC3mzsLHsl3XWy9JVuNDxZwdv0lTM8Z2ubIT
 WI2R/1yF+F2zQ==
Date: Fri, 17 Dec 2021 14:38:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v1 1/2] kselftest: alsa: Factor out check that values
 meet constraints
Message-ID: <Ybyg+x636Y2nMcVb@sirena.org.uk>
References: <20211217130213.3893415-1-broonie@kernel.org>
 <20211217130213.3893415-2-broonie@kernel.org>
 <f0caf4d9-5e1d-4b85-9d2c-00b65fa97638@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="om3rC0OC9HLnE0wA"
Content-Disposition: inline
In-Reply-To: <f0caf4d9-5e1d-4b85-9d2c-00b65fa97638@intel.com>
X-Cookie: Pause for storage relocation.
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
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


--om3rC0OC9HLnE0wA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 02:32:24PM +0100, Cezary Rojewski wrote:
> On 2021-12-17 2:02 PM, Mark Brown wrote:

> > +	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++)
> > +		if (!ctl_value_index_valid(ctl, val, i))
> > +			valid = false;

> Correct me I'm wrong, but it seems a 'return false' would suffice. Is the
> continuation of looping still needed once a single check found above
> evaluates to true?

It doesn't affect the result of the test but it will cause us to print a
diagnostic message for each invalid value rather than just the first one
we see (eg, if both channels in a stereo control have an invalid value)
which seems like it's more helpful to people working with the output
than just the first error.

--om3rC0OC9HLnE0wA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8oPsACgkQJNaLcl1U
h9CNdAf8C/eni0hxTMnq5QhNv6oc1VdsVmjqTEi8LHuPUNoqg8DVpAYp+bDoLwol
6qxngYkBLZVd7kQRyP162K8ydatZHbkQVqdFfKqdiWDnEIRACOBKR4m09abSZ3xJ
abMFEAcRRkggY7aRobasx4b4rW9ZtizCdDUBJKhj3s0d9nztbNcixL3IsmozfN8b
h+mIQkyRGX3JSInuj/u6z+P7Rxrt416pOlDIRQb7qFImIYWvhwtYdZnI8g7Qx+D+
m82peIS4Lzu72RE53EZCkXtXTSTwF6llZLazKD7gBwzgErwaekhlz5ln6Mm8eZBS
/+79IQWYcVvlcuG7X4j9zoh1p1zPHg==
=j0J9
-----END PGP SIGNATURE-----

--om3rC0OC9HLnE0wA--
