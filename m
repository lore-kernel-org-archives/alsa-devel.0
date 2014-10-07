From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: rt5670: Add dsp support
Date: Tue, 7 Oct 2014 13:10:18 +0100
Message-ID: <20141007121018.GZ4609@sirena.org.uk>
References: <1411957901-12156-1-git-send-email-bardliao@realtek.com>
 <20141003163224.GC3594@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7656642@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3679034204634652518=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F36260452
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 14:10:43 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7656642@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3679034204634652518==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O2g7+miYGsIKoR9l"
Content-Disposition: inline


--O2g7+miYGsIKoR9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 06, 2014 at 02:18:47AM +0000, Bard Liao wrote:

> > > +/* DSP Mode */
> > > +static const char * const rt5670_dsp_mode[] = {
> > > +	"Mode 1", "Mode 2", "Mode 3", "Mode 4", "Mode 5"
> > > +};

> > What exactly are these modes?

> These are DSP working modes, such as noise suppression, echo cancellation...
> The reason we won't have a specific name on alsa control is that the driver
> will be more flexible and we can define customized modes on the firmware.
> For example, the 5 modes may be noise suppression 1, noise suppression 2,
> noise suppression + echo cancellation, voice tracking, echo cancellation.

That's not really good for users, it means that their configuration
silently depends on the firmware they're using so a new firmware version
could break things non-obviously and the control might not work for some
values if one of the modes is unused.  What would be much better would
be if the firmware were to describe the modes it implements (this could
be done as metadata rather than as a part of the image being downloaded)
then we can read the modes at runtime and match them up with the
control.

As things stand this may as well just be a plain numeric control.

--O2g7+miYGsIKoR9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUM9gpAAoJECTWi3JdVIfQTtMH/3rWj1UebpqU4G4KpVtXPgkC
LBx/NxxNgtW/OZEppgz14vvXYPXCAWs4ndXKjyA3y3ubX5ZTNbY0CJJ+ttyqbyVY
S867vfZO+4klYm+f2WZzO9pGP2mw7LAacZ10C2rYtFDzGjcbu2+SgeiHRTEE95Ma
dld99wlTL7L0tBsBfVou/oSpyQECphvkxE+5+dsRkbK4SN0ddZRB6MgXHQVDHZ90
5w29g3lZm7FpJVhI6jLKLFtDwjeYozuNUCzJ8+m+ZYCbqCV1fYogK4MVNh5Ie38C
auDh9iEouNmPhgrIlrj9pZBJuh1HMS+j8dWj9VrWf5Nyx73eOwn7ev1v/d1/9QQ=
=/4Qh
-----END PGP SIGNATURE-----

--O2g7+miYGsIKoR9l--

--===============3679034204634652518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3679034204634652518==--
