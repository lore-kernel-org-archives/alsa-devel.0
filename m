Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F6FC433ED
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 15:38:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DD161158
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 15:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DD161158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7BD81657;
	Thu, 15 Apr 2021 17:38:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7BD81657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618501131;
	bh=TouW0qJp/5hfYUoj0szueEzzZF99XaHefYsuQ41c1mc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fEB27XjuWK47pSGtdTnr4G+5EhCnJZDBxx9wzEpglFmOqfkzku0m95VUYfd/XZu1s
	 7vzwIP9Ac6IK9vd87QlMsecBkeJ3AhVzJgnwMxXm6OhC73eSPBt8dvxLGDOTojPnJ5
	 nAkvlSmQJ+EGS8NflZmuZuCQ0ofwgeWEZqBslDBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43D44F8021D;
	Thu, 15 Apr 2021 17:38:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3DA13F8022B; Thu, 15 Apr 2021 17:37:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2267F800FF
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 17:37:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2267F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jSXmeOMu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3B04610CE;
 Thu, 15 Apr 2021 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618501071;
 bh=TouW0qJp/5hfYUoj0szueEzzZF99XaHefYsuQ41c1mc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jSXmeOMuIyhSMIQZVJjILCeGpWEgHxMUC0bw/YBbxQzEXD+eICSCfrph1w6oVa2Qc
 0AVuO7OR0xQHh1EHMfHxAiOU8Tl7fVCJY1/V+xJoP7gBZg13cac9QGzPha5zldPxVs
 k/PYAXoJGVibauzwS8s/BtJaxXCRzOfwcejzn7E/niXpSKC9aRy0zVel6SOZDTAFhY
 ouq5juUc6dL4av1k5Y1MJJ0C+Xxt2+jJLf0xRekJxJd44y4CwsZ91rhMg0QtsE5PyP
 X0g4z4/P39ZoCztEm2IherBJXrCPyBZbD2O5ltL7+dnrUBB44aVNKV8x/22JlKqVUO
 j3i1kePK+T2wA==
Date: Thu, 15 Apr 2021 16:37:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: soc-pcm: fixup soc_pcm_params_symmetry()
Message-ID: <20210415153728.GE5514@sirena.org.uk>
References: <87a6q0z4xt.wl-kuninori.morimoto.gx@renesas.com>
 <878s5kysji.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <878s5kysji.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: VMS must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 03:24:01PM +0900, Kuninori Morimoto wrote:

> > It checks symmetry first, and checks each DAI settings if symmetry
> > was true.
> > But original code checked

> > 	symmetric_rate		: DAI_Link / CPU         (A)
> > 	symmetric_channels	: DAI_Link / CPU / Codec (B)
> > 	symmetric_sample_bits	: DAI_Link / CPU / Codec (B)

> > 	(A) was using for_each_rtd_cpu_dais()
> > 	(B) was using for_each_rtd_dais()

> > Current code is using (B) for all symmetric_xxx. This is bug.

> Oops ?

> More older verion was

> 	symmetric_rate		: DAI_Link / CPU / Codec (B)
> 	symmetric_channels	: DAI_Link / CPU / Codec (B)
> 	symmetric_sample_bits	: DAI_Link / CPU / Codec (B)

Right, this is what I'd expect.

> Does this issue had been happen since older versoin ??
>=20
> 	# aplay 44100.wav
> 	# aplay 44100.wav
> =3D>	[kernel] be.ak4613-hifi: ASoC: unmatched rate symmetry: 44100 - 48000
> 	[kernel] be.ak4613-hifi: ASoC: hw_params BE failed -22

> If so, correct solution should be (A2)

> 	(A1) Symmetric checks CPU only
> 	(A2) Symmetric checks both CPU / Codec, but ignores dummy-DAI

I think this is something that gets confused by DPCM breaking
assumptions :/ .  Not sure if *ignoring* the dummy DAI is the best
option though, the general way the dummy works is that it has extremely
loose constraints so it ends up not restricting anything else it gets
paired with but then the dummy DAI might end up in multiple links.

Is it a case of needing a fixup function, or special handling if a fixup
function is there?

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB4XbcACgkQJNaLcl1U
h9Ad1wf/fCNLUj50vxwb5jMQdZS5U3I6S3K/OnRHKG89Be61Yyz7ZhTMVr/RfoSR
mCd5EW722eV35W8TUEt/Ave51wMKO7dgkppeh1fuLE9DA1dbdQsHiCFUZ1sYEPnm
/6ARxXVh2SaXyFBjGP0aNl70VpAQ2dsaj0RMpvm8ItUZ8tfi9c1V7E3oKqSoYVDR
LaCnqZsp4tm7nKJ4b1sCKNGXYUMnLWEFzlXf1d4A4ad1cRNNnnL3+Nx+x2RodsA5
h81+c2Bc8N6vh7oV8QJMGDDxp2sKylkx3dGenrHmOOzk06CsXL5QdPThdJhTFya3
4T5NKy3uV0yuN7ZkrQQ86fsWOfYaug==
=6hXQ
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
