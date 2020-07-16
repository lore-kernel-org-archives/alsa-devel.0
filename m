Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756CBC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:31:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8273208C3
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ye0Zuld6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="beoOAfeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8273208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66F3784D;
	Fri, 17 Jul 2020 00:30:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66F3784D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594938676;
	bh=WpG9Nz+vUXsNwnnFQo6kTLy37Q40YlIhwgs82GMReoA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ye0Zuld6ojWMp9b0/ePbsm95aIbkSqmTpes3/COsKD6Yy6aMx6yyELkBxieEix4Ob
	 YtWyXeNJXrcprrJhuZMi87cf4fEoc8XbYYKrvDVZWeQn9mH+BF8668ammj5KcP6Lrx
	 E7FVck4y3vYWJGt6YmunbhFHnH7y3d+Rh5hPf0GA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B11ACF8016F;
	Fri, 17 Jul 2020 00:30:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AF9BF801EC; Fri, 17 Jul 2020 00:30:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAA00F8014E
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 00:30:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAA00F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="beoOAfeR"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA8B8208A7;
 Thu, 16 Jul 2020 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594938609;
 bh=WpG9Nz+vUXsNwnnFQo6kTLy37Q40YlIhwgs82GMReoA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=beoOAfeRf8b/t27dYfPS7Rb7VXMa5PE7oMxXI/bN7PmvjrUBqI1xJDceo2wt+fu09
 a/hGt+le8EUrIV3u47mTbEsa+2pOxt4LMagSGCojrPCpbYyL/pP0WSEK6z2SdBdEFP
 bJq1/UdSbzdHgJ/huB+EfjrxNTZX2YzPJgXnoke4=
Date: Thu, 16 Jul 2020 23:29:58 +0100
From: Mark Brown <broonie@kernel.org>
To: mnlife qiao <mnlife.qiao@gmail.com>
Subject: Re: [PATCH] ASoC: soc-jack: calling snd_soc_jack_report causes a
 null pointer access
Message-ID: <20200716222958.GA25428@sirena.org.uk>
References: <5f0e49da.1c69fb81.1ede7.a8fbSMTPIN_ADDED_MISSING@mx.google.com>
 <CAGjHXR2ExzMO3ntwzZy9QUhpuqe-VZAXOucNkXXZK+0XZcaQWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <CAGjHXR2ExzMO3ntwzZy9QUhpuqe-VZAXOucNkXXZK+0XZcaQWQ@mail.gmail.com>
X-Cookie: Yow!  I threw up on my window!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: open list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, mnlife <mnlife@foxmail.com>
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


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 08:24:04AM +0800, mnlife qiao wrote:
> When snd_soc_card_jack_new is not called or the call fails,
> calling this function causes a null pointer access

> --- a/sound/soc/soc-jack.c
> +++ b/sound/soc/soc-jack.c
> @@ -44,7 +44,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int=
 status, int mask)
> 	unsigned int sync =3D 0;
> 	int enable;
>=20
> -	if (!jack)
> +	if (!jack || !jack->jack)
> 		return;

I'm afraid this still won't apply - there's a text/html version of the
patch, in the text portion tabs have been converted into spaces and it
appears some other issues that mean git am can't understand it.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Q1OYACgkQJNaLcl1U
h9ARUgf+Mg9kwI/C/ZcV8nUJRP/ff392AISPJd5Xt5EZjYci1c9uk8JW9HhtNcdi
fWwj02+qZRaR8EWVlJUgLLQGLJ+rgm4dRdGkXzrYUXS4CCdeJVf4MPEmw6oMD76v
j+a7qx7btZnuspKbSQe8Lky4xN/cRd3QVW9axOsBiyn6PqiEmyHhO9TjjjrdckLA
TMOC+JtadYnmytwk4OkVu8KEaAVDcVPfKA3TklIx5fIA6mZoLBqqyN+hJmZS90z9
KWXGPnT8/Hxa3fQh4p1kWefphZ0K2Szd6T62EQw7YRczfoR6eeISfVun6Z8WYrTM
CqBHRH9jRWJquvn/0QAZKhyMBf7pFw==
=bQhM
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
