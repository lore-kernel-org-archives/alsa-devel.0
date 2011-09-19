From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: VT1708 clicks & pops
Date: Mon, 19 Sep 2011 19:14:13 -0400
Message-ID: <20110919231413.GD1223@alittletooquiet.net>
References: <20110916203601.GD8309@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6625081557673079304=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 0947A24B30
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 01:14:15 +0200 (CEST)
In-Reply-To: <20110916203601.GD8309@alittletooquiet.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6625081557673079304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 16, 2011 at 04:36:01PM -0400, Forest Bond wrote:
> I have two boards with a VT1708:
>=20
> * VIA EPIA EX15000G
> * VIA VB8002
>=20
> I'm using VLC to play audio via PulseAudio to the analog outputs.  The VB=
8002
> sounds great, but the EX15000G has random pops and clicks in the output. =
 Both
> machines are running exactly the same configuration (they are using the s=
ame
> pre-built OS image).

Maybe this issue would be more approachable if I could produce it without
PulseAudio involved?

Incidentally, these boards both produce a crackling/static sound when Pulse=
Audio
is playing and the PCM mixer is turned all the way down.  I have seen scatt=
ered
reports of this in various bug trackers.  The problem does not occur when
playing via alsa directly.  One thing I have noticed is that the crackling =
noise
follows the rhythm of the music being played.  It actually sounds like the =
music
has been heavily distorted (i.e. via extreme digital clipping) and then
attenuated significantly.

It seems likely that there are driver issues that PulseAudio is exposing.  =
What
can I do to track them down?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk53zMUACgkQRO4fQQdv5AxfSQCfSUfMQV8fBcxsogwcc/ocfhBk
qNUAn2srwtbTpocT5fABpUu+RtoiMy8x
=8nhb
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--

--===============6625081557673079304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6625081557673079304==--
