From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: WM8962: Enable start-up and normal
 bias after reset in runtime resume
Date: Fri, 14 Jun 2013 12:21:10 +0100
Message-ID: <20130614112110.GL1403@sirena.org.uk>
References: <1371199940-29803-1-git-send-email-b42378@freescale.com>
 <20130614095917.GG1403@sirena.org.uk>
 <20130614100838.GC9206@MrMyself>
 <20130614105118.GI1403@sirena.org.uk>
 <20130614110742.GD9206@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6023926785667575523=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 277D9261AA0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:21:14 +0200 (CEST)
In-Reply-To: <20130614110742.GD9206@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6023926785667575523==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uff7bI5xB/HT0T5d"
Content-Disposition: inline


--uff7bI5xB/HT0T5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2013 at 07:07:43PM +0800, Nicolin Chen wrote:
> On Fri, Jun 14, 2013 at 11:51:18AM +0100, Mark Brown wrote:

> > That said the general concept is that runtime PM would be powering on
> > the device for digital operation (eg, for the GPIOs) and then
> > set_bias_level() powering up the analogue portions of the device.

> Understood. But I just tested the set_bias_level() way to handle BIAS,
> it prompts "wm8962 0-001a: DC servo timed out" when I start to play a
> wav file. There should be still some parts of code not right.
> So I'm gonna just revise the comment to continue the resume() methods.
> It should be appropriate since pm_suspend() is handling bias-off in
> the current code.

If the DC servo is timing out that'll be a problem with the clocking...
the FLL is partially analogue so if you're using the FLL that makes
sense.  Looking at the code we're also bringing the bias down in the
suspend path so it needs to be powered up in the resume path for
symmetry if nothing else.

--uff7bI5xB/HT0T5d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuvyjAAoJELSic+t+oim9JpEP/3BCdTqWfrUchzYJYf7ytG/R
EDEh7EIjwcYj5Cpk/nkxm6rhJtcVioxzOMrrhFW/GxRm0TvvG+QnfvDbRZkEcJsb
a7GU0+Q2MF4PuLEKSaEUZVqV4lwXrIlOKIYmVT9iG1r0jfkKd8GVaLGkRtrCvpbQ
CgeIiSZKrpFdA0rLXu4EclQuphigTDiX26SEi2zamwCTUJJBP3aFCqJA2Z/6TiJm
5YC6mXI8SDqWAuRFkM1Xgh3mMD6Zkve0RC69ALjmSKRMvKQNF4p9N8PldkfWhWBS
da/bvR/Mkb4ebv2Pd0JM1lta3aCOTwIQhqdYjEgm0Od+9P2/AccUo67SrAHT/MBk
83JjAwmKCHL8vRX/zqlUD8nYdZWIJXIS078IEL+OAoyuW+63SU8bU1A69EGaAWt2
0xmmDA6QT/qI7c06viFrZUy5mKW0yleMfR3GyiaknBBGEoDhPGCeIriGIltXK0Nm
iD6Q4tq6KnZ6Q7SrjemyaRhgOEEEVTk9q9Bv10h53zV+FQtQW9ZpeLZMPJoJOdOy
htfdHMZ3pZEHGYg4NV1Xyjg31nafUb4axG/CLlGsbWQVrMG5y+fs9HIvF7c1Q5uy
16YX8hYUW4ICTz8SwD7Q3hrm8nOSlgsUyYnhTZbiWfMJ2xlYZNoqnpaYK6Di8ZCG
sbgUrjizwjfd744nM9eL
=DleM
-----END PGP SIGNATURE-----

--uff7bI5xB/HT0T5d--

--===============6023926785667575523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6023926785667575523==--
