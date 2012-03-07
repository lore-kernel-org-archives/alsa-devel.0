From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 15:39:44 +0000
Message-ID: <20120307153944.GO3107@opensource.wolfsonmicro.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
	<CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7918390490907935130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 672EF244E0
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 16:39:47 +0100 (CET)
In-Reply-To: <CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin PAI <nitinmpai@gmail.com>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7918390490907935130==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CKf/2jVYos1l2hij"
Content-Disposition: inline


--CKf/2jVYos1l2hij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 08:48:09PM +0530, Nitin PAI wrote:

> >>Even with automotive there's *some* power limits and obviously the power
> >>control also includes things like syncing startup of the algorithms with
> >>the data path

> I dont think that needs to be absolutely done as a part of kernel layer.

In general it really does - things get sensitive about their clocks and
algorithms get sensitive about their inputs.  You can often get
something together that isn't joined together but usually there's a
stack of simplifying assumptions in there which can break easily enough.
Besides, you still need something there which exposes whatever physical
interfaces userspace needs to use to program things.  If userspace can
just randomly interact with hardware that's a bit of a failure.

> >>Well, yes.  Unless someone writes a card driver the CPU driver won't do
> >>anything useful but then without the card driver you've no idea how the
> >>system is actually wired up and the chances of it doing anything useful
> >>are close to zero.  There's no getting out of the machine driver.

> This is the point. Why write a card driver? For example audio over MOST or
> for HDMI audio?

If the same driver works on all systems then you can just write the
driver and it'll work for everyone.  Nothing at the CODEC level is going
to make this more or less easy, you're actually saying you've got some
hardware for which you can write a generic machine driver.  If that's
the case you should just do that, there's some examples of this already
like the fsi-hdmi driver.

> Or when I have some utility in userspace to test the functionality.
> Wont it be better to atleast enumerate the driver and show the capabilities
> it supports?

You can add debugfs information to dump the capabilities and whatnot if
that's useful to you...

> This can help in many phases of design like emulation, bringup (doing
> loopback between 2 interfaces at SOC level)?

If you're doing stuff like this you're probably more than capable of
tweaking things to suit your needs, and probably be prepared to accept a
level of brokenness while you're at it.  For example, if you've not got
clocks then you won't transfer data and userspace tends to get upset
with you.  You'd still need to do things like set up the clocking even
for the SoC loopback case, everything is going to need to agree on where
the clocks come from and how they flow.

> Cant we have support for all this, if not codec, somewhere else?

Honestly it just sounds like you want to write some machine drivers for
your systems.

--CKf/2jVYos1l2hij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV4E5AAoJEBus8iNuMP3dnZsQAIIrTVoJjOqBgj4WRv09PjUE
TZVMzFWqGIbosGfywkeIQWX+SIjuhhl0txk+n2JgZJvOHqEQHXjEmgXTN2YEl9ej
J6d3aiU+B0bA0BsFWpdCo0Ut/C1JUkCz+P4PaizUUAiX2iCGSmNfbv3aqYgsHEyC
WB5+LyDMHospDj4FDClXYBmj5rcvo4pxpV5L8OgUOCFyCaqye9lfWX8y83DCXWi9
9Pozsu//ehAu1qyW+Rk90Lz9KbtXi4m+74/40KVvl+Fk1WsDoY5B8/5qKNjoMf7g
+M6DwW9ntPyDMie14FJ0gec+KAlFCKdbWSPHnl6jpUiSEqdcGiwyZlcc3VqI3xXO
mzt9uWiCcMFM6JXY/6LV980qEGSnDMXegVqhKkgNYho9ErqSsyoTpL3dyFMkBL7W
zdbp7mUfXTodD2V7qDITtmJZebQ7Dn8kOax1gkXhQnMNI+/5wnnmhJwMvmPbfvNQ
Fi45BvkYZ1QR4h7y467Pc344MmARRaRpGBEDX4y4iPsYk9qeXtq545fIUpO8xrzv
tHYEKbEdlB3dM87+3KxZBAea3LWHgHID9vKJ8jQ0VF0SPtiquCYThvEMqUwXyywB
bTfO9YO3k1X3lp6E+xWCpzHRHhaygJC6xTlEWji2PtNirvqRBvYF+FsF1exRySXs
gSstQ3hZ+tT/5cpk1pTR
=efBk
-----END PGP SIGNATURE-----

--CKf/2jVYos1l2hij--

--===============7918390490907935130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7918390490907935130==--
