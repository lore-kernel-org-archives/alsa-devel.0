From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Tue, 24 Mar 2015 10:57:36 -0700
Message-ID: <20150324175736.GA17265@sirena.org.uk>
References: <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <550FFE2B.7050008@canonical.com>
 <20150323164129.GE14954@sirena.org.uk>
 <5511093F.1010708@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4486041326601073224=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 23E642604A7
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 18:57:15 +0100 (CET)
In-Reply-To: <5511093F.1010708@canonical.com>
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


--===============4486041326601073224==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x0PBmTWHB3bjoOVh"
Content-Disposition: inline


--x0PBmTWHB3bjoOVh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2015 at 07:50:39AM +0100, David Henningsson wrote:
> On 2015-03-23 17:41, Mark Brown wrote:

> >>For headphone or headset, one hw switch only:

> >>  * "Headphone Jack"
> >>  * "Headset Mic Phantom Jack"

> >I'd have expected these to be the same thing, just with the second case
> >always having the same state for both switches.

> We need to distinguish the use cases: in case of independent switches, we
> can make the assumption that if the user plugged in a headset, the user
> wants to use the headset mic instead of the internal mic, so we switch to
> it.

> In the other case, where we don't know if the user plugged in a headphone or
> a headset, we need to ask the user what (s)he plugged in, so we can
> determine whether to select headphone+internal mic or headphone+headset mic.

Hrm, I can see that.  However it feels wrong to have no state change at
all on the microphone part of the jack - I think I would have expected
this case to be flagged as a separate mode, say "Tied", so that simpler
applications have more chance to do the right thing.  It's a bit of a
separate issue though and it's a bit late now as we've already shipped
the ABI for the kcontrols.

--x0PBmTWHB3bjoOVh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEaWPAAoJECTWi3JdVIfQWl0H+wQlBxxgz+l8nuscePLzFAY/
RLaAR1RLs9QWsJqqzcswNCmxKyI9w6TXt8RnoIspLEXEzAvYjwjmwMgqeFRVqR0J
Fmuw1pk3orU24wKmmMIWC5erno9ReQKlmHu1Nn+RrIsTrrPq3LEa0CpP/iwBxzJv
kX0ZLfet1V1WjHAEjAsBr497kM+J9tiaM3xGj31V8mpGGkSU3aR/yEmbyXGvPYmN
V0QWmvGv5oggmiPIeqUnN5h9A5V5DdqGy/jyRo4NnX1d90brV8/BjU4nZjqdm1IC
cuqKpMzrhflTlpolYZ3khfbWdStML/etGAHUW629t1K+K2EiJd8hpgiIkS5UnVM=
=H4J4
-----END PGP SIGNATURE-----

--x0PBmTWHB3bjoOVh--

--===============4486041326601073224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4486041326601073224==--
