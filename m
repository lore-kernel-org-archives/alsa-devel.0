From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/11] ASoC: Split component
 registration into two steps
Date: Sat, 21 Jun 2014 21:05:50 +0100
Message-ID: <20140621200550.GQ5099@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3555127224305607374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 317882617A4
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:06:02 +0200 (CEST)
In-Reply-To: <1402935191-18398-4-git-send-email-lars@metafoo.de>
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


--===============3555127224305607374==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EYHn5iBSUv6bGbqT"
Content-Disposition: inline


--EYHn5iBSUv6bGbqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:03PM +0200, Lars-Peter Clausen wrote:
> Split snd_soc_component_register() into snd_soc_component_initialize() and
> snd_soc_component_add(). Using a 2-stage registration approach has the advantage
> that it is possible to modify the component after it has been initialized, but
> before it is made visible to the system. This e.g. allows CODECs or platforms to
> overwrite some of the default settings made in snd_soc_component_initialize().

Applied, thanks.

--EYHn5iBSUv6bGbqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeWbAAoJELSic+t+oim95H4QAI+hvGwSHcWkSoPNZH6x3Ms4
u3Er8BW43fENHyNjrsUIi6AQQKkV7gb3AGKeK5v/DeIyLA4u/pwUpnlACp/rcYT8
Kit8BmH/iEQIBJ/Cu33dhm6TDWBBeX7tcw2NAuVTN7vqE8uB77DW41pts2obGRgs
0JNPj5nlVqPJa0sO1NjjGnH78dAWH2fq7Nl2ZA/onlcIZP6opfLzECWvkj2bm0X3
nEbTJB8U/VXD+1PPPBUxm0TTgIK90k92p7SC7x64mdPY2TnTYX/nm/tNATX3qbC/
1ETWFIbhmt+8sR39UMznV43to6apr+F4wopU0C7PsFLXTbkE+mtfe+WzRPL5FuVA
J+k2AqzqPO8WzWGqq2t8ej6+FarBLeteeRfrCrZp+1JJFzGuYKNnk5fRBjK+gdPD
529yV/ZxjzLEckeu14DYVM2pbgItAVxyexnxpCt6KxMzEEPvVsFckVBA8TWAnIYv
r6AovHhpElPJbnCcfm3ALnVA0T3eib+jrZzfEtaDnvbwnwoPzwKB7s99eopo64QF
+6IqtKNSeO6htJzLJljRbGmiGs+F7dE17WCGGpbsIGrq0vtTpJ8FfK9ps5tA3DOB
HckjTk5yn3c69f4iIMWIdC97xv+QlMceaOPuvF6HjN8QqMylrJLcTBEkbCW0neqM
kGPURll6Xh1PRnKpdLcq
=BIxy
-----END PGP SIGNATURE-----

--EYHn5iBSUv6bGbqT--

--===============3555127224305607374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3555127224305607374==--
