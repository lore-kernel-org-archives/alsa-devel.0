From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: snd-hda-intel issues
Date: Thu, 01 Mar 2007 07:13:54 -0800
Message-ID: <1172762034.4789.416.camel@razman.gruemaster.com>
References: <45E6C45A.3090802@cs.tut.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bJPvK9yIm5l0glBOEtiY"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45E6C45A.3090802@cs.tut.fi>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lintula <bugreports2005@cs.tut.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-bJPvK9yIm5l0glBOEtiY
Content-Type: multipart/alternative; boundary="=-YpkPlCKHHHnWQxMwWuOW"


--=-YpkPlCKHHHnWQxMwWuOW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-03-01 at 14:17 +0200, Lintula wrote:

> Hello,
> 
> Using ALSA modules shipped with Linux 2.6.20, I find that with a HP
> dc7600 workstation I need to load snd-hda-intel with model=basic or
> model=hp or there is no sound. Alsamixer indicates Chip: Realtek ALC260.
> 
> 00:1b.0 0403: 8086:27d8 (rev 01)
>         Subsystem: 103c:3010
>         

This system is in the latest driver, 1.0.14rc3.


> Same with a Lenovo M55 8811, except I seem to need model=laptop.
> alsamixer indicates Chip: Analog Devices AD1986A.
> 
> 00:1b.0 0403: 8086:284b (rev 02)
>         Subsystem: 17aa:1011

Try this patch and report back if it works.

You can get alsa-driver-1.0.14rc3.tar.bz2 from
ftp://ftp.alsa-project.org/pub/testing/alsa-driver-1.0.14rc3.tar.bz2

If this patch works, then here's my summary in advance:

Summary:  Add support for Lenovo M55 Laptop
This patch adds support for the Lenovo M55 Laptop to the HDA drivers.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-YpkPlCKHHHnWQxMwWuOW
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
On Thu, 2007-03-01 at 14:17 +0200, Lintula wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hello,</FONT>

<FONT COLOR="#000000">Using ALSA modules shipped with Linux 2.6.20, I find that with a HP</FONT>
<FONT COLOR="#000000">dc7600 workstation I need to load snd-hda-intel with model=basic or</FONT>
<FONT COLOR="#000000">model=hp or there is no sound. Alsamixer indicates Chip: Realtek ALC260.</FONT>

<FONT COLOR="#000000">00:1b.0 0403: 8086:27d8 (rev 01)</FONT>
<FONT COLOR="#000000">        Subsystem: 103c:3010</FONT>
<FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
</PRE>
</BLOCKQUOTE>
This system is in the latest driver, 1.0.14rc3.<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Same with a Lenovo M55 8811, except I seem to need model=laptop.</FONT>
<FONT COLOR="#000000">alsamixer indicates Chip: Analog Devices AD1986A.</FONT>

<FONT COLOR="#000000">00:1b.0 0403: 8086:284b (rev 02)</FONT>
<FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 17</FONT>aa:1011
</PRE>
</BLOCKQUOTE>
Try this patch and report back if it works.<BR>
<BR>
You can get alsa-driver-1.0.14rc3.tar.bz2 from <A HREF="ftp://ftp.alsa-project.org/pub/testing/alsa-driver-1.0.14rc3.tar.bz2">ftp://ftp.alsa-project.org/pub/testing/alsa-driver-1.0.14rc3.tar.bz2</A><BR>
<BR>
If this patch works, then here's my summary in advance:<BR>
<BR>
Summary:&nbsp; Add support for Lenovo M55 Laptop<BR>
This patch adds support for the Lenovo M55 Laptop to the HDA drivers.<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
Signed off by Tobin Davis &lt;tdavis@dsl-only.net&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-YpkPlCKHHHnWQxMwWuOW--

--=-bJPvK9yIm5l0glBOEtiY
Content-Disposition: attachment; filename=Lenovo-M55.patch
Content-Type: text/x-patch; name=Lenovo-M55.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r bf193701a812 pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Mon Feb 26 16:07:42 2007 +0100
+++ b/pci/hda/patch_analog.c	Thu Mar 01 07:08:39 2007 -0800
@@ -839,6 +839,7 @@ static struct snd_pci_quirk ad1986a_cfg_
 	SND_PCI_QUIRK(0x144d, 0xc026, "Samsung X11", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x144d, 0xc504, "Samsung Q35", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x144d, 0xc027, "Samsung Q1", AD1986A_ULTRA),
+	SND_PCI_QUIRK(0x17aa, 0x1011, "Lenovo M55", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x17c0, 0x2017, "Samsung M50", AD1986A_LAPTOP),

--=-bJPvK9yIm5l0glBOEtiY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-bJPvK9yIm5l0glBOEtiY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-bJPvK9yIm5l0glBOEtiY--
