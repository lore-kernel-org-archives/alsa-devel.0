From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Problems compiling alsa-driver-1.0.14rc3 and Mercury
	driver
Date: Thu, 1 Mar 2007 11:56:38 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB5419485A64708@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1363841499=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============1363841499==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75C3B.B99A6D56"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75C3B.B99A6D56
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi:
=20
I am getting the same error trying to compile either the 1.0.14rc3 or
the Mercury versions of the driver.
=20
I get the following in both:
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
  CC [M]  /root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.o
In file included from
/root/newaudio/alsa-driver-1.0.14rc3/include/linux/log2.h:1,
                 from
/root/newaudio/alsa-driver-1.0.14rc3/acore/../alsa-kernel/core/rtctimer.
c:27,
                 from
/root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.c:1:
/root/newaudio/alsa-driver-1.0.14rc3/include/log2_compat.h:8: error:
syntax error before "is_power_of_2"
/root/newaudio/alsa-driver-1.0.14rc3/include/log2_compat.h:9: warning:
return type defaults to `int'
make[4]: *** [/root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.o]
Error 1
make[3]: *** [/root/newaudio/alsa-driver-1.0.14rc3/acore] Error 2
make[2]: *** [_module_/root/newaudio/alsa-driver-1.0.14rc3] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/mnt1/src/linux-2.6.17.13.i686'
make: *** [compile] Error 2

=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
The header file, log2_compat.h is not in the rc2 release; I have no
problems compiling rc2.
=20
Does this mean that I have to be up to a certain rev on the kernel?
=20
I am running red flag with the 2.6.17.13 kernel.
=20
Thanks
=20
Mark Allyn

------_=_NextPart_001_01C75C3B.B99A6D56
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2>Hi:</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial size=3D2>I am =
getting the=20
same error trying to compile either the 1.0.14rc3 or the Mercury =
versions of the=20
driver.</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial size=3D2>I get =
the following=20
in both:</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial size=3D2>&nbsp; =
CC [M]&nbsp;=20
/root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.o<BR>In file =
included from=20
/root/newaudio/alsa-driver-1.0.14rc3/include/linux/log2.h:1,<BR>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=20
from=20
/root/newaudio/alsa-driver-1.0.14rc3/acore/../alsa-kernel/core/rtctimer.c=
:27,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
/root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.c:1:<BR>/root/newaudi=
o/alsa-driver-1.0.14rc3/include/log2_compat.h:8:=20
error: syntax error before=20
"is_power_of_2"<BR>/root/newaudio/alsa-driver-1.0.14rc3/include/log2_comp=
at.h:9:=20
warning: return type defaults to `int'<BR>make[4]: ***=20
[/root/newaudio/alsa-driver-1.0.14rc3/acore/rtctimer.o] Error =
1<BR>make[3]: ***=20
[/root/newaudio/alsa-driver-1.0.14rc3/acore] Error 2<BR>make[2]: ***=20
[_module_/root/newaudio/alsa-driver-1.0.14rc3] Error 2<BR>make[1]: *** =
[modules]=20
Error 2<BR>make[1]: Leaving directory =
`/mnt1/src/linux-2.6.17.13.i686'<BR>make:=20
*** [compile] Error 2<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial size=3D2>The =
header file,=20
log2_compat.h is not in the rc2 release; I have no problems compiling=20
rc2.</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial size=3D2>Does =
this mean that=20
I have to be up to a certain rev on the kernel?</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial size=3D2>I am =
running red=20
flag with the 2.6.17.13 kernel.</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2>Thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D277545319-01032007><FONT face=3DArial size=3D2>Mark=20
Allyn</DIV></FONT></SPAN></BODY></HTML>

------_=_NextPart_001_01C75C3B.B99A6D56--


--===============1363841499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1363841499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1363841499==--
