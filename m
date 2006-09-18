From: "CV-jjhuang" <jjhuang@cybervision.com.tw>
Subject: [PATCH] bt87x interrupt disable fix
Date: Mon, 18 Sep 2006 18:33:57 +0800
Message-ID: <005e01c6db0d$f33c4930$687ba8c0@cybervision.cv.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0144279912=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

--===============0144279912==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_005B_01C6DB51.00593CC0"

This is a multi-part message in MIME format.

------=_NextPart_000_005B_01C6DB51.00593CC0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable


In my experiment, sometimes, the bt878 will not send interrupt to =
interrupt controller after something happened.
(It appeared easily when bt878 shared IRQ with many other drivers)

I found there is something error in the interrupt handler of alsa-bt87x.
so, I wrote an patch for it.
(Ref : In the Bt878/879 document, section of interrupt status register =
says that " To clear the interrupts, read this register, then write the =
same data back.")

jjhuang

--- alsa-driver-1.0.11/alsa-kernel/pci/bt87x.c 2006-03-13 =
18:36:44.000000000 +0800
+++ alsa-driver-1.0.11-fix-bug/alsa-kernel/pci/bt87x.c 2006-09-18 =
17:44:43.000000000 +0800
@@ -277,7 +277,10 @@
  status =3D snd_bt87x_readl(chip, REG_INT_STAT);
  irq_status =3D status & chip->interrupt_mask;
  if (!irq_status)
-  return IRQ_NONE;
+          {
+            snd_bt87x_writel (chip, REG_INT_STAT, status);
+            return IRQ_NONE;
+          }
  snd_bt87x_writel(chip, REG_INT_STAT, irq_status);
=20
  if (irq_status & ERROR_INTERRUPTS) {



------=_NextPart_000_005B_01C6DB51.00593CC0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>In my experiment, sometimes, the bt878 will not send =
interrupt=20
to interrupt controller after something happened.</FONT></DIV>
<DIV><FONT size=3D2>(It appeared easily when bt878 shared IRQ with many =
other=20
drivers)</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>I found there is something error in the interrupt =
handler of=20
alsa-bt87x.</FONT></DIV>
<DIV><FONT size=3D2>so, I wrote an patch for it.</FONT></DIV>
<DIV><FONT size=3D2>(Ref : <FONT size=3D2>In the Bt878/879 document, =
section of=20
interrupt status register says that " To clear the interrupts, read this =

register, then write the same data back.")</FONT></FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>
<DIV><FONT size=3D2>jjhuang</DIV></FONT></FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>--- =
alsa-driver-1.0.11/alsa-kernel/pci/bt87x.c&nbsp;2006-03-13=20
18:36:44.000000000 +0800<BR>+++=20
alsa-driver-1.0.11-fix-bug/alsa-kernel/pci/bt87x.c&nbsp;2006-09-18=20
17:44:43.000000000 +0800<BR>@@ -277,7 +277,10 @@<BR>&nbsp;&nbsp;status =
=3D=20
snd_bt87x_readl(chip, REG_INT_STAT);<BR>&nbsp;&nbsp;irq_status =3D =
status &amp;=20
chip-&gt;interrupt_mask;<BR>&nbsp;&nbsp;if =
(!irq_status)<BR>-&nbsp;&nbsp;return=20
IRQ_NONE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
{<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

snd_bt87x_writel (chip, REG_INT_STAT,=20
status);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
return =
IRQ_NONE;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
}<BR>&nbsp;&nbsp;snd_bt87x_writel(chip, REG_INT_STAT,=20
irq_status);<BR>&nbsp;<BR>&nbsp;&nbsp;if (irq_status &amp; =
ERROR_INTERRUPTS)=20
{<BR></FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;</DIV></FONT></BODY></HTML>

------=_NextPart_000_005B_01C6DB51.00593CC0--



--===============0144279912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0144279912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0144279912==--
