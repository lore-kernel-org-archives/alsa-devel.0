From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Subject: Re: Since kernel-2.6.32 alsactl thinks my sound card
 is "Unknown"
Date: Thu, 02 Sep 2010 12:00:09 +0200
Message-ID: <1283421609.6497.5.camel@localhost.localdomain>
References: <4C7F6FBB.3060509@canonical.com>
Reply-To: pacho@condmat1.ciencias.uniovi.es
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2898018415476334785=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp02.jazztel.es (smtp02.jazztel.es [62.14.3.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 82CE42462C
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 12:00:16 +0200 (CEST)
In-Reply-To: <4C7F6FBB.3060509@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2898018415476334785==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-x+oeNrsovhlDCuaMvNOS"


--=-x+oeNrsovhlDCuaMvNOS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 02-09-2010 a las 11:34 +0200, David Henningsson escribi=C3=B3:
> 2010-09-02 11:26, Pacho Ramos skrev:
> > El jue, 02-09-2010 a las 10:29 +0200, Takashi Iwai escribi=C3=B3:
> >> Rejected by SPF lookup: (recv=3Dllar.net.uniovi.es,
> >>  send-ip=3D195.135.220.2) Could not find a valid SPF record
> >> User-Agent: Wanderlust/2.15.6 (Almost Unreal) SEMI/1.14.6 (Maruoka) FL=
IM/1.14.9
> >>  (=3D?UTF-8?B?R29qxY0=3D?=3D) APEL/10.7 Emacs/23.1 (x86_64-suse-linux-=
gnu) MULE/6.0
> >>  (HANACHIRUSATO)
> >> References: <1283357723.8159.4.camel@localhost.localdomain>
> >>
> >> At Wed, 01 Sep 2010 18:15:23 +0200,
> >> Pacho Ramos wrote:
> >>>
> >>> This is an old problem I am suffering since kernel-2.6.32 and that is
> >>> still unresolved even with 2.6.35 and alsa-utils-1.0.23:
> >>> http://www.spinics.net/lists/alsa-devel/msg31422.html
> >>>
> >>> If you follow the thread, it got stalled in:
> >>> http://www.spinics.net/lists/alsa-devel/msg31433.html
> >>>
> >>> In summary, I get the following:
> >>> # alsactl -f /etc/asound.state restore /dev/snd/controlC0=20
> >>> Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147=
b"
> >>> "0x1415"
> >>> Hardware is initialized using a guess method
> >>> # echo $?
> >>> 99
> >>
> >> This is no error.  It means that alsactl has no special workaround
> >> for your hardware.  The return code of alsactl looks strange.
> >> I thought Jaroslav has already fixed it, though...
> >>
> >>
> >> Takashi
> >>
> >=20
> > Well, Jaroslav fixed it to use "99" instead of "157":
> > http://www.spinics.net/lists/alsa-devel/msg31430.html
> >=20
> > And, about the message, could it be reworded for preventing to make
> > users think their hardware is "Unknown"? Maybe it could simply show "No
> > workaround needed for: ..." instead of "Unknown hardware"
>=20
> Perhaps "Generic" hardware?
>=20

Looks fine for me :-)



--=-x+oeNrsovhlDCuaMvNOS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx/dakACgkQCaWpQKGI+9QUiwCfaMd520UWvT3EzXq0jKAoz0Of
WaEAnjYmlVKGAoA+Cg6vQ4uas5moWoXa
=v6lU
-----END PGP SIGNATURE-----

--=-x+oeNrsovhlDCuaMvNOS--


--===============2898018415476334785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2898018415476334785==--
