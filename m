From: "Dan Cyr" <rabidfly@hotmail.com>
Subject: Patch: 1.0.13rc2 New pci id for Nvidia MCP61
Date: Sun, 24 Sep 2006 10:56:03 -0700
Message-ID: <BAY107-W743A12F5A5032BE1CCC3EC0270@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0880263981=="
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

--===============0880263981==
Content-Type: multipart/alternative;
	boundary="_682b497b-b73f-43d4-b866-f16b50d8c501_"

--_682b497b-b73f-43d4-b866-f16b50d8c501_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Please cc if replying as I'm not on this list.
=20
Card Type: Onboard
Motherboard Manufacturer: Asrock
Motherboard Model: AM2NF6G-VSTA
Chipset: Nvidia MCP61
LSPCI Info: 00:05.0 Audio device: nVidia Corporation Unknown device 03f0 (r=
ev a2)
Alsa Version: 1.0.13rc2
Patch Info:  Works for me!
=20
This doesn't require a kernel level pci_ids.h patch. Just apply the patch b=
elow to alsa, configure, make, etc and modprobe.
=20
=20
diff -ruN alsa-driver-1.0.13rc2.orig/alsa-kernel/pci/hda/hda_intel.c alsa-d=
river-1.0.13rc2/alsa-kernel/pci/hda/hda_intel.c--- alsa-driver-1.0.13rc2.or=
ig/alsa-kernel/pci/hda/hda_intel.c  2006-09-12 06:40:56.000000000 -0700+++ =
alsa-driver-1.0.13rc2/alsa-kernel/pci/hda/hda_intel.c       2006-09-24 10:4=
3:37.000000000 -0700@@ -1684,6 +1684,7 @@        { 0x10b9, 0x5461, PCI_ANY_=
ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI }, /* ULI M5461 */        { 0x10de, 0x=
026c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA 026c */ =
       { 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_NVIDIA },=
 /* NVIDIA 0371 */+       { 0x10de, 0x03f0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, A=
ZX_DRIVER_NVIDIA }, /* NVIDIA 03f0 */        { 0, } }; MODULE_DEVICE_TABLE(=
pci, azx_ids);
=20
=20
Thanks!Dan Cyr=FCber Linux geek, A+, Network+, i-Net+ Certified Professiona=
l"The grand essentials of happiness: something to do, something to love, so=
mething to hope for."=

--_682b497b-b73f-43d4-b866-f16b50d8c501_
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
<body>Please cc if replying as I'm not on this list.<BR>
&nbsp;<BR>
Card Type: Onboard<BR>
Motherboard Manufacturer: Asrock<BR>
Motherboard Model: AM2NF6G-VSTA<BR>
Chipset: Nvidia MCP61<BR>
LSPCI Info: 00:05.0 Audio device: nVidia Corporation Unknown device 03f0 (r=
ev a2)<BR>
Alsa Version: 1.0.13rc2<BR>
Patch Info:&nbsp; Works for me!<BR>
&nbsp;<BR>
This doesn't require a kernel level pci_ids.h patch. Just apply the patch b=
elow to alsa, configure, make, etc and modprobe.<BR>
&nbsp;<BR>
&nbsp;<BR>
diff -ruN alsa-driver-<FONT><FONT>1.0.13rc2.orig</FONT></FONT>/alsa-kernel/=
pci/hda/<FONT><FONT>hda_intel.c</FONT></FONT> alsa-driver-1.0.13rc2/alsa-ke=
rnel/pci/hda/<FONT><FONT>hda_intel.c</FONT></FONT><BR>--- alsa-driver-<FONT=
><FONT>1.0.13rc2.orig</FONT></FONT>/alsa-kernel/pci/hda/<FONT><FONT>hda_int=
el.c</FONT></FONT>&nbsp; 2006-09-12 06:40:56.000000000 -0700<BR>+++ alsa-dr=
iver-1.0.13rc2/alsa-kernel/pci/hda/<FONT><FONT>hda_intel.c</FONT></FONT>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-09-24 10:43:37.000000000 -0700<BR>@@=
 -1684,6 +1684,7 @@<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10b9,=
 0x5461, <FONT><FONT>PCI_ANY_ID</FONT></FONT>, <FONT><FONT>PCI_ANY_ID</FONT=
></FONT>, 0, 0, <FONT>AZX_DRIVER_<FONT>ULI</FONT></FONT> }, /* ULI M5461 */=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x026c, <FONT><FON=
T>PCI_ANY_ID</FONT></FONT>, <FONT><FONT>PCI_ANY_ID</FONT></FONT>, 0, 0, AZX=
_DRIVER_NVIDIA }, /* NVIDIA 026c */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; { 0x10de, 0x0371, <FONT><FONT>PCI_ANY_ID</FONT></FONT>, <FONT><FONT>=
PCI_ANY_ID</FONT></FONT>, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA 0371 */<BR>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x03f0, <FONT><FONT>PCI_ANY_=
ID</FONT></FONT>, <FONT><FONT>PCI_ANY_ID</FONT></FONT>, 0, 0, AZX_DRIVER_NV=
IDIA }, /* NVIDIA 03f0 */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0=
, }<BR>&nbsp;};<BR>&nbsp;MODULE_DEVICE_TABLE(pci, azx_ids);<BR>
&nbsp;<BR>
&nbsp;<BR>
Thanks!<BR><BR><BR>Dan&nbsp;Cyr<BR>=FCber&nbsp;Linux&nbsp;geek,&nbsp;A+,&nb=
sp;Network+,&nbsp;i-Net+&nbsp;Certified&nbsp;Professional<BR><BR>"The&nbsp;=
grand&nbsp;essentials&nbsp;of&nbsp;happiness:&nbsp;something&nbsp;to&nbsp;d=
o,&nbsp;something&nbsp;to&nbsp;love,&nbsp;something&nbsp;to&nbsp;hope&nbsp;=
for."<BR><BR></body>=0A=
</html>=

--_682b497b-b73f-43d4-b866-f16b50d8c501_--


--===============0880263981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0880263981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0880263981==--
