Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32026C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jan 2022 18:45:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D527618C1;
	Mon, 10 Jan 2022 19:44:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D527618C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641840316;
	bh=GE2tv80eyEq7BhKakdnfhLRqwW1E0SLYE7oZoKuxreY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k/q3rXiElh3gtW0Sw7KrhbResZ4PlO5nk9kkpLTAmFLPt2NbUn/1RUyfGJxp0Wmqt
	 D9VKvs7LFdPB14+vCnl8KemdYY79HVt8/jElmrayK0t1r8NigsktFjEkc6f64RUvfS
	 ochQZZlPS+BTy2gzTY3F7+u9IkEVe82KUqSkt1y0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72363F80125;
	Mon, 10 Jan 2022 19:44:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BA95F80118; Mon, 10 Jan 2022 19:44:25 +0100 (CET)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FD43F80118
 for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2022 19:44:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FD43F80118
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 7D4E61C0B76; Mon, 10 Jan 2022 19:44:19 +0100 (CET)
Date: Mon, 10 Jan 2022 19:44:19 +0100
From: Pavel Machek <pavel@denx.de>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv()
 recursively
Message-ID: <20220110184418.GE3396@duo.ucw.cz>
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2f338a37-f2ca-33e4-284e-5d263f7b93da@intel.com>
 <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 alsa-devel <alsa-devel@alsa-project.org>, Pavel Machek <pavel@denx.de>,
 Takashi Iwai <tiwai@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 LKML <linux-kernel@vger.kernel.org>
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


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On 2022-01-10 10:47 AM, Lad Prabhakar wrote:
> > > Instead of recursively calling rz_ssi_pio_recv() use a while loop
> > > to read the samples from RX fifo.
> >
> > Recursion and loops are means for doing something repeatedly. Could you
> > specify _why_ such change was made i.e. the conversion from one method
> > into the other? I bet the code is not being changed for the sake of
> > changing it, the reason is simply missing in the commit message.
> >
> I had feedback from Pavel "recursion is unwelcome in kernel due to
> limited stack use." which I did agree with as a result I have come up
> with this patch. Also to add this driver will later be used on Renesas
> RZ/A2 SoC's which runs with limited memory.
>=20
> > Please note that refactoring below function into while-loop has a side
> > effect: everything had to be indented by additional tab. Generally,
> > readability increases if function is shaped 'linearly'.
> >
> I do agree, my initial patch just added a jump back to the start of
> the function if there are more samples, but Biju suggested to use a
> while loop instead.

Yes, loop is better.

I'd actually do while(true) and avoid using the done variable.

    if (!(!frames_left && fifo_samples >=3D runtime->channels))
              break;

will do the trick. Better yet, do

    if (frames_left || fifo_samples < runtime->channels)
              break;

because double negation is quite confusing and looks like typo.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYdx+ggAKCRAw5/Bqldv6
8iWeAJwMFgmovkkcykQkiCov9xgLKwcKjACfRihbqO9B2VDa06HpO5bEfLl222U=
=AYcv
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
