From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: More questions on patch_sigmatel code
Date: Sat, 10 Mar 2007 20:59:19 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB5419485B46184@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0167656631=="
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

--===============0167656631==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7639A.07116140"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7639A.07116140
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Folks:
=20
I am still working my way on trying to understand the hda codecs,
particularly the sigmatel stuff.
=20
I notice that for the stac 9200, the multiout structure is set in:
=20
------------------------------------------
        spec->multiout.max_channels =3D 2;
        spec->multiout.num_dacs =3D 1;
        spec->multiout.dac_nids =3D stac9200_dac_nids;
------------------------------------------
=20
But is it now completely set in the stac 9205 series; only the dac_nids
is set. the max_channels is not set and the num_dacs is not set. Can
anyone please help enlighten me as to why?
=20
Thanks
=20
Mark Allyn

------_=_NextPart_001_01C7639A.07116140
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2>Folks:</FONT></SPAN></DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial size=3D2>I am =
still working=20
my way on trying to understand the hda codecs, particularly the sigmatel =

stuff.</FONT></SPAN></DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial size=3D2>I =
notice that for=20
the stac 9200, the multiout structure is set in:</FONT></SPAN></DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2>------------------------------------------</FONT></SPAN></DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spec-&gt;multiout.max_channels=20
=3D 2;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spec-&gt;multiout.num_dacs =3D=20
1;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spec-&gt;multiout.dac_nids =3D=20
stac9200_dac_nids;<BR>------------------------------------------</FONT></=
SPAN></DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial size=3D2>But is =
it now=20
completely set in the stac 9205 series; only the dac_nids is set. the=20
max_channels is not set and the num_dacs is not set. Can anyone please =
help=20
enlighten me as to why?</FONT></SPAN></DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2>Thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D567455604-11032007><FONT face=3DArial size=3D2>Mark=20
Allyn</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C7639A.07116140--


--===============0167656631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0167656631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0167656631==--
