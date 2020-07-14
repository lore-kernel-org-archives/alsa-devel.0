Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F8C433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:36:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1FC22202
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gibPuzuq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjY7E3V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1FC22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEB3B84D;
	Tue, 14 Jul 2020 12:35:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEB3B84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594723006;
	bh=3/kOijZ2Jqvx9fV509wbaqAHppjbu3yqiHK4P0pxR9Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gibPuzuqeYLCeTfEhomD3GyWOJ77mkALyoQ88JoydfD8krttuoyTLJiYO5EcohVQY
	 0waHxxOpsh0Hp2wRF5KXevpa9HLJg7hmAL0qbabdyyfRen5Euu7001hYoqRBqful+3
	 68tOzXXulv8vS32zjrazloIFb/vOrq89P7lojAno=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 623C5F8014E;
	Tue, 14 Jul 2020 12:35:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69159F8019B; Tue, 14 Jul 2020 12:35:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2002EF800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 12:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2002EF800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pjY7E3V0"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60FE622206;
 Tue, 14 Jul 2020 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594722945;
 bh=3/kOijZ2Jqvx9fV509wbaqAHppjbu3yqiHK4P0pxR9Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pjY7E3V0aZv5d0i3fKoYwYgQvjmUZbyEsIzYHmUq5g14ANKoqVoX++pY66mGoIIUJ
 qwVw/Ls9ErxPp2BfWk5o7i5uEDzud+LydFzgGusYIheTZtJvHqESSAn44tOWSiIkr8
 OfL3jLVRUDbrvwVY6WgKIlFeRs5I5yKR5zbIyxmo=
Date: Tue, 14 Jul 2020 11:35:36 +0100
From: Mark Brown <broonie@kernel.org>
To: qiao mnlife <mnlife.qiao@gmail.com>
Subject: Re: [PATCH] soc jack: When snd_soc_card_jack_new is not called or
 the call fails, calling this function causes a null pointer access
Message-ID: <20200714103536.GC4900@sirena.org.uk>
References: <5f087f1b.1c69fb81.2a42.d99fSMTPIN_ADDED_MISSING@mx.google.com>
 <DM6PR12MB4122CBAFE14C28D7302272E3F9650@DM6PR12MB4122.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4122CBAFE14C28D7302272E3F9650@DM6PR12MB4122.namprd12.prod.outlook.com>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: open list <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 =?utf-8?B?5LmU5pif?= <mnlife@foxmail.com>
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


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 02:56:03PM +0000, qiao mnlife wrote:
> ________________________________
> From: mnlife <mnlife@foxmail.com>
> Sent: Friday, July 10, 2020 10:45:42 PM
> To: mnlife.qiao@gmail.com <mnlife.qiao@gmail.com>
> Cc: mnlife <mnlife@foxmail.com>
> Subject: [PATCH] When snd_soc_card_jack_new is not called or the call fai=
ls, calling this function causes a null pointer access
>=20
> Signed-off-by: mnlife <mnlife@foxmail.com>

This looks good but it's a bit mangled in submission - can you please
try to resend using something closer to the format in
submitting-patches.rst?  The changelog should be in the body of the mail
and there should be a patch subject in a similar format to to the other
patches in git.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8NingACgkQJNaLcl1U
h9BIMQf/Yem6Wc8n49m8Tf5PlTiHnGyVemElmr6g1eJO0rZT66Dm+8tiK6ep0MHa
OWFTmZPF0oec1a2jQgLEgDw9WwMXlNvYoBp6UFPEkS0hJafnRl5Xq0F19CyrSHTr
H9yLrzFlAoiCfv0jiOQFiCIyCFdOapUQpe0T81jlG8cXh/UIXGs2AKRdbNAmVUFX
zVPVtFzfK0XHMpoVZv9qS4EvyaAzd7KKAjzGJsri7OrbBAxbjTETz3wKdKwMGnCe
jRM0DkTEOYPD0ZeOFqquloDz/q3u3gs1VcKaWaxwWoW1Vjg/aOi4v2XHqTZfmysO
a1PNiLk+AjAGnIx6YMAqzjXHp9MVBg==
=+aKm
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
