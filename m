From: "Markus Bollinger" <bollinger@digigram.com>
Subject: RE: CVS doesn't compile
Date: Mon, 28 Jul 2003 15:10:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <08F1D234AF91E540BC1F43889E2A6AA70C1517@digiexch.digigram.com>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, July 28, 2003 11:27 AM
> To: Markus Bollinger
> Cc: Martin Langer; alsa-devel@lists.sourceforge.net; tiwai@suse.de
> Subject: Re: [Alsa-devel] CVS doesn't compile
>=20
>=20
> At Mon, 28 Jul 2003 10:16:03 +0200,
> Markus Bollinger wrote:
> >=20
> > [1  <text/plain; Windows-1252 (quoted-printable)>]
> > Sorry,
> > I didnt know that compilers can get angry with [].
>=20
> i didn't get error with gcc-3.3.  perhaps gcc-2.x only...?
>=20
> > Use the attached patch.
> =20
> or [1] would be enough, i believe.
> for GCC, [0] is ok, too (although it's not strictly defined in ANSI).


There is only once use of this stuct by a pointer to it,
so it makes no difference for the stack or the generated code.


Markus.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
