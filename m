From: p z oooo <pzad@pobox.sk>
Subject: Re: [PATCH] - Audigy 1 and Audigy 2 mixer - again
Date: Thu, 6 Nov 2003 08:12:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311060712.IAA20035@www1.pobox.sk>
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
To: James@superbug.demon.co.uk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have Audigy 1 (model SB0090)
Audigy 1 has UDA1361TS ADC too (look at card picture - just above=20
1328)

UDA1361 is connected on AC97 line out.
Why use UDA1361 ??? Because it is 24 bit (you get beter resolution)=20
and it has beter S/N as AC97.=20
If you have Audigy 2 you can use UDA1361 ADC without this patch.
Use ALSA version 0.9.7 (in 0.9.8 is AC97 master disabled). Set AC97=20
volume to 0, set Master (ac97 master) to 100 %, and set IEC958=20
Coaxial volume to 100, Set unmute Line In (CD, aux, mic) volume and=20
set it's volume to some level and listen.

Peter Zubaj
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AVyrazne zlavy pocitacov a prislusenstva=0ASun=
Fire V60x servery v cenach uz od 96.000,- Sk bez DPH=0ANavstivte nas na adr=
ese http://www.somi.sk/sun/linux.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
