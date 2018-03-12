From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Date: Mon, 12 Mar 2018 09:02:04 -0700
Message-ID: <20180312160204.GA2186@sirena.org.uk>
References: <20180308200653.GA47801@beast>
 <20180309125050.GD5252@sirena.org.uk>
 <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
 <20180309202242.GA3073@sirena.org.uk>
 <20180312103143.y7bidz4gj6ya7dgo@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1096509956501006645=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BC46526726B
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 17:02:09 +0100 (CET)
In-Reply-To: <20180312103143.y7bidz4gj6ya7dgo@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, Kees Cook <keescook@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Pavel Machek <pavel@ucw.cz>
List-Id: alsa-devel@alsa-project.org


--===============1096509956501006645==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2018 at 10:31:43AM +0000, Charles Keepax wrote:
> On Fri, Mar 09, 2018 at 08:22:42PM +0000, Mark Brown wrote:

> > I think I might just remove the file though, it's been non-functional on
> > most systems for a while now as almost all the drivers migrated to
> > regmap and nobody complained so we should be safe.  There's still
> > something that ought to be investigated here.

> Looks like we might already be about to try that since it looks
> like the componentisation actually removed these files, although
> I assume inadvertently.

No, that's an intended effect.  This only exists for CODEC drivers and
even then it's only ones that use the legacy ASoC I/O code that really
ever got anything from this.  Anything that's well maintained should be
using regmap.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmpHgACgkQJNaLcl1U
h9BJnwf+IEaSxqmLSmXNcJS1IWYTAdjXvz4eEysxVOja9W4x+qAPlN27iFeelxtK
WkQotQrvdNsUdUNoD58K4ApwuH5Vz0gbAgl05CS7t2qDEDgELpgv0LGZcw3WghWD
ktdk2RvnANbNjrj3atrAZ64O3TWZWPzOoVR5H712SGUT7wEvuu5ZOrkTD94SfDzw
tefG29lDWWLfUpZkTG+bIMpBqIT5y9bwHw8tkOYmNEw+sEpb8WtLJtqI1Z+nkK+p
KKAE2rhJgZox38MxAvDaUxVV84U/RpGGnOyJOrupkFczxfGv+RAi/eDBs55WUQhz
n+MUsGVBaPVQ2wKuFumOsj9GetXAxg==
=Mttv
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--===============1096509956501006645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1096509956501006645==--
