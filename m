From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/4] ASoC DSP topology
Date: Tue, 21 Apr 2015 10:28:12 +0100
Message-ID: <20150421092812.GA22845@sirena.org.uk>
References: <1429217285.7100.18.camel@loki>
 <5535F513.8030902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8335223626896286539=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A6A626069D
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 11:28:23 +0200 (CEST)
In-Reply-To: <5535F513.8030902@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8335223626896286539==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 09:58:27AM +0300, Peter Ujfalusi wrote:

> It is not entirely clear for me based on the first look, but who is
> responsible to initiate the topology load? Is it the component or machine
> driver? We have had issues with deferred probing when the component driver was
> in charge of loading the firmware. I got around this by initiating the FW load
> from the machine driver and via callbacks I notified the component driver to
> take over from that point. This fixed the probe order and I can also handle
> cases when the filesystem does not have the firmware so I can fall back to
> 'legacy' mode.

Could you expand on those issues please?  I'd *really* not expect the
machine driver to be involved in loading firmware for a component driver
(think how this is going to affect generic drivers) and it's not obvious
to me what impact this might have on deferred probe either.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNhgoAAoJECTWi3JdVIfQepEH/2KPMBdAxPlLPFyAC0mPExIZ
ui1onJtjpa2wKeI6LQZKk0sQ1Kl4jOveobyNCdkmMS2uZnhGneIfblNUQUFk/5ni
XMx6ZOyIhrAucdQRokSjOnfSpkERz2K0RAN+E6kydvqnffwsmQNtPBqniUMqj5ee
N9qoE7bhjeAUCU5d+sDfiwGVnVRQ4Ka9HfPjTGhJIeQZDb7MLSF+AYVQD7CC94yR
drBC0XOGfmqkl2NZew8fsxBXhYEzKOu4zMa2RNA4BwfQyXYD7PC2KAPPTxhpGG8I
+ih8Cxg8JDEmNeZ1RLm9sgmSzXQ7OJSC6f0MT/yFFbQ3Pc/BoR/w870QSgOd0GA=
=sKwg
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

--===============8335223626896286539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8335223626896286539==--
