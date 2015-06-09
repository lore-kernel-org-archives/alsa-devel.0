From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: split params refinement to
	seperated file
Date: Tue, 9 Jun 2015 18:57:11 +0100
Message-ID: <20150609175711.GR14071@sirena.org.uk>
References: <1433429265-22054-1-git-send-email-yang.jie@intel.com>
 <20150604191548.GR14071@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90553DD1E@SHSMSX101.ccr.corp.intel.com>
 <s5hd216k12q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8326806958761919202=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45AA72608C7
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 19:57:21 +0200 (CEST)
In-Reply-To: <s5hd216k12q.wl-tiwai@suse.de>
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
Cc: "Zhang, Vivian" <vivian.zhang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8326806958761919202==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BPcyypecfXvUwPRK"
Content-Disposition: inline


--BPcyypecfXvUwPRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2015 at 11:21:17AM +0200, Takashi Iwai wrote:

> Just begin with adding ifdefs instead of reshuffling the code.  This
> will make easier to understand what you're going to change.  At least,
> it's good enough for RFC.  After that, we can refactor the code.

Plus if the patches get applied it at least makes it easier for people
who do decide to do such major surgery.

> Removing the hw constraints refinement is rather a radical change.
> It's a part of the PCM core functionality, and removing it means that
> the driver has no ways to refuse the incompatible parameters even if
> it knows it's broken.  So, IMO, this is the very last resort.  We can
> start from ripping off lower hanging fruits.

Indeed, part of the reason I was asking about the split was to help me
figure out what takes the place of constraints - sounds like nothing?  I
wonder if we could have cards support this by providing fixed
configurations that we could check against using less code or something.
But like you say, we *must* have some other room for improvement.

--BPcyypecfXvUwPRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdyj2AAoJECTWi3JdVIfQKmwH/0nxCzQmt8A1IrECRc0Cg5co
wCSQK0h9tcEoapjm4LfOTTmcyk5K2k40wHR+yhF6KQGwc0CJ9cEDHB5Jdrjf0qvI
souOstRX/A9RZbZiwUiNWrIjRSd87MM8juWWgjqz9Cmc7vi48huAIjOCmkkVUGyv
aSlsKgceGMSVS+AUlFKULisksbl6qzAOR8s9EmqZmEaIsTyDc99cFU4YeZccSP0i
5GYCoxMoO68wgp89h8eG+yzu/TS6aaeuLyHIhRS4FNJflXiWQ4w6TQ507r960FsB
zuOiYcbgKJTWzbez8KXGZ/HMtZepJmslRn7YMN1C3ha7HqelztT4ocq2kHueHbw=
=LFZu
-----END PGP SIGNATURE-----

--BPcyypecfXvUwPRK--

--===============8326806958761919202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8326806958761919202==--
