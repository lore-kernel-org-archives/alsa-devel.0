From: p z oooo <pzad@pobox.sk>
Subject: TRAM on Audigy - INFO
Date: Tue, 8 Jul 2003 08:05:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307080605.IAA27426@www7.pobox.sk>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Following information was obtained by trial-and-error.
Use it at your own risk!

TRAM setup:

TCBS (0x44) and TCB (0x41) has same meaning as on SB Live

Internal TRAM size is 0x4000 (16 bits words)
Max external TRAM size is 0x100000 (16 bits words) - as on SB Live

Register description:

0xdb - Internal TRAM Delay Base Address Counter - is in sync with=20
0xde - but only 0x3fff wide
0xde - External TRAM Delay Base Address Counter

0x100 - 0x1ff - tram access control registers (?)
=09- only 5 bit valid=20
=09=09bits : 4 - 0 - use log. compresion on write and read
=09=09           1 - use raw access - data from/to tram are=20
read/wrote
=09=09               as 16 bit samples
=09=09bits : 3210 - ???
=09=09       0010 - read from tram
=09=09       0110 - write to tram
=09=09       others - ?????
0x200 - 0x2ff - tram access data registers
=09- same as on SB Live
0x300 - 0x3ff - tram access address registers
=09- address format - host: 32 bit offset 20 bit integer part +=20
12 bit fractional part
=09  to set offset to 0x123(SB Live) - 0x123 << 11 (Audigy)
=09- address format - DSP: same as SB Live ???

internal TRAM has index 0x00 - 0xbf
external TRAM has index 0xc0 - 0xff


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
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
