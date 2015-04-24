From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/9] ASoC: hda: Add IPC library for SKL
	platform
Date: Fri, 24 Apr 2015 18:34:27 +0100
Message-ID: <20150424173427.GZ22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-3-git-send-email-vinod.koul@intel.com>
 <20150420215639.GY14892@sirena.org.uk>
 <20150422035453.GE2738@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2972099896764985264=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BFE142606CF
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:34:31 +0200 (CEST)
In-Reply-To: <20150422035453.GE2738@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2972099896764985264==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N9uilN5tARYNx5YN"
Content-Disposition: inline


--N9uilN5tARYNx5YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 09:24:53AM +0530, Vinod Koul wrote:
> On Mon, Apr 20, 2015 at 10:56:39PM +0100, Mark Brown wrote:

> > More prints perhaps?  _PHRASE_DETECTED looks interesting, as does
> > _OVERRUN.

> Overrun is FW detectiong its pipelines are overunning the buffer, no the
> ALSA ring buffer though. _PHRASE_DETECTED is for keyword detection which can
> run on dsp

Sure, it was fairly clear what the messages were for - it was more that
they seemed like things we'd want to do more with than just ignore.

--N9uilN5tARYNx5YN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOn6iAAoJECTWi3JdVIfQTwQH/RMwBt2PzKut1UEA/jyI3zxl
1QSNt4lClAXvbie9eaWawXZ3V+WIKIGR+Kn9va+QfnPW0u9GkcOtgKRiwJmT3d07
Vm/p4Ut/YMSX15MCUjHejRxLMYYuk+vsW+0v5QqBopuvrpC+Wphv6uSrK9l7Ljso
gPOtEhek9Rk2R7eTbvgjXwiMigQzrBNkF6doe8kOBt5z92oHeNsM3t2aMaFFkEB/
+YqHjeaDI4Yo5hpKEMOz6VyANfHc0vPR5XwwNXLvPoxVz1OtY9Hd4L2XKDA6MEpg
zBaeZc7mnT1cjQX5Ml9GqV4dwS2z8WAT853FLr9OmwVrxMNf6OgEsfSoYs6EaJY=
=g4Nj
-----END PGP SIGNATURE-----

--N9uilN5tARYNx5YN--

--===============2972099896764985264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2972099896764985264==--
