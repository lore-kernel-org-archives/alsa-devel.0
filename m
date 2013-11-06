From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/31] ASoC: wm5100: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:32:06 +0000
Message-ID: <20131106103206.GQ11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0867958403441445661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CE19261A19
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:32:09 +0100 (CET)
In-Reply-To: <1383673218-18405-9-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0867958403441445661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V2tfspbppmK1TQo2"
Content-Disposition: inline


--V2tfspbppmK1TQo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:55PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--V2tfspbppmK1TQo2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehqjAAoJELSic+t+oim9YXcP/2GXhmfqx/ituBT+CzuoZnBC
si5G8LTCWZF19EQ6XsH+nxhoxT2QXG4snxta+GbGwtoj/5rXloNEovaAfjhln8I8
8F47AwF2/ASyHawwgpbwQvO89F77+KbQVPWNucb9bT1qpYvkAEgN3cG2cmoOZcsE
MXT3DaaU62XFBb8v9BtfEU0VWboURbB67d+2RkevB1Fr8r6J7ZhpvxwpY3DrkrkQ
EdjVNRv0RotZT7EDYN1qLXDueP9p2PqM5ROgGvr8IlMEFQxkuy2k6TSgXop0f0KH
VDKF2Ej07oA3Qn7MNJ4ASlukC7AuWD7wnPFxRncP1KRTd8mNYhCHIwXXTMIwtpYR
gkBKQelZsXCaO4wI7Mqdl0hZGxi+TJi0SOWxb3Iw9QzA71T8wVksDIuMmS/vJe81
0EU1aYSUAaaD7lme1Stsdak08zmRUzxIks/ipd6FQF9AvFoz1HXUIA0hAwxHR7yU
rYTghcI7tE0kEpjeghIBHxDhTdSnCqpLYa78i3ST2GnS30HN6VIdxdg/3WxxEJo2
jdpPiWr1IgNypuGE+JrHAeSOGIUr4j41VDcHzyBQZx+J0ubK74/3Z21HUZnW6DuF
NJvtbfrAER9kdRoWY4h+M2HqnbBOhY5t8jfInbjU3LeroLW+6Nx+lko0JfG30Ata
oXnl9RBvwGpKcqar3B+L
=jCuT
-----END PGP SIGNATURE-----

--V2tfspbppmK1TQo2--

--===============0867958403441445661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0867958403441445661==--
