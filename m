From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Tue, 18 Mar 2014 18:07:32 +0000
Message-ID: <20140318180732.GJ11706@sirena.org.uk>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
 <1395148837-20850-2-git-send-email-peter.ujfalusi@ti.com>
 <532848D5.30806@ti.com> <53285827.1070709@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5525249502208288205=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 711DC2615FC
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 19:07:44 +0100 (CET)
In-Reply-To: <53285827.1070709@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5525249502208288205==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xf1frN3LpSrbXX2S"
Content-Disposition: inline


--xf1frN3LpSrbXX2S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 04:28:55PM +0200, Peter Ujfalusi wrote:
> On 03/18/2014 03:23 PM, Peter Ujfalusi wrote:

> > Oh, I edited the commit message and removed the text related to buffer size
> > but I failed to do that for the commit title :(

> Actually I still have issue with the constraint.

OK, so is the patch an improvement or not?  If it fixes some cases it's
probably worth applying even if further fixes are still needed.  No need
to resend for the subject, I can fix that up.

> It seams that I need to place the same constraint step to both period size and
> buffer size.
> For some reason snd_pcm_hw_params_set_buffer_time_near() fails in case of
> 44.1KHz when asking for 0.5s buffer when I placed step 32 constraint to period
> size. Placing the same 32 steps constraint to the buffer size as well will
> make things working (for mplayer at least)

That seems like the constraint code is failing, at a guess probably
looking for too near a value of near if you see what I mean.  I don't
really have the time/enthusiasm to investigate this right now, sorry.

--xf1frN3LpSrbXX2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKIthAAoJELSic+t+oim9IXUQAJnQbQp8uKrE2NtKK7U0Z6+t
vPmHPsXJ+75xrEodqwPrx6XQdV390Za/Tx6YySwl6Xqb1mIgLdeui9l4KmnAsXkh
vss74uJaike1zYMHBruQXZmop8S4IqEkOdZ44NcfCM9iBIQjdNWfhwhe6OYJ3IbU
+7Oo3VLP8FCoo30TcHjHGJbFsXheCpEl8lD9o0495NHu5i8XUUT7PeG6lbLCFryB
JL57Nd2itSCzCxd4r2oJL7MT5wzWiHvPsm6qFDy5eRAwYVPeU01u9EdnAlGkREVP
5GBMCR3czDJfnoM/JaHapkyq0hQd5VbFwn474C4b+4ggtSU/zpY8Apiq0IpJZ7pF
6fjtt/CqMgjqWTR+mXGubFTEdgsEEt27UxGiwD4zbz82qmoePgOX2wwluFYxk6Vg
Ofhp9ztHTnyFVjKUb16wiLUtio/HmPbaL1tpjZ1JNgkFUz7D40chQ1GuEuf8oqdp
70cUpq+e1QF1zLHpVBp8kPsfxutjQv3ze2qOFuAlhgfCjUqUXVdkbnk+NzSa3Nvc
5yXwE/72FyHd3wyb1mYGAq7GAMpDSylUtmEsw771Nm936r++DCPGFEJAbssavp++
DHi3c4n/JtnMoUCdvDq5fyk6lRtDcxWqXSOVnA8+ygzvewuEabhgjZ9HxqsFEIPI
9XfzGLqmQv8DxugbimAP
=2HVD
-----END PGP SIGNATURE-----

--xf1frN3LpSrbXX2S--

--===============5525249502208288205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5525249502208288205==--
