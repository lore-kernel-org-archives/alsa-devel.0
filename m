From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: bytcr_rt5640: Add quirk
 for the Nuvison/TMax TM800W560 tablet
Date: Mon, 18 Jun 2018 13:04:21 +0100
Message-ID: <20180618120421.GD6928@sirena.org.uk>
References: <20180603134232.677-1-hdegoede@redhat.com>
 <ddb258d0-e8c4-fda7-f45f-fc396fc31acc@linux.intel.com>
 <3798fadf-8d05-5a6c-1b19-d246194d3ada@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1128235096930067362=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CBA7D2675E4
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:04:24 +0200 (CEST)
In-Reply-To: <3798fadf-8d05-5a6c-1b19-d246194d3ada@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1128235096930067362==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2018 at 04:00:06PM +0200, Hans de Goede wrote:
> On 04-06-18 15:57, Pierre-Louis Bossart wrote:

> > BTW maybe we should move those quirks to a separate file, the quirk definitions will become larger than actual code pretty soon ...

> I can do that when the next quirk comes along.

> Mark what is your take on this?

I don't know that I really mind - those machine drivers are basically
all quirk tables at some level, it's just a question of what goes in the
core bit and what goes into patches on top of that.

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsnn8QACgkQJNaLcl1U
h9BDMAf+NpQbwG99rdLR8e+AV2RFYnAObL8r/5AijLZZjQ7kpoV27xu13FtlB4Wn
Zrjl/qMdIgCo5y36VdGXC2tShcXb6YayhS2qU9zaFKkOE1cCA71CaZ/8YqAe8cqB
6H1gB7eM7EmmYwlt0YMJUpK2os2f4XpSkS/aS53b9yBeP+Yt1I8+h0MsZmsDLSY9
CKU8/O265isZrL9VL46G45vfoAgcg96VrK3SgU74G0gtanB/bjjc5R719F8DbjTO
bEkQilXiALb/3hYiLbcQUwBa/ooScGAVu4x8o8Gc5XGF2yGhQfa773nrtf729aC5
+oPsNFsrRQSPC6Y3TmW+dakS63MSIw==
=YTeD
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--

--===============1128235096930067362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1128235096930067362==--
