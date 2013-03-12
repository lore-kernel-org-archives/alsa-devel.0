From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: remove codec from list if
	registration failed
Date: Tue, 12 Mar 2013 18:38:59 +0000
Message-ID: <20130312183859.GJ19942@opensource.wolfsonmicro.com>
References: <87hakmacqi.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324447113100804604=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7477D265DE5
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 19:39:01 +0100 (CET)
In-Reply-To: <87hakmacqi.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0324447113100804604==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline


--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2013 at 05:42:33PM -0800, Kuninori Morimoto wrote:
> Current snd_soc_register_codec() adds codec to list, and calls
> snd_soc_register_dais().
> But, this listed codec should be removed if dais registration
> was failed.

Applied, thanks.

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3Y8AAoJELSic+t+oim952oQAJpfKoZuKW9GHpYoultQcLkO
Imr9U3liiBspLhp5PGAISMBc/7wLIkDhRJVq+3uQ1y4ttjpKPEESmkjYUtYFw+yK
tc4BV54LN4CCBM2ezN3AV+yWhk8glp1IMBVxIOjyxUlMPbEAI3DyIFX8TfzpIiyX
fLeRisAwND1GC7IMx9PbhkzKwqhL0S5OXLjtLrBIjDoNGxgEYKZGwe0penBwizwx
RdCEQMnPy3MXq5tU7gEB93mea0dfoo4r3oquU4v5x0rlGHGpL+ETtozE2f6fY2rC
EHU2h6WyNAECJRw/dHSnCcGM3Di/ZMsLfbpXtmuc3yG0BLaZ+0kJ8+V1/JyI1Ytb
eLM/qgN45u8kzTz1cXlxKhCy6ZeE61RktkkJ+zoC8O55aVQAdcs2cpqf2yKo4O2X
qPWZXcB037zw0x5H1ArzuOY7yRXVQRlv0HnWZcU3Q+U0gkVFU9GVrgLm0eGUaVQo
aODtKfiIwbLUXGkD9ukjTNGvHz3tKc8/HPBxznReSq/Pjxs2H2Qsh3ZgEN38dKNv
IIGKXHyqPD2erMGAmFZJRbuYJAJ0DcmE651ALJEy9dRVDc0wrx8jx8rd/KDiIzYA
zWAeKioB4EMdvE6Oy32JuRg63S1DceSTYvkKR9lYPfKq6DFSWMgmxveVvT81V7qh
vvqMHTyW7SGTCOiG4VZn
=2/z5
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--

--===============0324447113100804604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0324447113100804604==--
