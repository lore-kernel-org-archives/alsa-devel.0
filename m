From: p z oooo <pzad@pobox.sk>
Subject: RE:Creative/emu10k1 status?
Date: Tue, 18 Nov 2003 08:18:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311180718.hAI7ILOZ006781@www7.pobox.sk>
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
To: kouhia@nic.funet.fi
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I think, there is bug, (there are controls with same names for line1=20
and line2)
Try find text "Line LiveDrive Playback Volume" in alsa-driver/alsa-
kernel/pci/emu10k1/emufx.c
There will be 2 ocurence. Change second to "Line2 LiveDrive Playback=20
Volume"

Do same thing for "Line LiveDrive Capture Volume" -> "Line2 LiveDrive=20
Capture Volume"
and for
"Line LiveDrive Capture Switch" -> "Line2 LiveDrive Capture Switch"

Peter Zubaj
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0ANeobmedzen=FD r=FDchly pr=EDstup na internet =
u=BE od 666,- Sk mesa=E8ne!=0ANextra ADSLink. http://adsl.nextra.sk=0A


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
