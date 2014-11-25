From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add ACPI device probing
Date: Tue, 25 Nov 2014 18:43:04 +0000
Message-ID: <20141125184304.GK7712@sirena.org.uk>
References: <1416034608-24238-1-git-send-email-benzh@chromium.org>
 <CACxGe6stjCvaQZkh=hFcF-56v5qJVar11jRZz0PRSd2wz6EUyA@mail.gmail.com>
 <5474A78C.7030805@linux.intel.com>
 <20141125172120.GI7712@sirena.org.uk>
 <5474CB5D.9050807@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3244532524507127655=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73B1F2658E7
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 19:45:05 +0100 (CET)
In-Reply-To: <5474CB5D.9050807@linux.intel.com>
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


--===============3244532524507127655==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hPB2oXVi+7W5/ekT"
Content-Disposition: inline


--hPB2oXVi+7W5/ekT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 10:33:01AM -0800, Darren Hart wrote:
> On 11/25/14 09:21, Mark Brown wrote:

> > Given the design of _DSD is to share with DT and we already have
> > device tree bindings for the device we should be using, it's not
> > clear to me if we want to grind them all through UEFI and I suspect
> > they'd be unhappy if we tried but pretty much all audio CODECs are
> > good candidates for use with ACPI given the new hardware designs
> > Intel have so if we are doing it I ought to be bouncing everyone to
> > UEFI forum.

> Right, I realized between sending and driving into the office that my
> statement might be construed this way. I meant *new* _DSD bindings
> should go through the ACPI/UEFI forum. Where we can reuse DT bindings,
> we should absolutely do that, agreed. We should still document this
> and link to the DT binding so it can be referenced and used even when
> Linux is not the target OS.

Link from where - do we want to talk to the ACPI/UEFI forum and figure
out some kind of fast track process for them to add an "it's already
covered by DT, see here" entry to their database for example?  We also
ought to work out how to make sure ACPI IDs are registered there as
well, should be possible to have something simple as part of that.

--hPB2oXVi+7W5/ekT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdM24AAoJECTWi3JdVIfQofkIAIBmyrM6SNYQEAXnfEaL+6Kt
eba2lkJ1R8AvG1bw0KBRCLZwyJNQyKg7rK2jbw/ik6k6dtnb3T61lXlWxfPpNj4e
B7X4T0u/TjE8eiThRRZFjcALs9iobvGcaKX8vsGJ4cwLTlbd9o/1qDKFEbcYHBFm
lXOfo7bdYDrG+DmyyvB/SVZKfjbbBfXWxWKYoGtRA9f8ClxsNIhHKvh/Jbr3GboD
jnW6NQ6YvaaimKxp7Zaas2yae/Kitp5U5kp56yd7K2wVGRUyEeeijvb6MgGIiiEJ
hPP6nI85vC6nW6Pb43wiX3DTE9nPjxKHZagx7I3bl1NkoH+959+Rh6Ag4nJ9Q/w=
=wygB
-----END PGP SIGNATURE-----

--hPB2oXVi+7W5/ekT--

--===============3244532524507127655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3244532524507127655==--
