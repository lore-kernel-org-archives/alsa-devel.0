From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] mfd: arizona: Add GPIO control
 register bit definitions
Date: Tue, 2 Jul 2013 16:51:44 +0100
Message-ID: <20130702155144.GS27646@sirena.org.uk>
References: <1372776817-29811-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5460438688645895944=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C0B626549A
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 17:51:49 +0200 (CEST)
In-Reply-To: <1372776817-29811-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5460438688645895944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMHhwLwacXQnT70n"
Content-Disposition: inline


--VMHhwLwacXQnT70n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 03:53:36PM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  include/linux/mfd/arizona/registers.h |   35 +++++++++++++++++++++++++++++++++

It's probably best to do what we do for several of the other MFDs and
put these in a separate header as they are useful for platform data
users.

--VMHhwLwacXQnT70n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0vcNAAoJELSic+t+oim90rIP/0CwIJ8mcLreUnbjY58WZ78Y
oV6/98CVNwcwPkQ7O6Iszd8lyj39/MQMinbjcRZwZ64jgI8JyWgn8aQUHK+m6XFF
YPspybvJ+RFgbNP4A8LE2Ohyuc+sYJccGvkU3Jai90xozjfEnWCKF3Rbk61VfOzB
H0afojTiqa+F37LFLFF8fjaL6NsEL5ttQsQmWidJH3/RBE6l3WAmiLcQ2lzU61aK
nSvZdp7rleunT3STH7R8dmHFbkIuA/hGlNM1LJqND9JgvBik41FjRAj8YirsNJGo
XIQgGd9BRd8ujA3/1UUJVpJMowWiNXDOJc+q/pqv7EaQufnBEXni493k7WodBlWn
Nhf60bhw3vXF6bPwlE3OOMf9tac5DWTsglWho5STmtO5/ghzMyiYF0zIuLQoZs8A
XsAXuuk4cmvkQasy7FefPlogvy6Ls+N+CLtsKrOUwHvLiXhXNrhW39//bt6alegc
sUKWOjRDia5VuNc3L3qCowe8jv6oubmPYOPhbfvXGSzx4rGEVx6A03S/f8Ukaw1Z
NGct4CcaLYJb0fABeKhsJV07CxkD2GUfAGAozwl16C5FkV1PvI3bd6iTd+t64vGC
tfpi0F6Wu1w4fcIeZBNxxDjC040kNO1Me4v9EDCAGJo5IeeDp/78I5l7opByxX/7
q4+vi9f0W72UdeykLxCP
=afdE
-----END PGP SIGNATURE-----

--VMHhwLwacXQnT70n--

--===============5460438688645895944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5460438688645895944==--
