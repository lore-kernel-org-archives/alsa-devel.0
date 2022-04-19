Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68433C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Apr 2022 10:58:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 180AD172F;
	Tue, 19 Apr 2022 12:57:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 180AD172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650365911;
	bh=QmakAlgYzbO33E8PQxxvJSmaiTWpTxz1j5RJWtgWLQg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oYV0y1zxvDjump51uZkGx6PWJ2wWlYHM9O0qOtBQ+/U5bfms4jaQgEsCKEBNoTuOl
	 B6cvupdQlGsmzBEp4sTEtW0DkyNkh8l2nvkiSDJGkhum9fiROY5fpT3yK5Dwk5g/to
	 gbcDem2QCkN614O5ypaZ9shsjkQua4uyD7QNVNKA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99922F80237;
	Tue, 19 Apr 2022 12:57:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83595F8025D; Tue, 19 Apr 2022 12:57:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20D95F800C1
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2022 12:57:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20D95F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qcFDjroV"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC60610F4;
 Tue, 19 Apr 2022 10:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DC1C385A7;
 Tue, 19 Apr 2022 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650365850;
 bh=QmakAlgYzbO33E8PQxxvJSmaiTWpTxz1j5RJWtgWLQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qcFDjroVvHeZZmkbtARE/ecx1DXyR8QO9D0FkEqLdTk4k6y7xr9Ad1w9PnKBTet1q
 odluExfEUJQvVLAlvujaXsn1OjMvtFz07481rACegvBs9y+gjAtruLZfORvMwXmdx+
 JmjFh5icBU5G7auIypsCkxdQwXR7L8rb9iR+cTB6x4EZ69hGykHjPBLtzObr4wJXJ2
 4jRiZNFOiWe7W9SaEzZ6Xq95bw50eloRoocTdJGVF7G0zQoaR+jaA3xCaJB9ujfN7L
 6kEWIurCYGReyholrAcx9X92f0N8JxaqjF5hxkj/m+3kC7rfamrzI+MZJJ2JTAS8Fy
 pAlCWMhKrubEA==
Date: Tue, 19 Apr 2022 11:57:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1 2/4] ASoC: ops: Fix stereo change notifications in
 snd_soc_put_volsw_sx()
Message-ID: <Yl6Vljzvc9nTowEq@sirena.org.uk>
References: <20220201155629.120510-1-broonie@kernel.org>
 <20220201155629.120510-3-broonie@kernel.org>
 <c77d892f-4ff3-f7ad-482f-c9673a3cd86f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yqWp3QezW/osOzvz"
Content-Disposition: inline
In-Reply-To: <c77d892f-4ff3-f7ad-482f-c9673a3cd86f@linux.intel.com>
X-Cookie: That's what she said.
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
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


--yqWp3QezW/osOzvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2022 at 04:33:21PM -0500, Pierre-Louis Bossart wrote:
> > +		if (ret == 0 || err < 0) {
> > +			ret = err;
> > +		}
> >  	}
> >  	return err;

> cppcheck flags a warning on this patch, I believe we should use "return ret;" here, as done in the other patches of this series?

Yes, I think so.

--yqWp3QezW/osOzvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJelZUACgkQJNaLcl1U
h9BXRwf/fz+Hu2QOnKw7xwTmsNMx/E9uc9Q7hkK+Hhbe1/ZBMPhZac8Eo0Pvrlc8
h9jFg+SjlhxEuBYLpgHNCOOO9+ZJFx7nBLkz91SEV8w90CqBMG2tUvi4qz0P0pnd
0BvLTNh0+IJD2p5ADe5ZkTlRn015ZEwh8dyJY1HJ4SXKY5UXlrINJu7lg3BjS5mb
ziNj4ZibTTdubwpOk7uTPb2fWby2jGOcmpNJ5RbmVgQxMoMwRX57rCBMLpZnDgCn
qb1vxhvhAsSz/I6kWC5bZndLIT4dXaCniyXGSmr7PwkobjEldm+PVa/vhUYrYTGK
3Ban5PJZg1l7LOsOaBJAZDNKmNbFNA==
=80pR
-----END PGP SIGNATURE-----

--yqWp3QezW/osOzvz--
