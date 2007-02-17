From: "John Utz" <John.Utz@dmxmusic.com>
Subject: why would i *not* be able to update a register in
 ac97#0-0+regs when it's read write?
Date: Fri, 16 Feb 2007 17:08:13 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF896@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0055089547=="
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

--===============0055089547==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75230.190D2CC5"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75230.190D2CC5
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Hello;

I have debugging turned on (--with-debug=3Ddetect) and the file is =
listed as writable:

ls -l /proc/asound/card0/codec97#0/ac97#0-0+regs
-rw-r--r-- 1 root root 0 Feb 16 08:47 =
/proc/asound/card0/codec97#0/ac97#0-0+regs

but i get no joy in the file:

cat /proc/asound/card0/codec97#0/ac97#0-0+regs | grep 0:60
0:60 =3D 0000

echo 60 1 > /proc/asound/card0/codec97#0/ac97#0-0+regs
cat /proc/asound/card0/codec97#0/ac97#0-0+regs | grep 0:60
0:60 =3D 0000

the doc asserts that the register is rw:

Note that this is from the docs for the via vt1618

Vendor Defined Register (Page ID =3D 00h)
UAJ Control
Index: 60h                                                           =
Default Value: 0038h
    Bit     Attr. Description
   15:6      RO   Reserved
    5:4     RW    UAJ_2 (pin 21/22) Control
                  00: Reserved
                  01: Output from DAC_2 without analog mixing
                  10: Input as Line-In signal
                  11: Input as MIC1 & MIC2 signals (default)
    3:2     RW    UAJ_1 (pin 23/24) Control
                  00: Reserved
                  01: Output from DAC_1 without analog mixing
                  10: Input as Line-In signal (default)
                  11: Input as MIC1 & MIC2 signals
    1:0     RW    UAJ_0 (pin 35/36) Control
                  00: Output from DAC_0 with analog mixing (default)
                  01: Output from DAC_0 without analog mixing
                  10: Input as Line-In signal
                  11: Input as MIC1 & MIC2 signals


i believe that i want to set these to the 01 setting so that i can get =
surround out from Universal Audio Jacks on our MSI motherboard samples

am i barking up the wrong tree here?

tnx!

johnu

------_=_NextPart_001_01C75230.190D2CC5
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>why would i *not* be able to update a register in ac97#0-0+regs =
when it's read write?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hello;<BR>
<BR>
I have debugging turned on (--with-debug=3Ddetect) and the file is =
listed as writable:<BR>
<BR>
ls -l /proc/asound/card0/codec97#0/ac97#0-0+regs<BR>
-rw-r--r-- 1 root root 0 Feb 16 08:47 =
/proc/asound/card0/codec97#0/ac97#0-0+regs<BR>
<BR>
but i get no joy in the file:<BR>
<BR>
cat /proc/asound/card0/codec97#0/ac97#0-0+regs | grep 0:60<BR>
0:60 =3D 0000<BR>
<BR>
echo 60 1 &gt; /proc/asound/card0/codec97#0/ac97#0-0+regs<BR>
cat /proc/asound/card0/codec97#0/ac97#0-0+regs | grep 0:60<BR>
0:60 =3D 0000<BR>
<BR>
the doc asserts that the register is rw:<BR>
<BR>
Note that this is from the docs for the via vt1618<BR>
<BR>
Vendor Defined Register (Page ID =3D 00h)<BR>
UAJ Control<BR>
Index: =
60h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Default =
Value: 0038h<BR>
&nbsp;&nbsp;&nbsp; Bit&nbsp;&nbsp;&nbsp;&nbsp; Attr. Description<BR>
&nbsp;&nbsp; 15:6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RO&nbsp;&nbsp; =
Reserved<BR>
&nbsp;&nbsp;&nbsp; 5:4&nbsp;&nbsp;&nbsp;&nbsp; RW&nbsp;&nbsp;&nbsp; =
UAJ_2 (pin 21/22) Control<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00: Reserved<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01: Output from DAC_2 without analog =
mixing<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10: Input as Line-In signal<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11: Input as MIC1 &amp; MIC2 signals =
(default)<BR>
&nbsp;&nbsp;&nbsp; 3:2&nbsp;&nbsp;&nbsp;&nbsp; RW&nbsp;&nbsp;&nbsp; =
UAJ_1 (pin 23/24) Control<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00: Reserved<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01: Output from DAC_1 without analog =
mixing<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10: Input as Line-In signal (default)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11: Input as MIC1 &amp; MIC2 signals<BR>
&nbsp;&nbsp;&nbsp; 1:0&nbsp;&nbsp;&nbsp;&nbsp; RW&nbsp;&nbsp;&nbsp; =
UAJ_0 (pin 35/36) Control<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00: Output from DAC_0 with analog mixing =
(default)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01: Output from DAC_0 without analog =
mixing<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10: Input as Line-In signal<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11: Input as MIC1 &amp; MIC2 signals<BR>
<BR>
<BR>
i believe that i want to set these to the 01 setting so that i can get =
surround out from Universal Audio Jacks on our MSI motherboard =
samples<BR>
<BR>
am i barking up the wrong tree here?<BR>
<BR>
tnx!<BR>
<BR>
johnu</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75230.190D2CC5--



--===============0055089547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0055089547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0055089547==--
