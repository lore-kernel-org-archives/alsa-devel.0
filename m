From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: sti: reset iec60958 settings on
	close
Date: Sat, 21 Nov 2015 12:45:09 +0000
Message-ID: <20151121124509.GC26072@sirena.org.uk>
References: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
 <1447941250-344-5-git-send-email-moise.gergaud@st.com>
 <20151119175024.GP31303@sirena.org.uk> <564EE3A4.3090501@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2834349162980220501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CEB42606FE
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 13:49:48 +0100 (CET)
In-Reply-To: <564EE3A4.3090501@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2834349162980220501==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2015 at 10:11:00AM +0100, Moise Gergaud wrote:
> Hello,

Please don't top post, reply in line deleting unneeded text.  This
provides relevant context so people reading your mail can understand
what you are talking about.

> To be compliant with SPDIF & HDMI-1.4 by using aplay, driver needs to set
> the channel status sampling freq = runtime rate; because channel status
> sampling freq is not set by aplay.
> For HBRA, the application set the channel status sampling freq (that is
> different than the runtime rate).
> => by taking into account the 2 above cases, for each pcm session, driver
> shall be able to detect if the channel status sampling freq has already been
> set and set it if needed.

> And also for robustness purpose: in case the channel status sampling freq is
> not set by the application, I think the driver shall set it.

None of this addresses my concern, sorry - your change is just trashing
all the settings that the application is setting.  This is not what we
normally do with controls and is going to break correctly functioning
applications that play audio with the same parameters repeatedly.

> Maybe I can limit my patch by resetting only the channel status sampling
> freq on close (actual patch reset all the fields of the channel status).

This isn't something you should be inventing policies for in a single
driver, the kernel needs to offer consistent interfaces to applications
no matter which particular hardware the system is running.  If we want
to do something here it should be done at ALSA level.  It does seem like
a reasonable idea to put the sample rate into kernel control, I can't
think of a situation where we'd want to advertise the wrong sample rate,
but it does need to be in the core not a specific driver.

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUGdVAAoJECTWi3JdVIfQaakH/jtX3lu0GjxN5mCdxDx4kPtA
PTTqqbDo2TJe87dSroEe1GWobKMcOQiyIP4qyuRoBskNUrQe/n60XhL2Ie2x1/iJ
Vt4QMfEa8jEgebC5s33jMs5EPq5bIUxuRgiQcZ3NN4TK9XCojHFpHTDvRAymgd4U
7VC+lO1vc/1b4nF4DG5ERxKne2Z0xTwGinJjErxTE+VMSWJdre8f2p1N2DiGWuOZ
nF4gLUhGAJu81GiVmrOGXM0f2eFKLIyAw6NCVi5xN0bdxvPgGTIwugQika3uk7gi
yfKzO8AEZN+QwL9ALHrAkD1PKcdWGc+R293pl65lS//kW8ea5+CEZXUuQMyWUss=
=t0cE
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--

--===============2834349162980220501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2834349162980220501==--
