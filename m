From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Release firmware on error
Date: Tue, 22 Jan 2013 16:40:25 +0900
Message-ID: <20130122073930.GD1766@opensource.wolfsonmicro.com>
References: <1358758951-29281-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2417313744981283643=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6481D264F24
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 08:40:46 +0100 (CET)
In-Reply-To: <1358758951-29281-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============2417313744981283643==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2013 at 09:02:31AM +0000, Charles Keepax wrote:
> This patch correctly releases the firmware if the magic string in the
> firmware header does not match.
>=20
> Change-Id: I2d08f7fff92b2f0e0f2ab1fb937007e3783f815e
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Applied but:
 - Don't include noise like Change-Ids in upstream submissions.
 - Always CC maintainers on patches (you've missed Liam).

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ/kI8AAoJELSic+t+oim9pZMQAIElbhHP5DB20oxm11WgL5t0
PaHpzT5rK0gZaxW+Mgt6Ks49vMkcVNql+fZ4ODwTVag9hP8PRxmye1o1KTH/vF8+
7Ar1zeI+i7qvOjTnVLfLmYWXp6M6sq+o86VFfkhi1CyKKyd/vhV3sCwqTxIe3eFR
3W/aRdN+I93l9kJFcflFc6BzMq0GsnPEzUOQEJ6BWU+rlqVgdxeTkgWXrgKC6v5s
clYcTHrrz18sODDWBZlX85kJ55kTSO43su/yA9JJ+6ANS/lKb+VlZ1G7zxe4pxEg
56AYp3LJx1puB9sJmXAYe8TJdmAEojR7ff7XYcvJUrrWH2FNf6cCIPSAEc0p2OH1
HPif7h69JKPsXPJE6Bcif1nO0N4Q8rMe751OqjCjF/+DycxG2kFU9kftoUdw5IsO
kkCqdS+jxDcmPNWX3oEqZsOKeEL8GpHpdge4x329fPfYKa1IT2Drqw0muZ6MaN1b
jvgDlhCDI8JT9Tq7EVnRv+4kd9EEdu7SLQ3OUBjMsRUM1B9xcxGxpa5Ug5+ugk88
zALCNOaL/ZceZKV+Xfu1kebezOlYp4oRCcmwalkgkcsMki1EIhac62TzeEmpAfGx
AbSg9YmxcsW0Y4PjhuaEfk3LkV0WlOd6tUJdjccbadWR6m3v9SbZs52ymNYPMlY1
7lKTcfHhLJmLEbVzy5Wa
=GkiX
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--

--===============2417313744981283643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2417313744981283643==--
