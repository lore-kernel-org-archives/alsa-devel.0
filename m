From: p z oooo <pzad@pobox.sk>
Subject: Re: emufxtool, formerly ld10k1
Date: Mon, 11 Aug 2003 12:42:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308111042.MAA21987@www1.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: nigu@itadinanta.it
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

Sorry, I was on holiday.
I have not enought free time - ld10k1 progress is only small (mostly=20
I was discovering how is TRAM working on Audigy).

On protocol:
There is such protokol, but mostly it is only one way (loader ->=20
linker) - linker -> loader part is missing (for now).

On lo10k1, ld10k1:
I want to make library from loader part which hides communication=20
protocol details, and can by used by anyone.
Some parts needs to by rewriten.

I will try to write some details about this protocol, and how should=20
the library look.

Peter Zubaj


=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AVyrazne zlavy pocitacov a prislusenstva=0ADig=
italny fotoaparat Olympus =B5300 v cenach uz od 16.100,- Sk bez DPH=0ANavst=
ivte nas na adrese http://www.somi.sk/akcie.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
