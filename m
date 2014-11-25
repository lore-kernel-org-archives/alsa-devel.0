From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add ACPI device probing
Date: Tue, 25 Nov 2014 17:21:20 +0000
Message-ID: <20141125172120.GI7712@sirena.org.uk>
References: <1416034608-24238-1-git-send-email-benzh@chromium.org>
 <CACxGe6stjCvaQZkh=hFcF-56v5qJVar11jRZz0PRSd2wz6EUyA@mail.gmail.com>
 <5474A78C.7030805@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5543493312788098482=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 31B1D2605D9
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 18:23:37 +0100 (CET)
In-Reply-To: <5474A78C.7030805@linux.intel.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5543493312788098482==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24l/woCQRgYlHbSG"
Content-Disposition: inline


--24l/woCQRgYlHbSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 08:00:12AM -0800, Darren Hart wrote:
> On 11/25/14 04:11, Grant Likely wrote:

> > Also, since this patch is targeted at v3.19 or later, the
> > device-properties API should be used. Don't create something custom.

> Right. The ACPI/UEFI forum is managing the creation of new DSD bindings
> and ensuring they are documented online. I believe this is the... 3rd so
> far? So we're still optimizing the process. But yes, please, send the
> schema itself for review and let's get this documented and migrated over
> to _DSD.

To be clear the main reason I'm querying this is that it doesn't appear
to be a _DSD based binding at all (as far as I understand it, the API
it's using is from before the dawn of time or at least the dawn of git).

Given the design of _DSD is to share with DT and we already have device
tree bindings for the device we should be using, it's not clear to me if
we want to grind them all through UEFI and I suspect they'd be unhappy
if we tried but pretty much all audio CODECs are good candidates for use
with ACPI given the new hardware designs Intel have so if we are doing
it I ought to be bouncing everyone to UEFI forum.

--24l/woCQRgYlHbSG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdLqPAAoJECTWi3JdVIfQj+QIAIbjpZ0x+N2081Nc1/fgC2jk
4ASAqxL27XRLakZxTdSXnYMytTXES+L3TNkJalCpt/VCyer3CElcXjAcSBjJYbNi
ZrkeiHB6W1fwRN80KvSJ95ctSjIbJP4dkqvCr13JdijLxF0h9aXcysa7Q5bPoUSP
x50XkwaMFsm1jP9bHEzPA4NROh85aRPb9cucMjX3KnvMR93hvtKaEz2yANLvPtHF
81RhiQwvJvpwc8nmwXK115hL6Rbd+HzrKvfpAzz6EMNiYGM9A3q/BVQxb+MpludV
w3pGwCFmEMRtZdkCNTKk0odPi4YaWWiOxqWCpYu2Ak2cPbtwgEmyOXH8EFU67Ug=
=ENqK
-----END PGP SIGNATURE-----

--24l/woCQRgYlHbSG--

--===============5543493312788098482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5543493312788098482==--
