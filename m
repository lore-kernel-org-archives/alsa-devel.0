From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: fsi: add device tree support
Date: Thu, 3 Jan 2013 12:48:56 +0000
Message-ID: <20130103124855.GH4627@opensource.wolfsonmicro.com>
References: <87sj6qyiju.wl%kuninori.morimoto.gx@renesas.com>
 <87pq1uyiij.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1774568124281112693=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E61F6261608
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2013 13:57:46 +0100 (CET)
In-Reply-To: <87pq1uyiij.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: vinod.koul@intel.com, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1774568124281112693==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 27, 2012 at 07:15:19PM -0800, Kuninori Morimoto wrote:

> +- fsia,flags : FSI-A flags [spdif/cpg/stream]
> +- fsia,tx_id : FSI-A DMAEngine ID if needed
> +- fsib,flags : FSI-B flags [spdif/cpg/stream]
> +- fsib,tx_id : FSI-B DMAEngine ID if needed

The flags should be documented - what do these flags mean?  The
DMAEngine stuff is a bit fun but I don't think there's yet been any
resolution of what to do with DMAEngine in DT yet...

> +FSI needs simple-card driver. see also simple-card.txt

This isn't true, the driver can be used with any machine driver.  It's
true that many machines using the FSI driver can be supported with the
simple-card driver but others are also fine.

> +		{ "cpg",	SH_FSI_CLK_CPG },

Is this definitely something that would be fixed by hardware design?

> +		{ "stream",	SH_FSI_ENABLE_STREAM_MODE },

Why wouldn't stream mode be desired?

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ5X1XAAoJELSic+t+oim9DpMP+wd1hswadHGoIMAvwXqq9Vhz
jHttDK1qogC/Sse+swZy8/q2oiEabFxLx5yzsiyitzxFlbdcmQRjmyd0NcJ7pPmN
i0MPbmXf97fyyLE2NWlJN91HhNctV7iM2fjwL791EjcE3FaFrVG1e13WKV+BIZr5
yMfxrVO0WCpJlRT6X/eV7FVPb8VPXgO3Rsp4Z+ddc9d5NpR6MkDMFf7w7FZRb3Io
HezX8ceOWXYiRE/j6bOL9DaLYBDradXyi+TOKIXRIJ3th1RO+fyIfzEzMX4iuZZZ
UpLyt+G9NU9913PGDiVCE2U5QwiCgB4v8yQ7dMLlya4HTWkP8OVtNQ5r0CoEAz6O
I4HM500xuUdv2I8Cp7xx5Zyvaw4htqiYkxyBPK3iGCyc/EcVz8b0zXzLTpGUlxK0
2O46AxDn+u10wTkhXNfWuzk4A1zk60AJ/6BRdtUX7phA/pduor6YkZyBPiDQ6keZ
K/YGJ6lct0RUo8tX13p8hPBzFV8EkYQMoW6clEbKEpR1UMueAn0mjGobh3lgvcXD
7jkut1ldPltFvz6QLKndpnB50rFxWUGB2xZNMhK2jvdQbBIv6lVKWvX2d9OjzrHx
vDXUK/2m1GsXoP1BxY0Be/ftNk11kTTJyORr+ULCsKt71vDI6uoOswm9g7iKcey1
s6Uir9GQwHywAbSOLPpT
=KY7r
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--

--===============1774568124281112693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1774568124281112693==--
