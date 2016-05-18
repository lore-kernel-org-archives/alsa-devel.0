From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: core: Do not print an actual
 error when deferring probe
Date: Wed, 18 May 2016 18:20:19 +0100
Message-ID: <20160518172019.GS8104@sirena.org.uk>
References: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
 <209086304.1BTKYSBN0B@ws-stein>
 <20160518152820.GN8104@sirena.org.uk> <1574831.WL8kGhHEjA@ws-stein>
 <20160518162154.GP8104@sirena.org.uk>
 <s5hvb2bz4kx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3176899186829313960=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 852EF261497
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 19:20:30 +0200 (CEST)
In-Reply-To: <s5hvb2bz4kx.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org


--===============3176899186829313960==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9wW3yB/H9ZmnRBtb"
Content-Disposition: inline


--9wW3yB/H9ZmnRBtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 18, 2016 at 06:57:50PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It's just shifting the problem around...  it sounds like for your use
> > case suppressing the messages until we finish kernel boot would deal
> > with most of the issue in a far more general fashion.

> It comes to the question whether this message must be shown verbosely
> as an error at all.  EPROBE_DEFER is usually a mechanism for the
> delayed probe, and it doesn't indicate an error per se.  dev_err() is,
> OTOH, for real errors that have to be notified to user inevitably.
> That's why "quiet" boot option still shows it.

We can't tell the difference between something that's delayed and will
come up later and something that's just never going to work - missing
or misidentified components has always been a common source of errors
in ASoC device bringup.  There's also just the fact that the noise from
deferred probe is not an ASoC specific thing, we need to tackle this at
a system level rather than hacking individual cases.

--9wW3yB/H9ZmnRBtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPKRSAAoJECTWi3JdVIfQCFsIAIRCvMQfXxSFxdltC5SZMRBM
6O4nlnKOia0qRQMKvO9u3TjhWMwHh8l+jxcbZE15jN9XUeqQoNjoYwGgjVbTYQjj
1yn43H3qBosweDe/gwL8bdwfobEAcNRNm+Llor6YuZq1f8jHzNisnvhGXn6kTuey
wO6L08vWJDEn7lqdVM2UsOE0EZJCVMJxUPGIx7C8E/rHuZVJD6XxrCC2wQ5u4epR
qug98ozKTBYXCp0+1AivpE0jIEdhU9eDVD9VvmeYhe7X9w3GAvECzphpG9Kj8xBF
zT3M1ancV0SdhPIM1X3QBqFbRK93zHnKsbktHVlN+Jb6fM30vZTI3u6VoXvfMBU=
=bp6X
-----END PGP SIGNATURE-----

--9wW3yB/H9ZmnRBtb--

--===============3176899186829313960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3176899186829313960==--
