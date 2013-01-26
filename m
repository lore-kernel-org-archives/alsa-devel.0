From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix mono
Date: Sat, 26 Jan 2013 16:55:14 +0800
Message-ID: <20130126085512.GC30594@opensource.wolfsonmicro.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2368583195449019932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D12092616F3
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 09:55:20 +0100 (CET)
In-Reply-To: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2368583195449019932==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2013 at 06:19:20PM +0100, Beno=EEt Th=E9baudeau wrote:
> The TLV320AIC3x DAI supports only stereo. This patch fixes mono support f=
or this
> codec by allowing only stereo at codec level.

So, this doesn't actually fix mono - it removes support for it.  It's a
bit surprising that this is a requirement actually, the device seems to
support DSP modes which usually do mono totally happily (I2S style modes
have problems due to the clocking).  I'd like to see some confirmation
that there's not some other issue in your system...

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA5noAAoJELSic+t+oim9AJsP+waeZd2IFqecTr9Pf9ieVxCJ
x3LuBBfuEu2ZbElMnHQlAuH+6VPAUaNgWi4f9CnvHO3849c5G9O1+6jBAQvDBt75
Z40bK9yKKUffYfLoH1tqQhtA8AUVFSFmXcN7XtFVK/D9+2wLUvYbgyC+NlDQccVb
Z8BBCZn+QHQD3i1WFc602NtmEWfE1dSn/6StVN3CuCkB95hTqyD+ZBmoaPFnbaQR
ZbHFMBMbnKOkJA3PAnYMdtnB6pbPVygeIjrzb6OppRvw4S4/YM8bMg5b/6t+NNDj
whTNK+ycFUKkAO2nkqun3akMFwJ3WJXtjok1x//TSF8wD9Uh2euz8gDZKX5Fj5ip
nW0HTRpNOvGFh7eMEgUzofxMmcb491clcFkSJprYBk4d7pzcRxXzvWoYoGWiNDw6
WJ+T/t/OeoHSLYcq90RKzezuIweUSNDZz0XkdR1+QiVwBAB1LxVisiWbpUiBXOBT
gjcdRf78qPVXTKkSPSGleuM+28LKdKzsY2BL1w45ZnhLPHyhFjY1JgYtD16g2NHM
+K4Qql6bMvYfCtyy49w/mQ9TDLuzQ1ebRt4BPnTJJe9BWsrZTVS53y/gTNDOUpWj
AAfDmbRYR0DVG5W2JQY1IaqZG5IH70d/nc7kU66L7SsESjCesB4bG9oROwUTrx5M
PD4lXz5xOPsnWvyGB9VH
=23ZM
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--

--===============2368583195449019932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2368583195449019932==--
