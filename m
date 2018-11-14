From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Wed, 14 Nov 2018 15:02:55 -0800
Message-ID: <20181114230255.GG2089@sirena.org.uk>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
 <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4047156577046771178=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 708D02677E8
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 00:03:02 +0100 (CET)
In-Reply-To: <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4047156577046771178==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emC2J5fP5T/4de5w"
Content-Disposition: inline


--emC2J5fP5T/4de5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 15, 2018 at 12:50:30AM +0200, Dimitris Papavasiliou wrote:

> The clocks are switched inside the hw_params callback of the
> machine driver, when the sampling rate changes from a multiple of
> 48kHz to a multiple of 44.1kHz and vice versa, usually after
> opening the device and before starting playback.  That has to be
> so, as far as I can see.

That's fairly normal, yes.  You can also do SRC in software and lock the
rate at one.

> If by idle you mean, not playing, then the device is idle during
> the switch.  If by idle you mean biased off, then it depends on
> circumstance.  For instance if playback at 44.1kHz is stopped and
> quickly restarted at 48kHz, as often happens, the device won't
> have had the chance to sit long enough to be biased off (and even
> if it has, I'm not entirely sure whether it won't be biased on
> before the hw_params callback).  The pop may still be avoided if

Usually it's only the digital that will notice clocking changes, so long
as none of the digital stuff is active you're normally fine.  It does
depend on the hardware though.

> auto-mute is used, but that's not always the case.  My proposed
> fix on the other hand consistently avoids generating the pop and
> does not rely on muting.  I'm just not sure how to best implement
> it.

I've no idea what you're proposing, sorry.

--emC2J5fP5T/4de5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvsqZ4ACgkQJNaLcl1U
h9AG/Qf/eH0+AS1w0/GgbnfYcoE51mP62ixuHVmTu5rsTU4N/JRH4ekJNygv8HrU
tIUKKtRHjdUk/hC/P+QkM+ZuOrI6JCmZQdAEGCpFE4JOcmlA/5obQxaMBTY2Azi+
5RP5I+l2J1uNjgloaQxN/UUziDnUw1Tjz8l6j2sIjvoNDhZ5SbqvwSf9z7OOiGcT
FDt8+zv2go655zp/mFhNr5t1RDYzow3FnZlXPXH6HtacwxSB4BrXklfpOeLIfgda
yiLkJ81pzjiTexEdgdWPTXCjd44ssGelRtof89M6gAfp+km6Yxiw+AuHFH/JZ2RE
rNl8J32p/D4unughJMqg79Y6/lK/fA==
=59Ay
-----END PGP SIGNATURE-----

--emC2J5fP5T/4de5w--

--===============4047156577046771178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4047156577046771178==--
