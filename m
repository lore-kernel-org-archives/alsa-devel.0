From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 20/20] ASoC: davinci-mcasp: Change IO
 functions parameter list
Date: Thu, 14 Nov 2013 11:54:40 +0000
Message-ID: <20131114115440.GJ26614@sirena.org.uk>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
 <1384421737-4467-21-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4237671799208111487=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C5A5426170E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 12:54:44 +0100 (CET)
In-Reply-To: <1384421737-4467-21-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, Daniel Mack <zonque@gmail.com>, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4237671799208111487==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 11:35:36AM +0200, Peter Ujfalusi wrote:
> Instead of passing __iomem address (mcasp->base + register_offset) pass
> the main mcasp structure and only access the mcasp->base in the low level
> IO functions.
> In most cases this helps with code readability and it will make it easier
> to switch over to regmap in the future.

Applied, thanks.

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShLn9AAoJELSic+t+oim9PB8P/j0a1ovun46BE5+M84Kj/5df
f3EPg96VVf0bgl/WC8xitNuJQ/oOLHUNysD0e8PT1Gs+gXnX6bhzVXhHXdLYfGGn
mbT2N3Rg3IbVS66OU6oJLJktVymVH8m5MqEsW+RuTJHlES7kDGQlYMSVhTOEnsD2
NVZ3kFeZAxhAxi4/D1EVFKsBm2qi4Rg20orLnnbUMlLh9J3MiqUQ/mhba+9iLumJ
Nk02xrFn7JCXgQz4ag7Jrpp9d3mrZ+EPJi+pFhKUHs9Ki/lCWkqA6U0m+iWRPNDj
bUunbmkKdjkVNzs5MPmkvvd2mNB4qPKIX+CV96TSNUYvki77hkdA0bIAFpMry0t6
B72dlufHe+QgOyuTpSjmIx0p4EEkserpFeBWVzV7FPjfXkqpt3NdxJQkMAYFHtNm
t1ueCDJ+G/o4IKTjtVTLBXk2LJpB/kWWcEhkRKzGDDRssZqDlVku5I7EBnZmuicI
YRLlltTZ6XaaN/JEUkFWN/BG6NrSt+DNbtgNmytTAZVupSR54/pw6N4BowO6jSdv
5qHAnqDXoiClEaxRdwo7uH+wfDC7/vqL66ufADv744t0AbNrZ8HKpOP0slfcpzwI
/7vn+tFVv4zeeonevpt+XzhY2QsvK54sP8EdH6o0gBjG89qHV+oIeeURFshp+qba
2HXStr/MrP6aJFVzW6y6
=EobZ
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--

--===============4237671799208111487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4237671799208111487==--
