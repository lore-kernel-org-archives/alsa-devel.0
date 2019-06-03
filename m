From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] ASoC: SOF: uapi: mirror firmware
	changes
Date: Mon, 3 Jun 2019 17:27:43 +0100
Message-ID: <20190603162743.GZ2456@sirena.org.uk>
References: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
 <20190603161821.7486-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0417947329364843004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCE33F896CE
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:27:46 +0200 (CEST)
In-Reply-To: <20190603161821.7486-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0417947329364843004==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LmcuB6YxSMQAV95c"
Content-Disposition: inline


--LmcuB6YxSMQAV95c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 11:18:13AM -0500, Pierre-Louis Bossart wrote:
> We missed these two definitions for GDB support and component
> notifications, they are defined for the SOF firmware. Since they are
> not used by the kernel so far, we can still add them without any ABI
> change.

Adding stuff is generally not an ABI break in and of itself (though
requiring new stuff can be).

--LmcuB6YxSMQAV95c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1Sn4ACgkQJNaLcl1U
h9Du3Qf9H0V+Vetf32dkzHrxtqz899sW7+vIMmG9WnFbinxUZTpZpPOV3T2cqu/i
aFB8ZPFt7ifX2hDhNwOAhZvmSJBR0XbcceWKOFwRe9D/sJp0ylBHQofjWMmmzSjn
83zZRFgCKyolgnHCrXNpFqE4Iecb9KIbx2L6WNptxRRgx9xXNl9FL1PW8hk3ddqq
3hFA6Bz4tXFcAV55ncLYtuKmm2Vb/BC1vTnluTPWyKJ6fwz8sswemV4uDcfIsYtI
xBktS5a+b4TK01KqDgsrTduZxaynLlF8XbYpac87Ju+l6lLS0qwuECXZS4kt+nYn
ka6kjye8MeqdBDRWwGfwxUtY/hHKVQ==
=2h30
-----END PGP SIGNATURE-----

--LmcuB6YxSMQAV95c--

--===============0417947329364843004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0417947329364843004==--
