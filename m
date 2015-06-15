From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Mon, 15 Jun 2015 16:57:52 +0100
Message-ID: <20150615155752.GV18309@sirena.org.uk>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4806353168590113665=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49D9826520E
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 18:25:08 +0200 (CEST)
In-Reply-To: <1434040438-14535-4-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4806353168590113665==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WN2ELtqJJ9aZ3yHj"
Content-Disposition: inline


--WN2ELtqJJ9aZ3yHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2015 at 10:03:57PM +0530, Vinod Koul wrote:

> +config SND_SKL_PREALLOC_SIZE
> +	int "Pre-allocated buffer size for skylake HD-audio driver"
> +	range 0 32768
> +	default 64

Size in units of...?

> +	help
> +	  Specifies the default pre-allocated buffer-size in kB for the
> +	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
> +	  for systems using PulseAudio.  The default 64 is chosen just
> +	  for compatibility reasons.

What are those compatibility reasons - why should users have to worry
about this?  Should this be a module parameter or something?

--WN2ELtqJJ9aZ3yHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfvYAAAoJECTWi3JdVIfQAioH/38lrWF/YXanbvuL49XoEYD1
F2gq9w/yoFNVD03dC5EH3n3k1JzpRjv7AyCmx3kDqWY6jVxhK7eAItv862pNeG5G
YqP2/t++1KqX+7ct+mm58rTiJtZQro+T18bj/ni1p9aek49C1juuOy6XfR5NoyZF
VAreei4ixjDYLMx5I6Qt5z6OrZhPcrNIerBfUJDVtvHhyToeSuJcRFIzA+Kd/aHn
akH48IkH/8al2ShLExKAH2gwoDA1CibayN+CwE5HoouEutBdO+1EX15WbygpJcSn
0aJOuffdIMloL5ipPmns3KmHz87jP1VFcE3fvXcPQctLIwK9ju+6GxPOwbJC2Fk=
=Nz2x
-----END PGP SIGNATURE-----

--WN2ELtqJJ9aZ3yHj--

--===============4806353168590113665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4806353168590113665==--
