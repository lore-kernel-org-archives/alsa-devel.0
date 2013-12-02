From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: simple-card: add Device Tree
	support
Date: Mon, 2 Dec 2013 12:42:35 +0000
Message-ID: <20131202124235.GA27568@sirena.org.uk>
References: <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
 <87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
 <20131115155028.GE24831@e106331-lin.cambridge.arm.com>
 <CAL_JsqKLd4CbfD6PifXrwWxbyJqnvAViYkXQ63TBniQBPPzp4g@mail.gmail.com>
 <87li0ldso8.wl%kuninori.morimoto.gx@renesas.com>
 <87siur8u6l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2698130424421199217=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 13318261AE0
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 13:42:47 +0100 (CET)
In-Reply-To: <87siur8u6l.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Takashi Iwai <tiwai@suse.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Rob Herring <robherring2@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2698130424421199217==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFGQ2VdWvpciDCpb"
Content-Disposition: inline


--oFGQ2VdWvpciDCpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 03:25:02PM +0900, Kuninori Morimoto wrote:
> Support for loading the simple-card module via DeviceTree.
> It requests CPU/CODEC information.

I had a look at the recent DT reviews and it seems like the review here
is both getting slower and focusing on more and more minor issues so I
think that really everything is OK here and I've applied this.

Thanks for your hard work and perseverence with this.

--oFGQ2VdWvpciDCpb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnIA4AAoJELSic+t+oim9WxAP/3PxxlaZnQYPrCyrKmnO9B8K
o8TyUoxShtDqpyBJ2dclH9UUtp+GJCQwcS/KasHIbOCwc28hIYqW45gPuI6D8SzZ
YRcYWG4bWwensVPMKCb1z77cziBNoPVCEa3TXj8S69i4zs0PKHwkPKJpQ1GiNWiU
MWNRHEKDV2Kyx4fvr7cxJb20wZ0ZKHMDjIJ5Ytk+AUEdFf4T9ay10hiApjEnJPOi
E9CQRMzPOV0zuXCTQwYv7gfM/NgRpm7aHMGj3lN4o6WJvnTLGDsyaQXxmFLMD9Wt
PfkH6Uco8w0V2sP84uZi3jswnG90iXOZnEXqzeIoHYfGiTYEjPaIOngPBz79mA6C
PCAWwoACGI2JDNg1YSI+bhd7D44nscf8LrH7Qte7yA9SrlsEbmOmtGkzHgTxrWT2
LP/xH80YVsXLbqZ+rcfZv4cLIEINAVLiID7ygVODLTdo2Ml4ih+wfJIL2pnVcgxr
PCjwN5XZfTXdDDqGpy1ThLbSr7BbsQWw1gOQx2IA5l+v7DLvrxh3nUuplJOlERPn
l4qUdjxU24W8saxZmfnoF7l0x4zGQHHu5JxAq6cUmBtMDSN05EA1iRG7P6Dd331g
rilPcdJsiesimKLroGAs55H6aRCKeai1Llq9BQ1xD9I9ofUWql8VhI+teTsGjFGa
KgI405Xbna8ebOL+mug6
=hHlg
-----END PGP SIGNATURE-----

--oFGQ2VdWvpciDCpb--

--===============2698130424421199217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2698130424421199217==--
