Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE955C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 18 May 2022 12:08:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29A8A20B;
	Wed, 18 May 2022 14:08:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29A8A20B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652875733;
	bh=J3/tR7Q+oe314sxSoPFX/GSG0Vdo8AD9s6k1muJ+ljU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uZlALNvxcg3e/Th1gZkL1RE4cqKIE2BC4R3m+d/rIPY3xvXAfSRV23B5KXN49ri1h
	 t1yQy0xkgeFHOna4chYd/jFmevP4vdAG808fVhvadjWEQQ30NCNZ4a+EHuOgupQVir
	 N2hwvEajX8SXlGjNoGVor7YxCSERap8AzncrR7oI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99A61F80159;
	Wed, 18 May 2022 14:08:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6B88F8023B; Wed, 18 May 2022 14:07:59 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33EA0F800E1
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2022 14:07:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33EA0F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cJjZHkBO"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BDEA661529;
 Wed, 18 May 2022 12:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28784C385AA;
 Wed, 18 May 2022 12:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652875672;
 bh=J3/tR7Q+oe314sxSoPFX/GSG0Vdo8AD9s6k1muJ+ljU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cJjZHkBObVRkXwkcwhWs5fveXQL0Gcs6hJB31Q20uSJt3Qmo4uu4hHE3K5fJ6rDca
 V2JaAHOvGUfSEAbkNE/r+27qv0comKbEetagxZCQXXOJlMWPwTf1XRUTVh/My8zBoK
 8OXg/lME5acrrWyuBdOqiQzo+y2dnSbGuhuC+v8Z3RJlKsF9m3zNZCZ/yBHwIH0SuK
 axfRGd8rhYKZun5IrDygOVroIWHNnR+b////WWLXHEqTMYOfMtDa+dOYUtTmBgFwvt
 ReF549LeKDH1lGoVhxwjk8TPLjtgFxoGgHdHw/BzLcggTuulZIxaZ/RL1x0/bwlIVe
 EqUkbK7jDCERA==
Date: Wed, 18 May 2022 13:07:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Tan =?utf-8?B?TmF5xLFy?= <tannayir@gmail.com>
Subject: Re: [PATCH] ASoC: ops: Fix the bounds checking in
 snd_soc_put_volsw_sx and snd_soc_put_xr_sx
Message-ID: <YoThkxU9Q2cDrq4v@sirena.org.uk>
References: <fde0dc8a-a861-3c8e-1316-cfa81affc19e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TLTzlqRTLGHvHfuN"
Content-Disposition: inline
In-Reply-To: <fde0dc8a-a861-3c8e-1316-cfa81affc19e@gmail.com>
X-Cookie: Alaska:
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org,
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


--TLTzlqRTLGHvHfuN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2022 at 10:58:40PM +0300, Tan Nay=C4=B1r wrote:

> The commit message in your fix states this:
> > For _sx controls the semantics of the max field is not the usual one, m=
ax
> > is the number of steps rather than the maximum value. This means that o=
ur
> > check in snd_soc_put_volsw_sx() needs to just check against the maximum
> > value.

> For some reason, this is not the case on my end.
> Both the $platform_max and $max fields are set to the maximum value
> of the range that is specified inside the codec code which is -84 to 40
> and not the number of steps.
> This was also the reason behind my patch to the bounds check.

If you look at snd_soc_info_volsw_sx() you can see the code reporting
the range to userspace - you can see the range reported to userspace
there, note that the minimum value reported is unconditionally set to 0.
This is also visible through the API.  What exactly is reported through
the API on your system, and what value is being written?

--TLTzlqRTLGHvHfuN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKE4ZMACgkQJNaLcl1U
h9DU0gf/XqJbrB+FYxPpYOds/aWdFPKoyOIllMLSlTedGqDSRVyxbbvf8cObG2lw
mXfBe3Ut/n6h8KkgwqH9MxrSFWIPwoVuvCVcBdcQt/T24Tq1PLSKIVpltHJrq4UR
+RNdNEpDrj7G6hxHoBYODI2L8mxObTeDGc9PwoEnBo7r2EHm/MwpEx+Y4C7/IQAr
qU7rQVF0V8tlWgkUL+zYmMuCOcEotDUvw0FBOYAVOUwsl7kU5AP8LXmcYXz9lBv6
2tOMSUHF+drmKNES3Eu+nq+80idSzbnqeo/EVwsHOlXBozPo8un2ORafcByXCmPj
cHarzXRNihI25kgyXNeiVPNip7r2Qg==
=nta/
-----END PGP SIGNATURE-----

--TLTzlqRTLGHvHfuN--
