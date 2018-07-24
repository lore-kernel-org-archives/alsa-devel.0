From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Add a fix voltage regulator for
 DA7219 and ADAU7002
Date: Tue, 24 Jul 2018 18:14:28 +0100
Message-ID: <20180724171428.GQ13268@sirena.org.uk>
References: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
 <20180720121816.GD10784@sirena.org.uk>
 <50343cff-bad4-7677-851f-f0b818ae7b29@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0667450193575793797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E971526733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 19:14:33 +0200 (CEST)
In-Reply-To: <50343cff-bad4-7677-851f-f0b818ae7b29@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============0667450193575793797==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TSQPSNmi3T91JED+"
Content-Disposition: inline


--TSQPSNmi3T91JED+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:56:44AM +0530, Agrawal, Akshu wrote:

> This approach shows inconsistencies and in some boot cycles da7219 fails
> to get regulator. Form the logs (below) it shows time gap between the
> time we call =E2=80=9Cplatform_device_register(&acp_da7219_regulator);=E2=
=80=9D and when
> the regulator actually gets registered.

This hack isn't going to help with that AFAICT, you're still registering
a platform device and relying on it appearing in time?  It just
registers less often.  I think what we need here is a way to register
the link between the devices independently of the regulator registering
or firmware, that way we won't get a dummy regulator.  Since AFAICT we
know the names of the devices that are being registered we can use their
dev_name()s which seems tractable - we need a function in
regulator/machine.h which lets you provide a set of struct
regulator_consumer_supply for a target dev_name.

--TSQPSNmi3T91JED+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXXnQACgkQJNaLcl1U
h9BhIQf9Fw7VLwNBmWVu4Ia61h8wt8CJ6Hg0m4ICosSAtNfWPiTTy+PnMRP/Q0pg
PJbjtkWAeE6TTbeXeQ4F8OHaGa/bvk4q820HM7WhXGfToXkL9iKsE3vjB0U6JqwT
UlUyNIA9d+eV8DmAxxsmG/4hRT13lkXtPF2BdkC6QsmrFWK50Oimh3DLJZOGAg5o
LnuQCCcctf33BQ2ZG2t28QF10NWUqIPGsT9D5GL4vsf9zc5pBD+DxjzgaVA8pgAJ
GOKim7OGpkzZZS/Y5G1QrWSW4hmgj+TBi+gWYcT+z50753trqTN3ZcCH2QuNfado
KOVNcXfo0aQZWNsUI6F1aP0YYcGLfQ==
=Nzh7
-----END PGP SIGNATURE-----

--TSQPSNmi3T91JED+--

--===============0667450193575793797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0667450193575793797==--
