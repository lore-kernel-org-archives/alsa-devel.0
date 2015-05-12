From: Mark Brown <broonie@kernel.org>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 11:12:58 +0100
Message-ID: <20150512101258.GL2761@sirena.org.uk>
References: <55401602.5050907@dell.com>
 <55480021.1090402@dell.com>
 <20150511182658.GA8516@isilmar-3.linta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hdW7zL/qDS6RXdAL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150511182658.GA8516@isilmar-3.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>, robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, han.lu@intel.com, yang.jie@intel.com, alsa-devel@alsa-project.org, Matthew Garrett <mjg59@coreos.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--hdW7zL/qDS6RXdAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 08:26:58PM +0200, Dominik Brodowski wrote:

Also CCing Matthew who came up with the original version of the version
change and Liam who is one of Intel's audio experts.

> According to an off-list discussion, the sound breakage (and not just some
> jack detection issue) seems to be caused due to alsa-lib being too old.

Right, it needs the userspace configuration files installing.

> The matter is further complicated by the issue that the driver
> asks for some firmware blob intel/IntcPP01.bin which (at least) I
> cannot find anywhere.

As previously advised that firmware is optional.

> Under the no-regression rule, this means that either b1ef29725865 needs
> to be reverted or we need to find another solution to this matter, such as
> an override. And I think it is needed for longer than just for 4.1, as it
> will continue to be cause regressions on quite recent userspace.

Does this also affect other behaviour of the system?  I'd be pretty
unhappy if it introduce power regressions for example, I mostly don't use
audio on my laptops but I care a lot about how long it'll run
disconnected.  It *is* quite a new laptop and my experience installing
was very much that it was in bringup (though quite a bit of this was
userspace).

--hdW7zL/qDS6RXdAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUdIlAAoJECTWi3JdVIfQWx0H/3V3SGtx3hvUfFroJX5tKQqB
p2dGnPmEztMwTnf9ZDgp+x+3cg+wvdOqHzpVSe62EbSxkF2RmpWvNpuC5US1oZuv
3I/B3IGpb/+56uhCkkLSa+/apweU/+nXG3vZUA+YOtjwVEtPJrvjVCrIWqR9o7TR
NFU6JTkWd0iGt/df5ee0fWee7odALiZuxl6533e47OVfyxGp7uS0nk1L5gBWiGMO
OXAZnD4NdbBGoZrmhO3U2nC6XZC8bu8SUQvVxnmnZQHePtyDVANwmAE8TUAqxasv
raLPpPvvarsZ1UrvPB9LFkopPl6tOCi025ok9lLHuOGSqhKDdXiLAVTFbYHj1e4=
=u50f
-----END PGP SIGNATURE-----

--hdW7zL/qDS6RXdAL--
