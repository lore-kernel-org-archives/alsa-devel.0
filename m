From: p z oooo <pzad@pobox.sk>
Subject: Re: Support for realtek alc 655
Date: Thu, 4 Sep 2003 15:49:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309041349.PAA04964@www3.pobox.sk>
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
To: m.canini@libero.it
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>There exist some ac97 codecs capable of hw multiplexing?
>What are them?

I think that none. AC97 is only part of sound system. These part is=20
reponsible for A/D and D/A conversion + analog mixer + spdif in +=20
spdif out. Most capability is in second part. This second part is=20
responsible for playing digital sound and hardware mixing and is=20
integrated into motherboard chipset. For example you can have two=20
motherboards which uses same AC97 codec and one (for example VIA8235=20
based) is capable hw mixing of 4 streams and second (for example=20
intel based) can't do hw mixing.

Peter Zubaj


=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AVyrazne zlavy pocitacov a prislusenstva=0ASun=
 Fire V210 server v cenach uz od 125.000,- Sk bez DPH=0ANavstivte nas na ad=
rese http://www.somi.sk/sun/lowend_servery.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
