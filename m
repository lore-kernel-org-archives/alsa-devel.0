Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99740C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Mar 2022 12:45:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D22D21ADC;
	Tue,  1 Mar 2022 13:44:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D22D21ADC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646138715;
	bh=Dvmj37OjCzYRSD5lH+68CdPQAV0uvqJN0PHM1p+T0So=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SEBGG3s3Mln8p/CIuiU5hwmQy5yp6+zGIroaICwf4N+6E3P4Hp1im0GfxVvHAgr/N
	 VVYDzXtcVHeLStZPmi1lI9p11buFr0EeQxH6uPd3/uz6Lzpsm7psYRuWGiAuNoyd4K
	 IaTcy9ALlmxEYbbNUZ/mL8HCedVGZOlPZdR2bY0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C58FF80167;
	Tue,  1 Mar 2022 13:44:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5FD4F80227; Tue,  1 Mar 2022 13:44:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C983F80167
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2022 13:44:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C983F80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cvEy4Cel"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 58B9161229;
 Tue,  1 Mar 2022 12:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6ADC340EE;
 Tue,  1 Mar 2022 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646138659;
 bh=Dvmj37OjCzYRSD5lH+68CdPQAV0uvqJN0PHM1p+T0So=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cvEy4Celqtz56G+ZmoQDluWwekayBnfTCkFgpjXIFUH67plCHqLaSs3bbB243KlIR
 c45wYDECEVf4LWJ00ZQiKAcyUSHL64BhIGFvma252WcK0UALkdGdrYGD/dqovDJKtR
 nXEk3Ag/hwkYm5li4hxxk+HMio8KgibuwB4aX5v1Z2zZmHKVjrxL7cIQKNI/tiMITd
 NkO+5zDQZmAzNeWpLD6uKGpNz/FoYh51Uy8J52cCMjZhmPH1IJKDOsrwcP7vK2YjZm
 nonLZCYTS9eYAKYZRMI8CD96NDXVzp27Rt1yTEqCpDc6ETJVDQByLrDXXZXW/TIYGE
 LR+shwwVPEBnw==
Date: Tue, 1 Mar 2022 12:44:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: fsi: Add check for clk_enable
Message-ID: <Yh4VHFviMI/LbjVe@sirena.org.uk>
References: <20220301073949.3678707-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a4D1fYTki8ZRdcZe"
Content-Disposition: inline
In-Reply-To: <20220301073949.3678707-1-jiasheng@iscas.ac.cn>
X-Cookie: You have a message from the operator.
Cc: alsa-devel@alsa-project.org, songliubraving@fb.com, ast@kernel.org,
 kuninori.morimoto.gx@renesas.com, daniel@iogearbox.net, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, tiwai@suse.com, netdev@vger.kernel.org, kpsingh@kernel.org,
 yhs@fb.com, f.suligoi@asem.it, kafai@fb.com
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


--a4D1fYTki8ZRdcZe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 03:39:49PM +0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it and return error
> if fails.

> -		clk_enable(clock->xck);
> -		clk_enable(clock->ick);
> -		clk_enable(clock->div);
> +		ret =3D clk_enable(clock->xck);
> +		if (ret)
> +			goto err;
> +		ret =3D clk_enable(clock->ick);
> +		if (ret)
> +			goto err;
> +		ret =3D clk_enable(clock->div);
> +		if (ret)
> +			goto err;
> =20
>  		clock->count++;
>  	}
> =20
>  	return ret;
> +
> +err:
> +	clk_disable(clock->xck);
> +	clk_disable(clock->ick);
> +	clk_disable(clock->div);

You need separate labels for each enable so that we don't end up
disabling clocks we didn't enable, that would also be a bug.

--a4D1fYTki8ZRdcZe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIeFRwACgkQJNaLcl1U
h9DwBgf/bin2luVJoiauARSYcwKh6nAuT6t1+pRx4vZsv96asJBq6mHzg3Lde11Y
m2QgosA3PwMCLdvAIk4gZc2OQfzLQ6r96lgNEFHE3fmZknc9qPeO5P8275sdgfRy
xn7l5w0j4y/4QoGu6YpE9EidGOGlkLQMcMvVc3CcpIUQLexWdGIgYUoJDT8MaIrA
NNlrI3R296GI6oToypsEEC+KnTcddRKhEqd/wlCTD75OP9WmbQdUkw84mXq4A29F
yDHw4BIYC8Mhx+RvUUXSaBue6Ow0kk58x9hdeFIE7Zc2qRk8xuSTxnju+QXIPNZK
djNrcWAUdWEufFhsSf26mOnIq6bsrQ==
=LFkr
-----END PGP SIGNATURE-----

--a4D1fYTki8ZRdcZe--
