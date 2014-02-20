From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 004/102] ASoC: Add const to
	SOC_ENUM_*_DECL() macros
Date: Thu, 20 Feb 2014 10:55:35 +0900
Message-ID: <20140220015535.GS2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0559771559808559603=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C4926538B
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:55:51 +0100 (CET)
In-Reply-To: <1392723148-12597-2-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0559771559808559603==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/nI5WQOYKpjxyPr9"
Content-Disposition: inline


--/nI5WQOYKpjxyPr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:16PM +0100, Takashi Iwai wrote:
> Since these macros are supposed to be used for decalring const
> objects, let's add the const modifier there.

Applied, thanks.

--/nI5WQOYKpjxyPr9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWCUAAoJELSic+t+oim96yMP/1IYYxdfS32/2GklZBsI9kjo
au/7uhXh6c+WvHz745Hzsh55MAfar0R5BH2x/nDsE/9dEHB9DYvMmqr37pUhOkq1
5Kis1FgIfP2GnZPWci7EKzkg+pUPQ6DJ0AEk6eK3EJ6bD0WhFdhWmNYzEg/wjOuR
8KV7hmR9+TxTdOqwrCyU6tNK8DKpUDqS+iMR5+o9kA3o2hGvP3BzECP0bl3gwK3h
pTmOXKntEOP8UhsB/26E2asLck25ta9C6DkCHV9+cN1ta8TlBoVtZZOOdVjyBine
3Aj1XtnQ/xQHncLnT/ZAWO3l5hJo85Ra9sMOVnCEWmLpN2npfDbOCp9gXSR72baz
jEr1syFdCsIHC3mL5dKKzG7kJMS6VOF/OvEcuXtvqG/sGNAC4Z1lItXRlxuZCcZ4
A33gPOkgz8k/8BBUEUFbsXf9NohVoQvR14EhsEKe/DV+gmfunC1940M0MQiuWc7A
EIc3mW+OBFHoCafnFQFlsI78xfmRt9oeIZ4uSTERTgjjS76BrryZMqP2qKEJTuSs
Q+G0EsS7Dc3iyWNAcK0y6thTfMoWe9jp7Rvjt9VTkvjrSRv4hn9v/qyN0/qcdXkc
GdfvQZkn9FMiI8BHLvEKyfJNApZ4Fryw1LjzAAt6rVtaSAxeWwq6AVJgwkxPtkX7
hf4fkAqh6JU1+ZtSrQUv
=Lwm6
-----END PGP SIGNATURE-----

--/nI5WQOYKpjxyPr9--

--===============0559771559808559603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0559771559808559603==--
