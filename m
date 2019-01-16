From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/14] ALSA: pci: Remove superfluous
 snd_pcm_suspend*() calls
Date: Wed, 16 Jan 2019 15:50:27 +0000
Message-ID: <20190116155027.GB7186@sirena.org.uk>
References: <20190115162155.6308-1-tiwai@suse.de>
 <20190115162155.6308-6-tiwai@suse.de>
 <f675ffaa-9966-a05b-7915-a4a16eefbfcb@linux.intel.com>
 <s5hpnsx26tc.wl-tiwai@suse.de> <s5hh8e9fyam.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0985600399929118598=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A74D2666B3
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 16:50:34 +0100 (CET)
In-Reply-To: <s5hh8e9fyam.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============0985600399929118598==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 09:42:09PM +0100, Takashi Iwai wrote:

> The last one has prepare and complete callbacks in addition to the
> other standard PM calls.  And tm2_pm_preapre() stops sysclk and
> complete() starts sysclk.  I don't understand why these are needed in
> prepare and resume.  Can anyone explain?

AFAICT it's just making sure that they're available ASAP so they look
always on to the rest of the system.

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw/UsIACgkQJNaLcl1U
h9Dqcgf/dKAF4FnY6v5U/NlCad3zSlh8IP8QGuqfOsp9Lw495DYOvIiWih4rGfM2
VENYtF1vSgYBc6yTF0ySCq3hnGuP725fQqXEMCMpAwLlTHBoFE43klAd4t5+ZHDu
NKXuvcHbFL/GqLzPTQoJ+kk1HOTX4SnnrOI1jULlU58/28LWiJAP0Fger9nkLY45
JxutG2/dPxLhK2+k6FK/JbF0/hJIgQHJ67Kzo5snXoIyERkNh6BuLncqzzGxHxPH
5scSjc0+zq75d3M6oQJt2s7vc9R8KOoCxFSvuSKGku4terpnGwtKMR9B+IKaA8LU
eH5UCyfD8lfJ9lAf5B+9DY1pb5H97g==
=2JWA
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--

--===============0985600399929118598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0985600399929118598==--
