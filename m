From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 18:49:10 +0530
Message-ID: <20131129131910.GH8834@intel.com>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de>
 <20131129110549.GQ27568@sirena.org.uk>
 <20131129102937.GG8834@intel.com>
 <20131129114603.GS27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5772109090597686897=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DE77A261700
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 15:16:36 +0100 (CET)
In-Reply-To: <20131129114603.GS27568@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5772109090597686897==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2013 at 11:46:03AM +0000, Mark Brown wrote:
> On Fri, Nov 29, 2013 at 03:59:37PM +0530, Vinod Koul wrote:
> > I am leading more towards adding new ioctl for this along with new ones=
 for
> > enumerating controls. Then additional support for alsa-lib and tinyalsa.
> > That way existing tinymix, amxier can see these as controls while not d=
isturbing
> > existing apps. I dont think we need save and restor, then alsactl need =
not be
> > modified.
>=20
> I doubt you need it specifically for alsactl since that's a bit basic
> for most of the users but it would be good to have the ability to write
> tools that allow people to tune interactively and then save the results
> in a format that's useful for whatever use case management is in use.
I agree alsactl may not be required here and if its felt we can always add =
that!

managing parameters is different problem and yes needs to be dealt sperately
with tooling as well

--=20
~Vinod

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSmJROAAoJEHwUBw8lI4NHuREP/2sI6RMoMGqw1ScxpllHomf3
GiDKW8rLDIpwUtAsWQrTzK6OhmmUGb0A2LQXRSZD5OPKrGw5hIkwv8C5zzzAV6I4
DAYW8KIDrB43OLuVmRpwRXtQIEHzS2NVQIahS/6bUR8P8/OvlyFNBkJEEIl8DSeN
5VbzfTZfmPGd5F7jyVjBd+fewZtr6537O8EHD0nvEfmzDfqVk8oFJnawCm45Whaj
yodtgqATtMihUwvqGh2hoa9SMpwvBRmETecLkeptzaG9GfPEWCgsEegq9cYv1dCk
GxOvQlp2jf9ZdQPYE7KRA1/iO0hTjeSLm5v2tjZiOv5Vrw66BWROkZxkFL2T5plQ
+T27MWi86w3tk1TFSAi1egHG+EorFy5fdlGtkTH+WC2Xwn0Sz1aJyjLSnUl9WLNL
tLPN2vrMs+xyHKhXxQexLRKw+ePe2gG8K26FiAhgL/+geFk/8CLxHxLjWqytxNH5
9lsMqCFntrsw9IbUP9XUZndglJPYerPHhWd4RGlF+DjCDtLMAO2fK0YYwbXzXIic
b9K3jHUA5Q4HgVGHoWiFyx/ZtwIqN+vt5pmEABtY3YnNirTjxrbdqRTNeV1gHYTu
dV1wiB3I49sjXZ4iGhyrJJaYjwuQMKyNBCW3Q9lNb3CahwtN27a8tmxdLfhtCUwv
GwLmbPBau3zwQ/XhkCD+
=obhD
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--

--===============5772109090597686897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5772109090597686897==--
