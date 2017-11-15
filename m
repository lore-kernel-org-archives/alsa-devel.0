From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Wed, 15 Nov 2017 12:16:48 +0000
Message-ID: <20171115121648.jjbs4jdpjoyhkbqo@sirena.org.uk>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de>
 <20171115113742.27b2nvfsbtvv7gfs@sirena.org.uk>
 <s5ha7zn69e7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9068349232596700374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF22C266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 13:17:04 +0100 (CET)
In-Reply-To: <s5ha7zn69e7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============9068349232596700374==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fetwzlxa2vydupaq"
Content-Disposition: inline


--fetwzlxa2vydupaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 12:58:40PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Wed, Nov 15, 2017 at 08:34:09AM +0100, Takashi Iwai wrote:

> > Though transitioning back would probably just create more misery.
> > It's a real shame that ACPI doesn't have standards for the machine
> > descriptions here like DT does, it'd cut down on the amount of stuff
> > that needs configuring.

> True.  Although I don't think ACPI is the center of the mess in this
> case, but rather too many kconfigs is it.

It's the source of all the individual board Kconfigs - we can't just
have an equivalent of the of-graph card - and then the explosion of
board configs then pushes to have more of the other options user
selectable to let people make the list more manageable. =20

> We should begin with thinking of which entries (and layer) to be
> selectable, and which not.

I'd say either just all the individual machines like it was or all the
SoCs.  If it's the SoCs it prevents people making really tiny configs,
though I'm not sure who cares.  If it's the machines then you get a lot
of options but I don't know that this is a problem, it's not like end
users are routinely configuring their kernel.

--fetwzlxa2vydupaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloMMC8ACgkQJNaLcl1U
h9C8Wwf/ZAw1NB1AL/M6gz2GnN88aXROeeT2KyIB6s98ya1ZM2bRYQFqEvnqi9oQ
XVl47NGgZJWVb1IOM2khItbRAFjvxLQTJOqopYlRbLmT80f/l5mSOwj8kYS0i3fl
5EcdTUwA2/fXYnLMtbewzv8s1eT7I2STNh+MKF51gtbpeP/LKE7hJW11ylCB46rb
afkI0jlcxE92D293k10Am3ypaaKFpor6gjdU3ZNYPHqucfTV+xFmGipieJCXDByS
YthQsfCS7wGrlA5R8kojZGns68RjZrN7kFeQXmGdVtUZRtnD2wk42YHu7C+Qy70F
SsqfekLBSbIBWl00Ucmve4Brr+nZmg==
=PLqd
-----END PGP SIGNATURE-----

--fetwzlxa2vydupaq--

--===============9068349232596700374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9068349232596700374==--
