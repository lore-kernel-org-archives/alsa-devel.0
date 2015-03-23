From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Mon, 23 Mar 2015 09:41:29 -0700
Message-ID: <20150323164129.GE14954@sirena.org.uk>
References: <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <550FFE2B.7050008@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6256563868104459517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 489B6260709
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 17:41:05 +0100 (CET)
In-Reply-To: <550FFE2B.7050008@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6256563868104459517==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 12:51:07PM +0100, David Henningsson wrote:
> On 2015-03-23 11:56, Tanu Kaskinen wrote:

> >One thing that is unclear for me is that how are those jacks represented
> >that support any of headsets/headphones/microphones, but don't provide
> >information about which device type has been plugged in.

> For headphone or headset, independent switches:

>  * "Headphone Jack"
>  * "Headset Mic Jack"

> For headphone or headset, one hw switch only:

>  * "Headphone Jack"
>  * "Headset Mic Phantom Jack"

I'd have expected these to be the same thing, just with the second case
always having the same state for both switches.

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEEI5AAoJECTWi3JdVIfQOLAH/3sU8/orWx7cIKrHB0OdgLVl
nL+jYHlPoYod8nhlmMPL+0YLsWHr1Gr1rjSyNRQicy/nTSy1JIYalQ6M6mIqZ/zc
6X/rQZlAYkPyw18Xk62bI3T/YAkHolKqSRWHyIE8bUCVe0LzdeZf5k0fTXRRTJNs
ydTNQ2e+QZuUkRzwJeEvrculshJuVuLlM+Jc0umNKCh1hq07fzLGvzZykjoYVTdC
KiFhPiHchNyUumE7byPungD92H1PoeQXNtIs8ZCV9hMa3Jt0Qgm6MtrvcPucqjFn
maSTMKopo7eMO35Yows6YPNJS5UX85q0I8T+lvB9ajTmDDsObRL0GwTH5HHd+UI=
=Vg6c
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

--===============6256563868104459517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6256563868104459517==--
