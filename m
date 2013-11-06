From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/31] ASoC: mid-x86: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:33:17 +0000
Message-ID: <20131106103317.GV11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-15-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3757535466170824285=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E34E265007
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:33:22 +0100 (CET)
In-Reply-To: <1383673218-18405-15-git-send-email-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3757535466170824285==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QILrdhYozogw5Vly"
Content-Disposition: inline


--QILrdhYozogw5Vly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:01PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--QILrdhYozogw5Vly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehrqAAoJELSic+t+oim95bwQAIvIrvmCb0psYC/C892w5NrY
pk2GVYgoL45KR641o6zZDxHB9S+wPEJpi/h2YsW5TH4LSt/AxX/5BqUaLnzg0c+6
qUSR2hrLVsk/o+pLhBwMQj/Y9wFivsM6AhkX41EKQZmOCNO8U0toE7Fg+fyMWwtv
+1SLMKYxGmDytKGnTafwpDJgqmuGBcqOkBhtUuR0FZW9Xjpib8iV5zeD5fMNlQqc
uyq6yHZ8Qr09/K8M1Qh//xutcNZTVTslL/XbFxHZ9c5olHn/M42tge+Jzfde8vda
Ts2MEdccadmmVDmvTL51wYUr2XT8S4yTvmc86GUqusQo1I1okljEuhqNJdp+vFCZ
I0Irq39b0lA0DlxJmc226fpTW/51mVjZd9g04VLYsGr/O6WMhYrvRAg/EWQ0d98j
skuJd0W5rMCujINKwfaI3ZxNxlEyiXa0gBKBD1+eQutMk52rFmOMROoP54f5AlNm
+JZ94166nQMzrJbAtllrn1JnVnw13qg9BqNcDa9beIxZXV5Gjdgku2aDu9OGPH8t
D/FnB3RQqACrvler6wTPh04ZmQ/M+lJZku0FtSHToT8KcEs/v+fk2kfBFufVYQ6c
1GizuhJ/LhPTc4Fla+SHq+qm4MK6QFJ6CDuwPOswVufI4gVQ2bOJC+HovSyznCyd
7XpZw4vCZdTS+//sMkpj
=rj4F
-----END PGP SIGNATURE-----

--QILrdhYozogw5Vly--

--===============3757535466170824285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3757535466170824285==--
