From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Do not set cpu_dai.name
 for snd_link in case DT
Date: Tue, 7 Jan 2014 16:48:43 +0000
Message-ID: <20140107164843.GZ31886@sirena.org.uk>
References: <1388902199-29553-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2723277682350919727=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E4E72619D8
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 17:48:51 +0100 (CET)
In-Reply-To: <1388902199-29553-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============2723277682350919727==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rHaPbqt23PffNkT+"
Content-Disposition: inline


--rHaPbqt23PffNkT+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 05, 2014 at 10:09:58AM +0400, Alexander Shiyan wrote:
> Using cpu_dai.name for DT case will result driver cannot be
> initialized. For example, device have name "ssi@10010000" in the DT
> and this value is returning for us by snd_soc_of_get_dai_name()
> but actual registered name of device is "10010000.ssi".

This doesn't seem like a great fix, it will break systems that register
more than one DAI per device and won't help any other machine drivers
using the lookup.  I'd have expected to fix either the registered name
or the result of the lookup so that it can be used for matching.

--rHaPbqt23PffNkT+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzC/oAAoJELSic+t+oim9fmsP/iqdP6FTNYIT4Ph8oGz3XI33
6bEiOjHZ2DKRseHjXwA8jU00sV0jamuk28HNh3N5q6Wn/4aqI34hRUwRZzQJhjgg
eGEnHqeNrDH8OQUjXzAWi8xhv4M6v9eurhb+745k3O+bgXKY/mVMJzuYrKYlscja
87uO4AjELa1oxlg+8PWUTGKSrJHne6tiLNc8S7PpP2KL/S/rpGy3h+riaRaPTEuf
SXigXtCG/4U9fBXaUUtDGxwU1ctXmTZxB9tjxsmyMoyAcKM1koH6tWnrpy6DLKQV
P+fouDHBKEiBSwy7pIQXkYo4cfzdFNZDBhMRYmMdELxhRI0+HOQJ2Ee4Dt6S1aO7
JeV78tjtsXAUVSibJob6ygnXHPOfQcA0lSsN0fsaUTrBtdjw2uf/FWSE17UtJbUz
xSXXYPxN4c68V1BgbOogH54RMGon5Vk+wKJGt/H2ton1dtBe7maiiUbkyzoQdd+l
cTyPojBik1sCtbKQy+6DgC42JVpQKag7fnHAIKmUEWk1FqV8PFBpyhc5csTboUIM
OfZYV4cO9scVzbsEj/4joL3wYlQt8XsUJlB14EZXv8ztSrktzesoVR8N//1T7fUj
4nJo6C8HDVb2a9RZCT+Gwl6vksNdsrGKuDtIB4CxWE/tChldWkLfZLKvcDrNc/2d
5Oq9lUFGLaeK1Y4ceUbR
=BD1I
-----END PGP SIGNATURE-----

--rHaPbqt23PffNkT+--

--===============2723277682350919727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2723277682350919727==--
