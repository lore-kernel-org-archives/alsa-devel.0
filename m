From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 08/11] ASoC: Add component level
 stream_event() and seq_notifier() support
Date: Sat, 21 Jun 2014 21:35:04 +0100
Message-ID: <20140621203504.GD22657@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4669639160626852514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED00D262618
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:35:29 +0200 (CEST)
In-Reply-To: <1402935191-18398-9-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4669639160626852514==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:08PM +0200, Lars-Peter Clausen wrote:
> This patch adds stream_event() and seq_notifier() callbacks similar to those
> found in the snd_soc_codec_driver and snd_soc_platform driver struct to the
> snd_soc_component_driver struct. This is meant to unify the handling of these
> callbacks across different types of components and will eventually allow their
> removal from the CODEC and platfrom driver structs.

Applied, thanks.

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpex0AAoJELSic+t+oim9x9wP/0dZ5q39Lzwg/TfbhCjHhKG0
YudjkUMcgO7heIbaDnpx441v1jfA/9aLtxGv4IngCEmW15MLh360C0HY7/lnHBHe
jeqEI3IUIfEiVfSgSasuk4Aib/ZJnhDpWrUVivnaCRqZJaAoxqkrscnwXnHAtxPj
N1yJRM3MIOYKf87jE5DgR6B4Pr9OYnUDN/36migAsVgeBUaCh7oto3b2c+yyIbf7
V77YSVmFqeK3biOFpVFPGGMnDa0Ny/0ywD+GcGV3dU7+qbB3CAKeVsRT6R/63FE0
WWOX7pPNYnV+qclvRKnmFnd8L6XpzeFlSYnt+fLhzWNXMD9DvHE2GdCFu94EjghQ
D7hXlmJQJxaoshypin9DxK8sO/GKORMI2MIFOJNuPTS7sCyJNmQFyUBMCZRxFFHB
e4JChNEI3l8C782vy2+0pMla4VhxHeNBlZ+oB5lauCB14kH1VP9GQXJfix3sw3tx
5ljwxsxmGWAVbbVxzPlLZTbvSfwfM1MKfdoBv+j+r+4J3BBRE1wQMeritsLzUCgx
LPGWJaDIFnZJyrjt3bJ3myz9Oa+gnIYCiIK5iu66oUm1K8xGcUxYut56X7tn05Mf
4DCfN6KkOmKANGLR4EDYbjC1rEOs43Jl24pjFkGz+e1O9hxN9dyCd+oyHjLz84wF
+wC3Fw6TW7djcnSGUOGJ
=RwSb
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--

--===============4669639160626852514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4669639160626852514==--
