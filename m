From: "Paul Hanly \(Hotmail\)" <paulhanly@hotmail.com>
Subject: unresolved symbol snd_verbose_printk with alsa-driver-0.9.8 (also with 0.9.7c)
Date: Tue, 11 Nov 2003 13:47:49 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY2-DAV57PulSCKQvP00010290@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0035_01C3A85A.652D5AA0"
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

This is a multi-part message in MIME format.

------=_NextPart_000_0035_01C3A85A.652D5AA0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

unresolved symbol snd_verbose_printk with alsa-driver-0.9.8 (also with =
0.9.7c)

System Background:
My system is a recently installed Mandrake Linux 9.1 with kernel-sources =
installed.
I am trying ALSA to get sound from a Vortex au8820.
I am a noobie but posting here because this is where other messages =
about similar problems are in the archives.
I am happy to provide other info as requested, but will have some delays =
- I am trying Mandrake on a wintel 486 about 3 years old but with linux =
on a separate drive. I have lots of problems with unsupported devices =
such as camera, scanner, winmodem (trying Linuxant and can dial but not =
connect yet).

Issue Background:
After Reading and following
http://alsa.opensrc.org/index.php?page=3DQuick+Install+-+snd-au88x0
I had the following issues.=20

These issues have been exactly the same with alsa-driver-0.9.7c.tar.bz2 =
and alsa-driver-0.9.8 after patching as per the patch (a posting by Eric =
Hathaway) at:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/maillist.htm=
l#09813=20
which makes changes  to a file with Khexedit so it appears to have been =
compiled with gcc3 rather than 2 and adds several lines to various =
makefiles that seemed to be missing from the alsa drivers compared to =
the ones at Openvortex at Savannah.

Before doing the suggested patching there were other problems with =
unresolved symbols as per that page, but after the patching the only one =
left is .

[root@localhost alsa-utils-0.9.8]# modprobe snd-au8820;modprobe =
snd-pcm-oss;modprobe snd-mixer-oss; modprobe snd-seq-oss
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol =
snd_verbose_printk
modprobe: insmod /lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o =
failed
modprobe: insmod snd-au8820 failed
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol =
snd_verbose_printk
modprobe: insmod /lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o =
failed
modprobe: insmod snd-pcm-oss failed
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol =
snd_verbose_printk
modprobe: insmod /lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o =
failed
modprobe: insmod snd-mixer-oss failed
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol =
snd_verbose_printk
modprobe: insmod /lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o =
failed
modprobe: insmod snd-seq-oss failed
[root@localhost alsa-utils-0.9.8]#
I made sure the kernel-source was installed:

[root@localhost alsa-utils-0.9.8]# urpmi kernel-source
Everything already installed
[root@localhost alsa-utils-0.9.8]#

I note that there is another post in the user list with the same =
problem:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg09716.html=

but with no answers. I note he also uses Mandrake 9.1 as do I.

I could not find any resolution to this problem in a search of the =
archives, although I found four posts with the general issue of =
unresolved symbols that mentioned the same one, but among several =
others.

A www.google.com search for "unresolved symbol snd_verbose_printk" shows =
37 posts, so this appears not to be an isolated problem. From the search =
results it appears to have been an issue across distros and for a number =
of alsa-driver releases.

I would be most grateful if anyone can help.

Cheers
Paul
------=_NextPart_000_0035_01C3A85A.652D5AA0
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-1252">
<META content=3D"MSHTML 6.00.2800.1264" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>unresolved symbol snd_verbose_printk =
with=20
alsa-driver-0.9.8 (also with 0.9.7c)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>System Background:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>My system is a recently installed =
Mandrake Linux=20
9.1 with kernel-sources installed.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am trying ALSA to get&nbsp;sound from =

a&nbsp;Vortex au8820.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am a noobie but posting here because =
this is=20
where other messages about similar problems are in the =
archives.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am happy to provide other info as =
requested, but=20
will have some delays - I am trying Mandrake on a wintel 486 about 3 =
years old=20
but with linux on a separate drive. I have lots of problems with =
unsupported=20
devices such as camera, scanner, winmodem (trying Linuxant and can dial =
but not=20
connect yet).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Issue Background:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>After Reading and following<BR><A=20
href=3D"http://alsa.opensrc.org/index.php?page=3DQuick+Install+-+snd-au88=
x0">http://alsa.opensrc.org/index.php?page=3DQuick+Install+-+snd-au88x0</=
A><BR>I=20
had the following issues. </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>These issues have been exactly the same =
with=20
alsa-driver-0.9.7c.tar.bz2 and alsa-driver-0.9.8 after patching as per =
the patch=20
(a posting by Eric Hathaway) at:<BR><A=20
href=3D"http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/mail=
list.html#09813">http://www.mail-archive.com/alsa-devel@lists.sourceforge=
.net/maillist.html#09813</A>=20
<BR>which makes changes&nbsp; to a file with Khexedit so it appears to =
have been=20
compiled with gcc3 rather than 2 and adds several lines to various =
makefiles=20
that seemed to be missing from the alsa drivers compared to the ones at=20
Openvortex at Savannah.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Before doing the suggested patching =
there were=20
other problems with unresolved symbols as per that page, but after the =
patching=20
the only one left is .</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>[root@localhost alsa-utils-0.9.8]# =
modprobe=20
snd-au8820;modprobe snd-pcm-oss;modprobe snd-mixer-oss; modprobe=20
snd-seq-oss<BR>/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: =
unresolved=20
symbol snd_verbose_printk<BR>modprobe: insmod=20
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o failed<BR>modprobe: =
insmod=20
snd-au8820 =
failed<BR>/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o:=20
unresolved symbol snd_verbose_printk<BR>modprobe: insmod=20
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o failed<BR>modprobe: =
insmod=20
snd-pcm-oss =
failed<BR>/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o:=20
unresolved symbol snd_verbose_printk<BR>modprobe: insmod=20
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o failed<BR>modprobe: =
insmod=20
snd-mixer-oss =
failed<BR>/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o:=20
unresolved symbol snd_verbose_printk<BR>modprobe: insmod=20
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o failed<BR>modprobe: =
insmod=20
snd-seq-oss failed<BR>[root@localhost alsa-utils-0.9.8]#<BR>I made sure =
the=20
kernel-source was installed:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>[root@localhost alsa-utils-0.9.8]# =
urpmi=20
kernel-source<BR>Everything already installed<BR>[root@localhost=20
alsa-utils-0.9.8]#</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I note that there is another post in =
the user list=20
with the same problem:<BR><A=20
href=3D"http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg09=
716.html">http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg=
09716.html</A><BR>but=20
with no answers. I note he also uses Mandrake 9.1 as do I.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I could not find any resolution to this =
problem in=20
a search of the archives, although I found four posts with the general =
issue of=20
unresolved symbols that mentioned the same one, but among several=20
others.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>A <A=20
href=3D"http://www.google.com">www.google.com</A> search for "unresolved =
symbol=20
snd_verbose_printk" shows 37 posts, so this appears not to be an =
isolated=20
problem. From the search results it appears to have been an issue across =
distros=20
and for a number of alsa-driver releases.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I would be most grateful if anyone can=20
help.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Cheers</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>Paul</FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0035_01C3A85A.652D5AA0--


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
