From: "Frank H." <frankcch@comcast.net>
Subject: unresolved symbol in "insmod snd-ens1371"
Date: Sun, 12 Oct 2003 00:54:19 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002401c39096$0ac3bcc0$987ba8c0@Vectra>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0021_01C3905B.5E371E00"
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

------=_NextPart_000_0021_01C3905B.5E371E00
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi,

I have Linux PC with
OS: linux 9.0
sound card: Create Lab Sound blaster 16 PCI.
PC: Compaq Presario
Alsa driver: 0.9.7.a

Why there so many unresolved synbol when load the snd-ens1371
("insmod snd-ens1371")?
Is there any mistakes during image buit?

I follow the procedures in this link

http://www.alsa-project.org/alsa-doc/doc-php/template.php3?company=3DCrea=
tive+Labs&card=3DSoundblaster+16+PCI&chip=3DES1373&module=3Dens1371

form  http://www.alsa-project.org/,




[root@localhost frank1]# insmod snd-ens1371

Using /lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_rawmidi_set_ops_Rd25736d5

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_lib_free_pages_R63496766

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_lib_ioctl_Rfa679c62

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_hw_constraint_ratnums_R79085f70

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_rawmidi_new_R99049e31

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_ac97_mixer_R42360e08

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_format_width_R55eb2175

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_period_elapsed_R504649e6

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_rawmidi_receive_R750242b3

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_lib_preallocate_pci_pages_for_all_R352c8889

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_set_sync_R3ad37b1f

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_rawmidi_transmit_R2a9ff179

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_hw_constraint_ratdens_Rccbd7c18

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_lib_preallocate_free_for_all_Rafd116e4

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_lib_malloc_pages_Re8d87c95

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_set_ops_R6eed08d7

/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o:=20
unresolved symbol snd_pcm_new_Rdb8900cc

------=_NextPart_000_0021_01C3905B.5E371E00
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1226" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have Linux PC with</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>OS: linux 9.0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>sound card: Create Lab Sound blaster 16 =

PCI.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PC: Compaq Presario</FONT></DIV>
<DIV>Alsa driver: 0.9.7.a</DIV>
<DIV>&nbsp;</DIV></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Why there so many unresolved synbol =
when load the=20
snd-ens1371</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>("insmod snd-ens1371")?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Is there any&nbsp;mistakes during image =

buit?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I follow the procedures in this =
link</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.alsa-project.org/alsa-doc/doc-php/template.php3?compan=
y=3DCreative+Labs&amp;card=3DSoundblaster+16+PCI&amp;chip=3DES1373&amp;mo=
dule=3Dens1371">http://www.alsa-project.org/alsa-doc/doc-php/template.php=
3?company=3DCreative+Labs&amp;card=3DSoundblaster+16+PCI&amp;chip=3DES137=
3&amp;module=3Dens1371</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>form&nbsp; <A=20
href=3D"http://www.alsa-project.org/">http://www.alsa-project.org/</A>,</=
FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>[root@localhost frank1]# insmod=20
snd-ens1371</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Using=20
/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_rawmidi_set_ops_Rd25736d5</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_lib_free_pages_R63496766</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_lib_ioctl_Rfa679c62</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_hw_constraint_ratnums_R79085f70</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_rawmidi_new_R99049e31</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_ac97_mixer_R42360e08</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_format_width_R55eb2175</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_period_elapsed_R504649e6</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_rawmidi_receive_R750242b3</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_lib_preallocate_pci_pages_for_all_R352c8889</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_set_sync_R3ad37b1f</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_rawmidi_transmit_R2a9ff179</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_hw_constraint_ratdens_Rccbd7c18</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_lib_preallocate_free_for_all_Rafd116e4</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_lib_malloc_pages_Re8d87c95</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_set_ops_R6eed08d7</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/lib/modules/2.4.20-6/kernel/sound/pci/snd-ens1371.o: =
<BR>unresolved=20
symbol snd_pcm_new_Rdb8900cc</FONT></DIV>
<DIV>&nbsp;</DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0021_01C3905B.5E371E00--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
