From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Audigy SB0090 identification patch
Date: Fri, 1 Apr 2005 15:51:43 +0200
Message-ID: <200504011351.j31DphHo001101@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: nightbreed@verizon.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Not this patch, but this one:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/include/emu10k1.h?r1=
=3D1.62&r2=3D1.63

---> unsigned int card;

Oopy of emu10k1.h in alsa-lib should be in sync with emu10k1.h in kernel

Peter Zubaj

>I'm not sure if anyone is aware that with this patch installed, it
breaks=20
>ld10k1. I get the following errors when trying to load it:=20
>
>Error: unable to get info
>Error: error in main loop
>
>Peace




=0A____________________________________=0AVsetko o SuperStar=0Ahttp://super=
star.atlas.sk=0A


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
