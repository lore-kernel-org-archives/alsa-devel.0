From: "Marc Titinger" <titinger@digigram.com>
Subject: RE: [Alsa-user] vxpocket / alsa 0.91/ recording freezes the system
Date: Mon, 17 Mar 2003 09:30:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <08F1D234AF91E540BC1F43889E2A6AA70AEC2C@digiexch.digigram.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthew Yee-King <yeeking@no-future.com>
Cc: alsa-user@lists.sourceforge.net, "Alsa-Dev (E-mail)" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Hi Matt,

>=20
> My main aim was to test the latest vxpocket driver and see if=20
> it works=20
> with jackd/ ardour.=20
>=20

Thanks for your report, I cc it to alsa dev.

> These are my observations:
>=20
> When booting up, the vx is not recognised. I have to restart=20
> alsa, then=20
> i can see the vx in alsamixer.

currently, I'm running vxloader from my bashrc file. This works. For =
some reason, vxloader will not work as post-install option, it's maybe a =
question of timing.=20

>=20
> arecord -D vxpocket -f cd test.wav=20
>=20
> throws an Input/Ouput error then freezes the whole system.=20
>=20

Yes, record hangs on vx boards. I will look into this if I have a chance =
(and if my boss agrees). Takashi Iwai may be faster then me on fixing =
it, though.


> I had better results with the old vx driver (jan 2003 cvs) -=20
> it recorded=20
> through analogue and digital inputs but the recording was distorted.=20
>=20

Is it distorted with both analog and digital sources ? If only digital =
recording is distorted, it maybe a clock source selection issue.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
