From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [pulseaudio-discuss] Using UCM with PulseAudio
Date: Mon, 23 Jul 2012 08:57:44 +0100
Message-ID: <20120723075744.GA9269@opensource.wolfsonmicro.com>
References: <1339728813.5228.48.camel@localhost>
 <1339762287.3007.127.camel@laptop>
 <1343014720.6131.21.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1044745921215286053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C67D265214
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 10:06:24 +0200 (CEST)
In-Reply-To: <1343014720.6131.21.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: Tanu Kaskinen <tanuk@iki.fi>, alsa-devel@alsa-project.org, jankovac503@gmail.com, pulseaudio-discuss@lists.freedesktop.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1044745921215286053==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 09:08:40AM +0530, Arun Raghavan wrote:

Guys, please delete unneeded context from messages - makes it much
easier to find the new content.

> 3. Devices that have a loopback path in hardware/DSP (this is a request
> I've seen, but I'm not aware of hardware that does this)

Essentially all basebands in cellphones are connected like this; usually
on a phone call the processor running Linux can go into suspend.  There
are cases where the loopback happens in the main SoC but from the point
of view of thinking about it the physical location doesn't usually make
a big difference.

Most mobile CODECs also have the ability to route their inputs to their
outputs without involving the processor for use in sidetone paths and
similar.  PCs always used to have the ability to do this too, though I
guess it's possible that got dropped at some point.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDQPxAAoJEBus8iNuMP3dwq0P/0KqeV4zHejeZBs/DGRn2RWh
kBLJMGCYpTKKytmEV27ji0dSI2uEDo0aTO5xTlbCXroMUHIIxQ1aFNXiwF96HfnY
aA6NsmAl0577gOZ8bXmGFdY4C15pbPHLMRAZhmIxZLphKQBnDNNyFsejZnrJRmz5
/pnnJ3OKjyguT8cgjem9AGP30CAZMeEuEsR6Mwhwj4Ct8P1rpTWbKeH6skOASxHE
cZDg87xWH1huTE0RAhzhf1FfzQnlptevs5hAbG3K7Afn3M4URdkjtSqJjGf0XsAc
E1DkiRurRdGMneDV+JBB/+gsLlH2ykkB0oX1FDyPDaeeZa0lr+1nC21UvnV8mAG3
BydbKwpOynajnCf/zDsMgYJm7dhdSNP7ni5ZDEas3ncs0o8R2KRwQ3IpITJaxD8Z
WI4bkPXaXs4GQfCEjWBUIy3zPXQZmT9cTKFBMoFhhjP/MyvhEtZSJ2/Bg4ebFGbi
zjzmS2lWI0dpTPM/BB/1Q+CsEsG1cuaxoWIepr//KBEjNnKtMmZum0cNDEy+liKx
zEAqe/RvTBOrqGm2WoOveGVTa2SeCIMKBrLyO7GmN/HZzEiOVmf0asu3KkyLTIVn
uDhJB+BbtioQaszwJ3Olpfp/6pI4D0pFGHvpISByThNbLhE3u0wuLZemSaQ4butJ
WnHFueeH92EIPZ1QfglI
=tQP2
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

--===============1044745921215286053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1044745921215286053==--
