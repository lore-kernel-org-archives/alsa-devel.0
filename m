From: Mark Brown <broonie@kernel.org>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 17:18:49 +0100
Message-ID: <20150512161849.GD3066@sirena.org.uk>
References: <55401602.5050907@dell.com>
 <55480021.1090402@dell.com>
 <20150511182658.GA8516@isilmar-3.linta.de>
 <20150512101258.GL2761@sirena.org.uk>
 <55521BA0.3030606@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55521BA0.3030606@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 10:26:24AM -0500, Mario Limonciello wrote:
> On 05/12/2015 05:12 AM, Mark Brown wrote:
> >On Mon, May 11, 2015 at 08:26:58PM +0200, Dominik Brodowski wrote:

Please fix your mail client to word wrap within paragraphs and leave
blank lines between paragraphs.  Your current mail client is doing
neither which makes your mails hard to read.

> >Also CCing Matthew who came up with the original version of the version
> >change and Liam who is one of Intel's audio experts.

> >>According to an off-list discussion, the sound breakage (and not just some
> >>jack detection issue) seems to be caused due to alsa-lib being too old.

> >Right, it needs the userspace configuration files installing.

> Is it just configuration files?  With 4.1-rc3 I've not been able to
> get sound working mucking with any mixers.

You need PulseAudio 6.0 but otherwise yes, it works for me.

> >>The matter is further complicated by the issue that the driver
> >>asks for some firmware blob intel/IntcPP01.bin which (at least) I
> >>cannot find anywhere.

> >As previously advised that firmware is optional.

> The errors in dmesg make it seem like that was related to the firmware
> missing, but that is a red herring it sounds like.

Yes, it is.

> >Does this also affect other behaviour of the system?  I'd be pretty
> >unhappy if it introduce power regressions for example, I mostly don't use
> >audio on my laptops but I care a lot about how long it'll run
> >disconnected.  It *is* quite a new laptop and my experience installing
> >was very much that it was in bringup (though quite a bit of this was
> >userspace).

> I just tried it with 4.1-rc3 from Ubuntu's mainline PPA and an Ubuntu
> 15.04 userspace.  It does affect the behavior of the system.    See
> all the PCM errors in dmesg:

That wasn't my question.  I'm asking what else the firmware is changing
based on detecting Linux, we don't want to just move onto a different
set of bugs somewhere else.

> https://bugzilla.kernel.org/attachment.cgi?id=176511

> At least with BIOS A03 (latest), Ubuntu 15.04 (3.19ish and modern
> userspace) or with 4.0 and recent userspace the experience shouldn't
> be bringup.

I'm not seeing any of the hw_params() issues with v4.1 - are you perhaps
using an old linux-firmware?  I don't know how up to date Ubuntu is
there.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUifoAAoJECTWi3JdVIfQe8sH/2Pq4+rJAEccjYfDOyi2+7rq
sVsWeRkiWoWBnEhU6gnG0O7qTDdMPkuNbuGVySaySUctFDF85cX/qO+M/ISnaNBA
TonP3m6+ZB3AAYgeTyyNaqlzOeZaUtSB7TF9nRQzLzzH3RRzDtmQWbfnueckxWfC
kBJhL/LwPf5YBiY3m/bBYacMoF6zRHK0dwZd5s+KNIk0iPxDEcvEEZvf03+ydFSD
BKaF/QpxG4yBCwuyp4XYIAGgwDqBKMGvusRt90Sv7wpJvy3Y1oMdN3H9zEddhkvT
KBcPC89Yw4cYR0g3TTdK0Cx6ustXUlhmX/IxYKLUtCCG8jDeSvGyAPPbt8Bs0+c=
=QPz0
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
