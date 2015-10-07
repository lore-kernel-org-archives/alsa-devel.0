From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/8] ASoC: Intel: Skylake: Add topology
 core init and handlers
Date: Wed, 7 Oct 2015 15:28:35 +0100
Message-ID: <20151007142835.GN12635@sirena.org.uk>
References: <1444213919-32369-1-git-send-email-vinod.koul@intel.com>
 <1444213919-32369-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4875348782419387970=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA91F265E1A
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 16:28:57 +0200 (CEST)
In-Reply-To: <1444213919-32369-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4875348782419387970==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RJ9MQpJQekB+WfHw"
Content-Disposition: inline


--RJ9MQpJQekB+WfHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 07, 2015 at 11:31:56AM +0100, Vinod Koul wrote:

> +bind_event:
> +	if (tplg_w->event_type == 0) {
> +		dev_info(bus->dev, "ASoC: No event handler required\n");
> +		return 0;
> +	}

This looks like it'll be excessively noisy...  why does the user care?

--RJ9MQpJQekB+WfHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFSwTAAoJECTWi3JdVIfQFrIH/3o+NXbD8GECoDQcpRq+uL8W
ieiw4/twQ6AMx8EKjVHeM3w1Gdx2Ets+gLOkcpeVXiNONo1CycdTmZcsqarlcl2e
LwFTxIA33MJ7zOIHjvPfd39jwgYi1ynTa7alQ6+gHdaNGIUCsOFLZxgZ3IszuoIV
DaKYfXUEXrsD8DwjshouLn3KIv8gmI01ZFShGKOqCa39WkLrUxjHweQyxN1ncO1Y
f0GAQ9zfIUu5/pYaWsnlinu9vcv+kEnHw4kZ6g6tiDBV49/hnBF/hEjgry1yw66M
ZJpflqqHdUMM44IkdRoBbZGU/ygOSYF8epY6rchf/yJVod+X0JIjDRjG1KMEaqM=
=BA9/
-----END PGP SIGNATURE-----

--RJ9MQpJQekB+WfHw--

--===============4875348782419387970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4875348782419387970==--
