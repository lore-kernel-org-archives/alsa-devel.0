From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: SoC: Added jack detection kcontrol
	support
Date: Tue, 23 Jul 2013 13:40:23 +0100
Message-ID: <20130723124023.GX9858@sirena.org.uk>
References: <1374281962-3786-1-git-send-email-eu@felipetonello.com>
 <20130722000157.GI9858@sirena.org.uk>
 <CAGrhNMyAofsnwKYMk+60GyvpaW9pMtoJf_2Q_Tc82G8QCFOiFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8381585843396947932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 46060264EFF
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 14:40:27 +0200 (CEST)
In-Reply-To: <CAGrhNMyAofsnwKYMk+60GyvpaW9pMtoJf_2Q_Tc82G8QCFOiFA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Tonello <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, LiamGirdwoodlgirdwood@gmail.com, "Felipe F. Tonello" <ftonello@cercacor.com>, TakashiIwaitiwai@suse.de, linux-kernel@vger.kernel.org, JaroslavKyselaperex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============8381585843396947932==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OGBBnVs4XFPv5LQD"
Content-Disposition: inline


--OGBBnVs4XFPv5LQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2013 at 02:11:44PM -0700, Felipe Tonello wrote:

> My question is: Why ALSA Jack support uses evdev input events to
> notify user-space? Is there any user-space relying on that? If no, I
> would like to change ALSA Jack implementation to only use KControl and
> remove specific implementations.

This was the existing kernel API at the time that the code was added -
I beleive people had been doing that for simple switches that detect the
physical presence of a jack since it looks exactly like a button from a
hardware point of view.  See the original commit adding the code.

--OGBBnVs4XFPv5LQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7nm0AAoJELSic+t+oim9PRkP/22oRPWQG+XHKy0GHH7lSILu
hTulnGK9WyS/db0Y0u+XLOycL8FtEejfy9khf5p2D5fGAHH4CbCirgQNzwR6rpS7
wCTSyW3cGGhUVcH7ZwtBHbk6VjfNQJYWU7/ZZG13Jhv+aQwe4adnk4Tz1llnNC3e
NbFl3kqgzkgCLsTJ1OxIu7LXoiMqOGnnonEPHA3jSZLFoDjf+VZpYqXYn1qv1T0p
rajtUPXOE6SFt706xu0fJBGTvc2eRUWTbnrAEYKvbSj+VLRlDlIH7sNUQ8EgGcmT
TR2hnlB31NhwuTVwH1oyaxjkdg8XMz1SwXJMS9LbJlmKVeeBAygPxXetxrVRttw4
fl5CMJJhPHHtFgYzplRqdUlQvl1szJOjM6Ua6VAWBsmjX8XHI86REz6N6Q7eHMeJ
XbzXkQ5rDseYElA8tcUktnfEvCfn6+vPgH/6zShJUVBSylHvB8WpzM8Bw54RdJV+
hMSzNA/A2zRJTsqWWJ+as1r7Pk8e0vTtA0IwIiaj0xrvU+LFSg2eCIvDKS5DZyI+
RhFm+/HuUjug7H+l99dvXgKOq4kIWliC4876ZYGEOQ8MGwlnWJlFKBVl7RsByp6W
O6vEl/IC2wIAB39Bj6INGLlAFy+KTmOFlplrj2W6Rv8rJ0ddTtDOm40f+8bu1hIv
BrTVxNC27QJ1AdsEs1ae
=WAKP
-----END PGP SIGNATURE-----

--OGBBnVs4XFPv5LQD--

--===============8381585843396947932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8381585843396947932==--
