From: "Dan Cyr" <rabidfly@hotmail.com>
Subject: Re: Patch: 1.0.13rc2 New pci id for Nvidia MCP61
Date: Sun, 24 Sep 2006 16:19:22 -0700
Message-ID: <BAY107-W62E1254AFFB7A7CA659CCC0270@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_5f364d55-6771-41be-8893-f8b6998286dd_"
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

--_5f364d55-6771-41be-8893-f8b6998286dd_
Content-Type: multipart/alternative;
	boundary="_c90d8168-2d5c-43ca-95ea-d3f2d4202a4e_"

--_c90d8168-2d5c-43ca-95ea-d3f2d4202a4e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20
I haven't sent a formatted message from hotmail in quite some time. I had n=
o idea the message I sent would have been so unformatted. Anyway, this time=
 I have attached a copy of the patch. Also, I forgot to mention the driver =
is hda_intel, though the patch shows this of course. :-)
=20
Thanks.
=20
Dan
=20
=20
=20
Re: Patch: 1.0.13rc2 New pci id for Nvidia MCP61
 Please cc if replying as I'm not on this list.   Card Type: Onboard Mother=
board Manufacturer: Asrock Motherboard Model: AM2NF6G-VSTA Chipset: Nvidia =
MCP61 LSPCI Info: 00:05.0 Audio device: nVidia Corporation Unknown device 0=
3f0 (rev a2) Alsa Version: 1.0.13rc2 Patch Info:  Works for me!   This does=
n't require a kernel level pci_ids.h patch. Just apply the patch below to a=
lsa,configure, make, etc and modprobe.
diff -ruN alsa-driver-1.0.13rc2.orig/alsa-kernel/pci/hda/hda_intel.c alsa-d=
river-1.0.13rc2/alsa-kernel/pci/hda/hda_intel.c
--- alsa-driver-1.0.13rc2.orig/alsa-kernel/pci/hda/hda_intel.c     2006-09-=
12 06:40:56.000000000 -0700
+++ alsa-driver-1.0.13rc2/alsa-kernel/pci/hda/hda_intel.c         2006-09-2=
4 10:43:37.000000000 -0700
@@ -1684,6 +1684,7 @@
            { 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI =
}, /* ULI M5461 */
            { 0x10de, 0x026c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVID=
IA }, /* NVIDIA 026c */
            { 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVID=
IA }, /* NVIDIA 0371 */
+          { 0x10de, 0x03f0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDI=
A }, /* NVIDIA 03f0 */
            { 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);

  Dan Cyr=FCber Linux geek, A+, Network+, i-Net+ Certified Professional "Th=
e grand essentials of happiness: something to do, something to love, someth=
ing to hope for." =

--_c90d8168-2d5c-43ca-95ea-d3f2d4202a4e_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>=0A=
<head>=0A=
<style>=0A=
P=0A=
{=0A=
margin:0px;=0A=
padding:0px=0A=
}=0A=
body=0A=
{=0A=
FONT-SIZE: 10pt;=0A=
FONT-FAMILY:Tahoma=0A=
}=0A=
</style>=0A=
</head>=0A=
<body>&nbsp;<BR>
I haven't sent a formatted message from hotmail in quite some time. I had n=
o idea the message I sent would have been so unformatted. Anyway, this time=
 I have attached a copy of the patch. Also, I forgot to mention the driver =
is hda_intel, though the patch shows this of course. :-)<BR>
&nbsp;<BR>
Thanks.<BR>
&nbsp;<BR>
Dan<BR>
&nbsp;<BR>
&nbsp;<BR>
&nbsp;<BR>
Re: Patch: 1.0.13rc2 New pci id for Nvidia MCP61<BR>
&nbsp;Please cc if replying as I'm not on this list.<BR>&nbsp; <BR> Card Ty=
pe: Onboard<BR> Motherboard Manufacturer: Asrock<BR> Motherboard Model: AM2=
NF6G-VSTA<BR> Chipset: Nvidia MCP61<BR> LSPCI Info: 00:05.0 Audio device: n=
Vidia Corporation Unknown device 03f0 (rev a2)<BR> Alsa Version: 1.0.13rc2<=
BR> Patch Info:&nbsp; Works for me!<BR>&nbsp; <BR> This doesn't require a k=
ernel level <FONT><FONT>pci_ids.h</FONT></FONT> patch. Just apply the patch=
 below to alsa,<BR>configure, make, etc and modprobe.<BR><BR>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman">diff -ruN alsa-driver-<FONT>1.0=
.13rc2.orig</FONT>/alsa-kernel/pci/hda/<FONT>hda_intel.c</FONT> alsa-driver=
-1.0.13rc2/alsa-kernel/pci/hda/<FONT>hda_intel.c<?xml:namespace prefix =3D =
o ns =3D "urn:schemas-microsoft-com:office:office" /><o:p></o:p></FONT></FO=
NT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman">--- alsa-driver-<FONT>1.0.13rc2=
.orig</FONT>/alsa-kernel/pci/hda/<FONT>hda_intel.c</FONT><SPAN style=3D"mso=
-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>2006-09-12 06:40:56.00000000=
0 -0700<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman">+++ alsa-driver-1.0.13rc2/alsa-=
kernel/pci/hda/<FONT>hda_intel.c</FONT><SPAN style=3D"mso-tab-count: 1">&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>2006-09-24 10:43:37.00=
0000000 -0700<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman">@@ -1684,6 +1684,7 @@<o:p></o:p=
></FONT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: ye=
s">&nbsp;</SPAN><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>{ 0x10b9, 0x5461, <FONT>PCI_ANY_I=
D</FONT>, <FONT>PCI_ANY_ID</FONT>, 0, 0, AZX_DRIVER_<FONT>ULI</FONT> }, /* =
ULI M5461 */<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: ye=
s">&nbsp;</SPAN><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>{ 0x10de, 0x026c, <FONT>PCI_ANY_I=
D</FONT>, <FONT>PCI_ANY_ID</FONT>, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA 026=
c */<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: ye=
s">&nbsp;</SPAN><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>{ 0x10de, 0x0371, <FONT>PCI_ANY_I=
D</FONT>, <FONT>PCI_ANY_ID</FONT>, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA 037=
1 */<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman">+<SPAN style=3D"mso-tab-count: =
1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>{ 0x10de, =
0x03f0, <FONT>PCI_ANY_ID</FONT>, <FONT>PCI_ANY_ID</FONT>, 0, 0, AZX_DRIVER_=
NVIDIA }, /* NVIDIA 03f0 */<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: ye=
s">&nbsp;</SPAN><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>{ 0, }<o:p></o:p></FONT></FONT></=
FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: ye=
s">&nbsp;</SPAN>};<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT col=
or=3D#000000><FONT face=3D"Times New Roman"><SPAN style=3D"mso-spacerun: ye=
s">&nbsp;</SPAN>MODULE_DEVICE_TABLE(pci, azx_ids);</FONT></FONT></FONT></P>

<P>&nbsp; <BR><BR><BR>Dan Cyr<BR>=FCber Linux geek, A+, Network+, i-Net+ Ce=
rtified Professional<BR>&nbsp;<BR>"The grand essentials of happiness: somet=
hing to do, something to love, something to hope for."<BR>&nbsp;<BR><BR><BR=
></P></body>=0A=
</html>=

--_c90d8168-2d5c-43ca-95ea-d3f2d4202a4e_--

--_5f364d55-6771-41be-8893-f8b6998286dd_
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-driver-newid.patch"

ZGlmZiAtcnVOIGFsc2EtZHJpdmVyLTEuMC4xM3JjMi5vcmlnL2Fsc2Eta2VybmVsL3BjaS9oZGEv
aGRhX2ludGVsLmMgYWxzYS1kcml2ZXItMS4wLjEzcmMyL2Fsc2Eta2VybmVsL3BjaS9oZGEvaGRh
X2ludGVsLmMKLS0tIGFsc2EtZHJpdmVyLTEuMC4xM3JjMi5vcmlnL2Fsc2Eta2VybmVsL3BjaS9o
ZGEvaGRhX2ludGVsLmMJMjAwNi0wOS0xMiAwNjo0MDo1Ni4wMDAwMDAwMDAgLTA3MDAKKysrIGFs
c2EtZHJpdmVyLTEuMC4xM3JjMi9hbHNhLWtlcm5lbC9wY2kvaGRhL2hkYV9pbnRlbC5jCTIwMDYt
MDktMjQgMTA6NDM6MzcuMDAwMDAwMDAwIC0wNzAwCkBAIC0xNjg0LDYgKzE2ODQsNyBAQAogCXsg
MHgxMGI5LCAweDU0NjEsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIEFaWF9EUklWRVJf
VUxJIH0sIC8qIFVMSSBNNTQ2MSAqLwogCXsgMHgxMGRlLCAweDAyNmMsIFBDSV9BTllfSUQsIFBD
SV9BTllfSUQsIDAsIDAsIEFaWF9EUklWRVJfTlZJRElBIH0sIC8qIE5WSURJQSAwMjZjICovCiAJ
eyAweDEwZGUsIDB4MDM3MSwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgQVpYX0RSSVZF
Ul9OVklESUEgfSwgLyogTlZJRElBIDAzNzEgKi8KKwl7IDB4MTBkZSwgMHgwM2YwLCBQQ0lfQU5Z
X0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBBWlhfRFJJVkVSX05WSURJQSB9LCAvKiBOVklESUEgMDNm
MCAqLwogCXsgMCwgfQogfTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBhenhfaWRzKTsK

--_5f364d55-6771-41be-8893-f8b6998286dd_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--_5f364d55-6771-41be-8893-f8b6998286dd_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--_5f364d55-6771-41be-8893-f8b6998286dd_--
