Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E168C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Oct 2022 13:43:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A8377FDF;
	Thu, 20 Oct 2022 15:43:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A8377FDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666273430;
	bh=DLxNH7c1FZVXzwQLcOd7YR17tmEpdJCMRBvl/xA6ZDc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PdgOfsYEE4Tx4S2HVizxxjB3SPL7gpKwDs0i9c7Saj4EIgeIA5++yNZQ66SZNUi+C
	 OalhP8Ug3+nkKZwtNzuEF/gVj7Sm/Uk7E3JkrqJgARzBohN/Y52D1j4/Bf0494LnFD
	 PgF9AA997Cz0rSGgDwOFbDB4V35OW+hnOCh5ceEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A605F80525;
	Thu, 20 Oct 2022 15:43:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EA0BF80525; Thu, 20 Oct 2022 15:42:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CFEAF8050F
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2022 15:42:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CFEAF8050F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZqkWnxUO"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F078F61B7F;
 Thu, 20 Oct 2022 13:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE092C433D6;
 Thu, 20 Oct 2022 13:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666273374;
 bh=DLxNH7c1FZVXzwQLcOd7YR17tmEpdJCMRBvl/xA6ZDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZqkWnxUOuSbj70wtaCTX1RQFs/MYdsL/kdchRLtvzF1glxz5N65wDT8ly3AthuNon
 ca3zePEYLAhbkVEJte+9SLIUceYom6Xqaq8mD61ayVkNn+dMkcVTbotC+Xv+zTkNR2
 eTJSjD+Nup1ab/eiy6ZMpQadpOM/GH2iJ1DY8ErpsjFvUUK11kpvSMIPY8wr0kMEsh
 iiEsgBtZDjMjdmtVLHNt8E0uj7qz61+gl5lRLhqQYpyxOB7HfWdhKBaVAUzp42lJaq
 uDSR3L6Fg8Zff68d6UhfoTSEGrT6FrwTOAAW//Epfrp8+w1pB6YIQKvNwvG15T1rvB
 gEbK/vV61q4IQ==
Date: Thu, 20 Oct 2022 14:42:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 05/10] ALSA/ASoC: hda: ext: add 'ext' prefix to
 snd_hdac_link_free_all
Message-ID: <Y1FQWWpKvKVI2Ca3@sirena.org.uk>
References: <20221019162115.185917-1-pierre-louis.bossart@linux.intel.com>
 <20221019162115.185917-6-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mOu6EHLHWYaXFh8x"
Content-Disposition: inline
In-Reply-To: <20221019162115.185917-6-pierre-louis.bossart@linux.intel.com>
X-Cookie: Today is what happened to yesterday.
Cc: tiwai@suse.de,
 =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
 alsa-devel@alsa-project.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
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


--mOu6EHLHWYaXFh8x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 19, 2022 at 11:21:10AM -0500, Pierre-Louis Bossart wrote:
> No functionality change, just prefix addition to clearly identify that
> the helper only applies to the 'ext' part for Intel platforms.

Acked-by: Mark Brown <broonie@kernel.org>

--mOu6EHLHWYaXFh8x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNRUFgACgkQJNaLcl1U
h9CSWwf+K2uFlBxmmknX9hgu8I+AkIOgBAE+p9M5oDXieZvf+0kGb6VQk56XUJA5
0raS2DZYHzAKkb4wVEIYZSh2bsv4GwHIQG2QPVr6aa1Gssuy83SnZIS0odkgC9T5
jIIYboQZvOI+3/d0uVrztO8OfwhMNCzmqnFOqkGHDsJa6M5VH0qn3bwm6arKv7KA
RMGvk/P6Itywgr4P7lxH6emP+m6hGJ+yl1UabGbF7afW/E7ZlAF4P0bKimdNa9U7
HFhgs3crnJtBBj+c8erY5FpmFG6ZnHQLvygk2Y8zxTXMxMmsBA5cPDqMRxeUlQfB
HyislwFjaPaIW2bhRVChFGDMcxs/Lw==
=FAjl
-----END PGP SIGNATURE-----

--mOu6EHLHWYaXFh8x--
