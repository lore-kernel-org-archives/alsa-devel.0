From: Mark Brown <broonie@kernel.org>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
	Dublin
Date: Tue, 14 Jul 2015 17:17:11 +0100
Message-ID: <20150714161711.GB11162@sirena.org.uk>
References: <20150714150352.GW11162@sirena.org.uk> <55A5330E.7000604@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6413935521520916918=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F76B26510A
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 18:17:21 +0200 (CEST)
In-Reply-To: <55A5330E.7000604@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6413935521520916918==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AnoCzHCzU/Mgm7Oo"
Content-Disposition: inline


--AnoCzHCzU/Mgm7Oo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 09:04:30PM +0500, Alexander E. Patrakov wrote:

> I would like to see some direct measurements related to recent power-saving
> proposals, including the "disable rewinds" flag. Myself, I can redo
> battery-life measurements on Intel-based laptops that my colleagues have,
> and maybe compare dmix, PulseAudio and CRAS in terms of power consumption.

The numbers I seem to remember seeing at the time were these IIRC:

   http://linux-tipps.blogspot.co.uk/2011/04/power-performance-of-pulseaudio-alsa.html

saying there was a 0.4W win (I think Arun had some similar numbers).

> Ideally, I would like to reevaluate the design decisions (namely, the need
> to keep the system responsive to new streams while keeping the average
> wakeup rate as low as possible, IMHO even to the point of "absurdly low")
> that led to the need to support rewinds (and the associated complexity) in
> the first place. Reminder: on my Sony VAIO VPC-Z23A4R laptop and hw:0
> device, in an unrealistic test with the screen turned off, wi-fi turned off,
> and the SSDs put to sleep, going from 200 to 1 wakeup per second saved only
> 935 seconds of battery life out of 25742.

I'm not sure how many embedded people would be willing to provide
numbers but it definitely makes a substantial difference there if you
can keep the CPUs powered down.

--AnoCzHCzU/Mgm7Oo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpTYGAAoJECTWi3JdVIfQG9sH/1PdugyTSfu9Odn6thlZhzXV
bI1dkIbXKe9nmwrHkMQfPbyyQ8V1b2dZMhdhX8nhPfzYPL2kfuQOJcOrPUhGvTkv
Q1kCa3pXCTfqYIxOKFOoJCvXPGhbYqywFEhY2eQxpWzRt0nSd69zJO9s2zeQVsW2
ihvukl/f+HgYhhf9Ttu8qzvqtd6ZA/sOa8bm5SQrMP1i+bbM9yMZN2ZxQLDcAWbA
g4p0/Y4KG5q0amfL6R/v4CrwAFcIZ3wjGBvCR0tQNkj45YXFy9LSVizlDeG0lFBm
O1bQfOHrS+2+eupg9ucOvZ/NtI+hAbYuximrcaxO/KS7fsdlCCVZH7FhDzDrJLw=
=iXKl
-----END PGP SIGNATURE-----

--AnoCzHCzU/Mgm7Oo--

--===============6413935521520916918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6413935521520916918==--
