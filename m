From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] ALSA: hda/realtek - Keep analog bypass
	muted on ALC892
Date: Thu, 9 Aug 2012 09:18:48 +0200
Message-ID: <20120809071848.GB6979@avionic-0098.mockup.avionic-design.de>
References: <1344494839-6942-1-git-send-email-thierry.reding@avionic-design.de>
 <s5hfw7wfszx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0926672203044211977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C45F265294
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 08:49:05 +0200 (CEST)
In-Reply-To: <s5hfw7wfszx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============0926672203044211977==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 09:02:10AM +0200, Takashi Iwai wrote:
> At Thu,  9 Aug 2012 08:47:19 +0200,
> Thierry Reding wrote:
> >=20
> > Unmuting the analog bypass causes any input to be directly bypassed to
> > the outputs, which is usually not expected by the user.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Note that this patch could be generalized to include all codec variants
> > that have this second channel. As I don't have access to all the data
> > sheets I'll leave that decision up to somebody with more hardware
> > available.
>=20
> Hmm, are you really sure that this is exclusive switch between two?
> All Realtek codecs with this mixer widget mixes two sources up.
> Otherwise it must not be a "mixer" widget at all but it must be a
> "selector" widget.

It's not an exclusive switch. But the second input is the analog bypass
that basically takes the signal directly from the input path and routes
it to the output.

> And I haven't received a bug report regarding this although ALC892 is
> no new chip and the auto-parser has been enabled for so long time.

I've seen this happen when feeding a signal into the CD-IN (NID 0x1c),
which is then directly routed to the output, so I actually hear that
signal at the output, even if there is no software loopback to capture
the input and play it back via the DAC.

This is probably not a very common use-case, so maybe nobody else has
come across it. Looking at the block diagram in the ALC892 datasheet
(page 5) clearly shows where the input of this second switch comes from.
I don't think this is intended to be unmuted by default, but only in
very special cases where you actually want to pass the analog input
signal directly to the output without going through the ADC and back out
the DAC.

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI2RYAAoJEN0jrNd/PrOhgvIQALJ/nzlAkLx5at9u0ZUXVqod
gDw3eVArqBW5Vt3tuWOBcZWba7hGoii/Fbc97JRbf458utSzAWXOtwVVRZaCEnI1
TurHALdXZBmfF0grl5tn580g2y43/KKyKkXtGhq+nkWJouMMGDlaJ85fIOKdKKd6
xSxfwnWGl6mTrV/i1FAbM+t1h5PEsVQO/2FfLe1bO7IvQLHAzWUrV/B2XBA1oOeN
MNt97moj6+4AWkv5oBhaufMzvQPGp6mxVBbotDyHypwA0PZeTAMzkmaz+cr/dDnQ
TtP6rLa0JIQoCfRM5L1boE44x3Ip+xtwPsRQyVVQY7kDpcJ3dmROMzRElcuh3box
6QSyxRH5nu8WY0NFZ2u/wLKQDzYkVOwnw5J00sKKEImY+ss9XSzecKs6wY4xaplY
F0uGQpWnwyeXHyELI7hdrO3OvQfE9MzGz1tiIIu7CQWZwr7Fxu41wuw/K+eiZmWR
6kiqMJryNV37zGamQGjMen6FNYlzXNyBU7YfYZxSlhgfV/LZ86loSJPgj2NmQzE8
OqFzZ5ajpJB9eAVbRKISSTsHP0JBEFTbPTE8ppUGMt7Gjh8rAfPa/zULC0RLYLcn
idvaGzBY7RL87ul5UYjFNoKho/QAAee6SODWNb9SUujAHQpanpOuyBDwCsPI42pw
twa4zLamxXCzBFeg/i1Y
=2pd9
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

--===============0926672203044211977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0926672203044211977==--
