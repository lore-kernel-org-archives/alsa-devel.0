From: p z oooo <pzad@pobox.sk>
Subject: TRAM on Audigy
Date: Mon, 7 Jul 2003 09:19:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307070719.JAA06549@www1.pobox.sk>
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

Hi,

I wanted to add support for TRAM on Audigy to emu10k1 driver.
I look (tryed) at OSS driver and found that TRAM is not working=20
too. :-(

Then I use trial and error method and found how to setup TRAM on=20
Audigy. I know how to read from and write to TRAM in EMU10k2 DSP=20
program but not more.
Is there any documentation on using TRAM on Audigy, or am I only one=20
(except Creative and Creative NDA signer) who know how to use TRAM on=20
Audigy ???

I need more info on how is TRAM working on SB Live:
TANKMEMADDRREG_CLEAR - Clear tank memory
TANKMEMADDRREG_ALIGN - Align read or write relative to tank access
TANKMEMADDRREG_WRITE - Write to tank memory
TANKMEMADDRREG_READ - Read from tank memory

Please help

Peter Zubaj

PS: If no one knows more, I will make patch against current CVS and=20
send it to this list. (mayby AC3 passthrough using TRAM will work=20
too :-))

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
