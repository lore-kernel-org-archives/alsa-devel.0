From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: using preallocate pci, isa or nothing?
Date: Fri, 6 Feb 2004 20:45:33 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <006d01c3ed24$75653b40$c4f9cb18@win2K>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_006A_01C3ECF2.2A709D50"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_006A_01C3ECF2.2A709D50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm writing an ALSA driver for a CSB337 board (AT91RM9200). There is no =
PCI or ISA on this board. Should I preallocate memory with: =
snd_pcm_lib_preallocate_pages_for_all, =
snd_pcm_lib_preallocate_isa_pages_for_all() or =
snd_pcm_lib_preallocate_pci_pages_for_all()?

There is a specific DMA (PDC) on the AT91RM9200, so i'm trying to use =
snd_pcm_lib_preallocate_pages_for_all() but seems complicated to =
understand what is needed by the ALSA pcm and what i have to write.
What does the function snd_..._pointer() mean? should i need it if i =
don't use ISA or PCI mecanism?
What does the function snd_pcm_period_elapsed() mean? Should i need it =
if i don't use ISA or PCI mecanism?

Thanks
any help would be very appreciate.

Mathieu Rondonneau
------=_NextPart_000_006A_01C3ECF2.2A709D50
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hi all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm writing&nbsp;an ALSA driver for a =
CSB337 board=20
(AT91RM9200). There is no PCI or ISA on this board. Should I preallocate =
memory=20
with: </FONT><FONT face=3DArial =
size=3D2>snd_pcm_lib_preallocate_pages_for_all,=20
snd_pcm_lib_preallocate_isa_pages_for_all() or=20
snd_pcm_lib_preallocate_pci_pages_for_all()?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>There is a specific DMA (PDC) on the =
AT91RM9200, so=20
i'm trying to use snd_pcm_lib_preallocate_pages_for_all() but seems =
complicated=20
to understand what is needed by the ALSA pcm and what i have to=20
write.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>What does the function =
snd_..._pointer() mean?=20
should i need it if i don't use ISA or PCI mecanism?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>What does the function =
snd_pcm_period_elapsed()=20
mean? Should i need it if i don't use ISA or PCI mecanism?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>any help would be very =
appreciate.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Mathieu=20
Rondonneau</FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_006A_01C3ECF2.2A709D50--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
