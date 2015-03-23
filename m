From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Mon, 23 Mar 2015 07:57:30 -0700
Message-ID: <20150323145730.GA14954@sirena.org.uk>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
 <1426865953-1606-2-git-send-email-yang.jie@intel.com>
 <s5ha8z7zlrd.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDBBA0@SHSMSX101.ccr.corp.intel.com>
 <1427105297.2968.19.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <s5hzj743p0x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8107834136267692257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67CFD260690
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 15:57:11 +0100 (CET)
In-Reply-To: <s5hzj743p0x.wl-tiwai@suse.de>
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
Cc: "Girdwood, Liam R" <liam.r.girdwood@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8107834136267692257==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 12:57:02PM +0100, Takashi Iwai wrote:

> It's a good point.  The notification via kctl can't follow the
> complete state changes since it's nothing but a notification telling
> "something changed".  So, events like buttons that need the complete
> state change history, the current implementation isn't appropriate.
> For things like jacks, we usually care only about the final state, and
> the state change is much less frequent, so kctl notification works
> well.

I'd expect the buttons to be going through only as input devices, not as
kcontrols at all.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVECnZAAoJECTWi3JdVIfQ32EIAIC1LL0wSoyheNzc2TYDljaG
HrwBpFGEvnKu2hftaRvRXUKfkdaBUbbIcJggJ8qtd3WbWkbGix7mZ1/71GntZumg
Ymn4q9qobN0buTaV83xafLpUFDHgkq8db0TwKW9rt0xZWhTeyNzMuxI5ZlBZFfOY
7Ks3DB606zz+YXcTl8Xgg91SSKh0+oJJaH3/dtr0uiFdnKIPlQ59r66C59Q8IJZq
L+cSTa0nqM0GjVtaQEFd6zSo79WHbPZ3xU2X8A5QFebnjY5Iivhcgls3o/x5br10
YTiGldJQsPx/qOU4zAvRHinFdn03POsxKHMXJ4M3i4w1ANdWIdqA1o4BuxC8pks=
=d82R
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

--===============8107834136267692257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8107834136267692257==--
