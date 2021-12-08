Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6717C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Dec 2021 12:37:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2A5C26E5;
	Wed,  8 Dec 2021 13:36:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2A5C26E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638967049;
	bh=znyexa54gmAFMVVPsHGzcNM3jz0mBtEth3Prqq4yswg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RSW9BNEmouxLt+6cT6UhtmBD0gohxMsmi6q51WkeYZpELhuAMZ4bKm6g7/58Kt1sm
	 qNvuVjTZ8NQyZJ2+mLqwXils+rLwqSpyBwWYAowh6WBPPJhqf3KLFoVS1+UGQVETtb
	 yu5nT5mvx9TmePIVhK21TKvZxx/2ZJMShzAaFfmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 576AEF804CC;
	Wed,  8 Dec 2021 13:36:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AC99F804E5; Wed,  8 Dec 2021 13:36:38 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B24D1F80103
 for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2021 13:36:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B24D1F80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KiXnLuIU"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id B8018CE2151;
 Wed,  8 Dec 2021 12:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F4DC00446;
 Wed,  8 Dec 2021 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638966987;
 bh=znyexa54gmAFMVVPsHGzcNM3jz0mBtEth3Prqq4yswg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KiXnLuIUa9SKtRE5aqsbmgWhNEpm1iougve1JMZhFdRXPMhSXNUC7AxqZo3ByL9tX
 RH3l8g1ybykYS5z4aZO0f0qApLq0hOKmpldDf/Va4v6GTQu7ULFrZS1BChi2PD9oeA
 T2T1u9eXz5S8xIJrkwGa1bj0A4OYiGC1Ac122OFMcFDGURb18VSkKgzS5igjcmsnEc
 PMr81e70XZPP13You5vTaEK68KNjDOgELTcH188hKMt7jXm/l99UcJMVzdMI3O6+NT
 tcyuowbmg9YnvhGXTbVZrzp6lVGEquL7ozp71q1j4QWZ4E19ujRoHVjyhopB+gfV9l
 pHx9pamuvVNAg==
Date: Wed, 8 Dec 2021 12:36:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] kselftest: alsa: Use private alsa-lib configuration in
 mixer test
Message-ID: <YbCmxkGJ+67dMm/R@sirena.org.uk>
References: <20211208095209.1772296-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="swPdFJYatFmHaV+0"
Content-Disposition: inline
In-Reply-To: <20211208095209.1772296-1-perex@perex.cz>
X-Cookie: Alex Haley was adopted!
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
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


--swPdFJYatFmHaV+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 10:52:09AM +0100, Jaroslav Kysela wrote:
> As mentined by Takashi Sakamoto, the system-wide alsa-lib configuration
> may override the standard device declarations. This patch use the private
> alsa-lib configuration to set the predictable environment.

Reviewed-by: Mark Brown <broonie@kernel.org>

--swPdFJYatFmHaV+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGwpsYACgkQJNaLcl1U
h9DEIQf+ISBqvHy8+SsI9Lpj4vpFpC4TexgHDFQoy+54s0JwjOyecOeiXCF24Rdn
sXwD31/K4c9h0HvsMGu+rK9F9xmtEK1Utax79+fYljytVJG8r394WnklN3qjFOtc
+s7JQAFR2Mp0anw15T89KQ4LjLeI7Mv6gQyvg5k0tXbXDd2HIaa/Fe0CUyIB9n+k
XKA2iUy16Hzhnv4meRPlMgdl3KEcOSuDeoNiX0pBz8r0zudhcrAYy+We2R7Ihpev
5DWvpV4ip/wCxm6zqqRiQ/1vg4ikcW4InrZID4b9dn4cW4pPEiMy8bUjBWDXqHIF
HqD25gRMt1JUb8YVTzkz4lC1MyoW5Q==
=1cX4
-----END PGP SIGNATURE-----

--swPdFJYatFmHaV+0--
