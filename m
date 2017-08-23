From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Wed, 23 Aug 2017 18:54:52 -0400
Message-ID: <20170823225452.GX17193@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <20170823092828.7ijy7rthvqkzcgtz@sirena.org.uk>
 <20170823223524.GW17193@bill-the-cat>
 <20170823224752.p3ebgenlnstkd5jg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6083099904115005137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
 [209.85.161.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E25E266A7C
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 00:54:43 +0200 (CEST)
Received: by mail-yw0-f177.google.com with SMTP id y64so9094451ywf.3
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 15:54:43 -0700 (PDT)
In-Reply-To: <20170823224752.p3ebgenlnstkd5jg@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============6083099904115005137==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PpfQBwiAIZcuDX26"
Content-Disposition: inline


--PpfQBwiAIZcuDX26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 11:47:52PM +0100, Mark Brown wrote:
> On Wed, Aug 23, 2017 at 06:35:24PM -0400, Tom Rini wrote:
>=20
> > After looking at 89128534f925 (which introduced the above line, and thus
>=20
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Sorry, let me re-phrase.  The commit:
commit 89128534f925711eea1653c264683b7d14a46530
Author: John Keeping <john@metanate.com>
Date:   Wed Aug 24 22:06:35 2016 +0100

    ASoC: rt5677: Add ACPI support

    The Chromebook Pixel 2015 uses this codec with the ACPI ID RT5677CE, but
    does not use the standard DT property names so add a new function to
    parse the codec properties from these ACPI properties.

    Also, the GPIOs are only available by index, so we need to register a
    mapping to allow machine drivers to access the GPIOs by name.

Adds all of the code which "ASoC: rt5677: Move platform code to board file"
and "ASoC: rt5677: Introduce proper table for ACPI enumeration" move
around and re-work.

> > support for the Chromebook), I think that 36afb0ab648 and 55e59aa0525a
> > are wrong and should be reverted.  It seems like they're an attempt to
> > make 89128534f925 be done 'properly' but it also seems like the
>=20
> Please be more specific.  The only obvious issue with the original patch
> "ASoC: rt5677: Add ACPI support" is that it adds an I2C ID instead of an
> ACPI ID.  I don't have 36afb0ab648 so I've no idea what it is and
> 55e59aa0525a is "ASoC: rt5677: Move platform code to board file" which
> is a code motion patch and looks more like stylistic faff around the
> shambles that is ACPI than anything else.

Ugh, typo on my part proving your point :)  I meant _a_36afb... which is
"ASoC: rt5677: Introduce proper table for ACPI enumeration".  My gut
feeling (and I'd be happy to be told how to poke ACPI to confirm this..)
is that the ACPI table is in fact not including some information that
the code expects and that's why the original patch added an I2C ID not
an ACPI ID.

--=20
Tom

--PpfQBwiAIZcuDX26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZnge8AAoJEIf59jXTHXZSVUsQAJlsCqaBczR8rrDxDu8LyOMd
gPPznGiqj4NVB/1eI9TqFu2B+Z9x5seRoXMNSKV4ZGg4x2BPm6fMTbqutwY6tf8Q
SeL+Z16/Zh2rqS/vbJ55DVuuMCko+BDZPE4pUKeO4RE0Qcqw/jGP/ZV8e7WBq91B
OKDDHxQzVZzhHo1h0NqcXZ/uOLFbp0UmhYdh+7TQo+kApFmxzJKR+ldU060I5M/e
xg0rIeetG9tGJgivY1Q7fF1E27+M+LRcnQxzlnrN3tew5RbQ93H60zNZJEFXa0df
jhnUeGhefNJI7xsA8EcGGBruviUDWbiqs5gLKpWsicWr+zDOTP4ga/Fle7zF6NOS
RiLGN4+rzObjUeTym9O1UfHYWT2wshf/2HmJesU2QsdqN7iz3ns4NR6OzNr0N63m
bFaA9ecYafV2wIukYID6IyqYSeYX7lqqR0j/CHoeg4gFsauUJhm/aBW1g8Sg/hYq
rCrgbjUVqxCWMuiV+e7hDFbAlnEgioM6u1dls8kZvz+aTEQvURWj2OZp5e2qLqVF
j5OWLQmYguuasdeDRRhL8I1Ac39QC5pE+nZbWSAOUmhyBxIKe+AxiUQ2KM7yWysF
Yt0wQfCrGTNY0wcXp28dSNV/rg6Nn5jMv7vMtGjV+QtAXY+5NxyPy2tcMdx76cBr
drPXLAYBGBfosOs74IbJ
=XFfH
-----END PGP SIGNATURE-----

--PpfQBwiAIZcuDX26--

--===============6083099904115005137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6083099904115005137==--
