From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: Switch to use unified
 device property API
Date: Tue, 23 Jun 2015 10:46:48 +0100
Message-ID: <20150623094648.GX14071@sirena.org.uk>
References: <1434996780-34535-1-git-send-email-benzh@chromium.org>
 <1434996780-34535-2-git-send-email-benzh@chromium.org>
 <558889CE.7010104@linux.intel.com>
 <20150622225031.GW14071@sirena.org.uk>
 <D1ADF0B6.D4C8F%dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5425201131810569008=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EFA7D2654CC
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 11:46:55 +0200 (CEST)
In-Reply-To: <D1ADF0B6.D4C8F%dvhart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Grant Likely <grant.likely@linaro.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============5425201131810569008==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Td065rRKAY1Vpy0"
Content-Disposition: inline


--+Td065rRKAY1Vpy0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2015 at 05:05:37PM -0700, Darren Hart wrote:
> On 6/22/15, 3:50 PM, "Mark Brown" <broonie@kernel.org> wrote:

> >Have the Intel audio people been speaking to the UEFI forum about using
> >the new registration process for these properties?  More from interest
> >than anything else.

> Yes (although "audio people" is a rather broad term at Intel :-)

It is, as is ACPI people, and these are among the issues here.  Is this
stuff going to get used as a trial run of the new process?  It'd be good
to know if we should be pushing people towards it.

--+Td065rRKAY1Vpy0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJViSsIAAoJECTWi3JdVIfQFHsH/2vDj7oxxLreAezdD00Bip/F
ctBw7qtCYUqn2n2Ag63TEay5lTdloqwHXJZDxTzXCVC2Q8j7e0xX0mG7zDSDd673
9H69JtlIbrM6LYMWCk81Rh11QCDhhefHaSvlnV3+Niw6aoT1AywqPf22v0ICjWkJ
WvjYrP5bJBN8XmGMBcRhyeL9SQuSC6nnK3tTQSO2jQKtctjAbAZTGCtxyr4PT9y5
UjnSDozZ2q6M2PRqXHb3oMrTOIdwQzCXr09Ru1Qj8ylTgusUKQ4vCn1lalCb2J0V
YXi3bGXxI5CBhndZADKgBC8DeKgN5GChVBMNRZ/yZoqQZ0Rx315/delCrj4qM9k=
=qEJ4
-----END PGP SIGNATURE-----

--+Td065rRKAY1Vpy0--

--===============5425201131810569008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5425201131810569008==--
