From: p z oooo <pzad@pobox.sk>
Subject: ALC650 + Mic input not working
Date: Mon, 19 May 2003 07:54:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305190554.HAA17705@www7.pobox.sk>
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

I have MSI KT333 (VIA8233A) + ALC650.
For me, mic input is not working.
It looks like my motherboard (and some of others too) uses GPIO0 pin=20
of ALC650 to swich mic bias on/off. Look at ALC650AppNotes_1.4.pdf=20
page 3 (this is recomended connection). ALC650 rev.E doesn't need=20
this (and than mic is working). I tested attached patch and mic (sets=20
bit 0 in reg. 0x76 to 1 - gpio0 =3D output and bit 8 in reg. 0x76 to 1=20
=3D set mic bias - gpio0 - on) works, but I think it is not good,=20
because when mic input is switched to center/LFE output, mic bias=20
should be set to off.

Peter Zubaj



=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AZ=EDskajte superv=FDhodn=E9 ADSL e=B9te v=FDh=
odnej=B9ie v cenovom odpo=E8=EDtavan=ED Slovanet=0AADSL Teraz! =C8=EDm sk=
=F4r sa rozhodnete, t=FDm viac u=B9etr=EDte.=0Ahttp://www.slovanet.sk/menu/=
adsl.html=0A


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
