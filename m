From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/7] ASoC: hda - add soc hda codec
	driver wrapper
Date: Wed, 6 May 2015 13:51:23 +0100
Message-ID: <20150506125123.GT22845@sirena.org.uk>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
 <1430250870-3169-2-git-send-email-vinod.koul@intel.com>
 <20150504131226.GV15510@sirena.org.uk>
 <20150506034750.GO3521@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1054844974278425145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D47ED261AD0
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 14:51:30 +0200 (CEST)
In-Reply-To: <20150506034750.GO3521@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1054844974278425145==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EHIfaCJCrbNheqy5"
Content-Disposition: inline


--EHIfaCJCrbNheqy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2015 at 09:17:50AM +0530, Vinod Koul wrote:
> On Mon, May 04, 2015 at 02:12:26PM +0100, Mark Brown wrote:

> > If this is for CODECs why is it in a new directory?

> yes it is for HDA codecs which are enumerated over HDA links, but this is
> the HDA bus code which is ASoC specfic. All generic HDA code which uses the
> hda lib (new sound/hda) is kept in sound/soc/hda
> All intel driver updates will go to sound/soc/intel/skylake
> The codecs drivers will as usual show up in sound/soc/codecs/

I'm still not 100% clear as to what a "HDA CODEC wrapper" is intended to
be.  I think this series probably needs an introduction which describes
what the overall picture we're aiming for is.

--EHIfaCJCrbNheqy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSg5KAAoJECTWi3JdVIfQcaoH/iD8l/QeacgGS+vf6hrfKtcz
M2UOOReaWX34t5iyr9mici1OMzsVxcgf31p5k8vGLeBCKtwZNo1q85dXN/7WrlCB
ZIjKJfeHVQEe/p0aHk9IhrBwpmTSqnaePOE1vB0JrwgQpwJAZ3mf3Mp54CqfqoC7
vR8T9l4O5MLDH85hLRe5Zi5IkorBgja/kW4AXnen5niWCC1vSu5pSRkpPV3GkWPl
+X2YyoGnPQKcvB3OOnazMl+kPkfcfyM4ypAPSQdGPbdpjYyZsI8bso4EqgTUasEI
xOvXZuePg1YSFiXJWvdDvsq+K2juVYSa4zZQNFbdFOv03TPQqD76qBP2UiZMZVU=
=2gLd
-----END PGP SIGNATURE-----

--EHIfaCJCrbNheqy5--

--===============1054844974278425145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1054844974278425145==--
