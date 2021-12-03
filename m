Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6EAC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 17:35:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA621244C;
	Fri,  3 Dec 2021 18:34:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA621244C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638552929;
	bh=WHTBc4bgkCtBeEhRXEgFiz4s5kKd4i8rh+TOXdUqZJY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gAAN4B5BCO33ys6eqz3cdTf29/QFXEeIOUC7NgmjxlSD9WVibjJwjQi3tG86fvUaA
	 otDtNIM6C+2sujks+OqxIB0Dt38CajVFFr0zZJ9+PnPRUxZlipFgFcG2wjplusELAf
	 TzbsT/kqhmyjBO1Tu7Apb+YD/flhrC5t4/+1V07Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D80FF8015B;
	Fri,  3 Dec 2021 18:34:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F41A7F80246; Fri,  3 Dec 2021 18:34:36 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D4BAF800D3
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 18:34:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D4BAF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GVrlZDTQ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 98B1CB828D8;
 Fri,  3 Dec 2021 17:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E2AC53FAD;
 Fri,  3 Dec 2021 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638552870;
 bh=WHTBc4bgkCtBeEhRXEgFiz4s5kKd4i8rh+TOXdUqZJY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GVrlZDTQZV7r3Hi+G/5SPgmOHvHCCsgPx3SiNvOWU1VkhlHEnR9KCf8MzUvbROnvQ
 pGMDwShFgRbunhVW76WvIYMb4g7cMJ+XveF7oR7X78f5IyscuWVvQ/MvyVIVtDKRUn
 3Kesbb0/K6VxIfmcpZzVmL+7wIcePSbGA5jBFOTPvi0BtYoHFQs0wW+0w3NzKrhjyU
 0Tc75DoN8dJM54SsIDmomSdwSoTjU3sGyQMMRVDnM2+2f4F+1SQK7J1E5X/D4nT5Pz
 WhbxH60D0VJc3DMFt7LVUyqRhZSfAVyYY2UYryqyVmGDSKX3HFGvR6zaAfiDYE147a
 4CivT/QABHpAA==
Date: Fri, 3 Dec 2021 17:34:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
Message-ID: <YapVH3b9urxvngWG@sirena.org.uk>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
 <163762561675.2471742.16439171676950432106.b4-ty@kernel.org>
 <6a2ff1f0-ebd9-be6d-9b2c-5704edd7c25d@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0HmQJ345lS0f+Xyw"
Content-Disposition: inline
In-Reply-To: <6a2ff1f0-ebd9-be6d-9b2c-5704edd7c25d@collabora.com>
X-Cookie: Don't get mad, get interest.
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 kuninori.morimoto.gx@renesas.com, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, shengjiu.wang@gmail.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com, bkylerussell@gmail.com,
 michael@amarulasolutions.com, festevam@gmail.com
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


--0HmQJ345lS0f+Xyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 03, 2021 at 02:25:17PM -0300, Ariel D'Alessandro wrote:
> On 11/22/21 9:00 PM, Mark Brown wrote:

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

> I gotta send a fix for one of the patches. So, should it be a new
> incremental patch or I can still send a patchset v2?

See above.

--0HmQJ345lS0f+Xyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGqVR8ACgkQJNaLcl1U
h9BVOgf/XdVufglD/qP9remM5BJT0aYWhxGy2k/SnulImK+rVelJFADnkoCZr+tr
acRDTwVyTzcLaXjqzLy18Q5EyBKOan9TBayKNN3kiv60LMacGJZ3Vh+1A31tMns/
qxnKMQ2yOHQp+43Fy5l446Q8gNVfSbBSnr6uhuPXrLqPadPfvm8h7o0o/aqr1q+x
lBu9YRqlZLwtuCOv80lgGtoCjstbLlAcPZqgnzX3VKu76H83cfHjLk+n2s4PO3Uw
q76pYz7sxKaWLJlLw+2DLN2Yf1S3JD7rTHxXhohtrGQFnoAd0wOcD36ezRRERVux
b7lFaTv8PgmD40D1j+UIWK1CRm6kQA==
=nhC3
-----END PGP SIGNATURE-----

--0HmQJ345lS0f+Xyw--
