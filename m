From: "SailajaReddy  K" <sailaja_reddi@rediffmail.com>
Subject: Re: Installed alsa (1.0.5)into 2.6.7 kernel:says nosoundcards
Date: 11 Aug 2004 04:49:43 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040811044943.5123.qmail@mailweb34.rediffmail.com>
Reply-To: "SailajaReddy  K" <sailaja_reddi@rediffmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="Next_1092199783---0-203.199.83.247-5119"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 This is a multipart mime message


--Next_1092199783---0-203.199.83.247-5119
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHi Clemens,<BR>=0A<BR>=0A&nbsp; Thanks for the reply.<BR>=0A&nbsp; Pl=
ease find my comments inline..<BR>=0ARegards,<BR>=0ASailaja<BR>=0A<BR>=0A&g=
t;Date: Tue, 10 Aug 2004 11:20:10 +0200 (METDST)<BR>=0A&gt; From: Clemens L=
adisch &lt;clemens@ladisch.de&gt;<BR>=0A&gt;Subject: Re: [Alsa-devel] Insta=
lled alsa (1.0.5)into 2.6.7 kernel:says<BR>=0A&gt;nosoundcards<BR>=0A&gt;To=
: alsa-devel@lists.sourceforge.net<BR>=0A&gt;SailajaReddy K wrote:<BR>=0A&g=
t; &gt; *I have installed alsa driver,lib, utilities successfully. But I<BR=
>=0A&gt; &gt; couldn't see any cards in my system. Please see below outputs=
:<BR>=0A&gt; &gt; **[root@aims-pc-100 alsa]# cat /proc/asound/cards<BR>=0A&=
gt; &gt; --- no soundcards ---<BR>=0A&gt; &gt; **[root@aims-pc-100 root]# l=
smod<BR>=0A&gt; &gt; Module Size Used by<BR>=0A&gt; &gt; snd_ice1712 65316 =
-<BR>=0A&gt; &gt;<BR>=0A&gt; &gt; What else I need to do and check to confi=
rm that ALSA is working<BR>=0A&gt; &gt; fine for my card &quot;ICE1712 - M =
Audio Delta 1010&quot;?<BR>=0A&gt;In theory, it should work with the snd-ic=
e1712 driver.<BR>=0A&gt;Is the card listed with lspci?<BR>=0ANope. The belo=
w is the output of lspci:<BR>=0A[root@aims-pc-100 alsa-utils-1.0.5]# lspci<=
BR>=0A00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host=
<BR>=0ABridge (rev 03)<BR>=0A00:01.0 PCI bridge: Intel Corp. 82845G/GL [Bro=
okdale-G] Chipset AGP<BR>=0ABridge (rev 03)<BR>=0A00:1d.0 USB Controller: I=
ntel Corp. 82801DB USB (Hub #1) (rev 02)<BR>=0A00:1d.1 USB Controller: Inte=
l Corp. 82801DB USB (Hub #2) (rev 02)<BR>=0A00:1d.2 USB Controller: Intel C=
orp. 82801DB USB (Hub #3) (rev 02)<BR>=0A00:1d.7 USB Controller: Intel Corp=
. 82801DB USB EHCI Controller (rev 02)<BR>=0A00:1e.0 PCI bridge: Intel Corp=
. 82801BA/CA/DB PCI Bridge (rev 82)<BR>=0A00:1f.0 ISA bridge: Intel Corp. 8=
2801DB ISA Bridge (LPC) (rev 02)<BR>=0A00:1f.1 IDE interface: Intel Corp. 8=
2801DB ICH4 IDE (rev 02)<BR>=0A00:1f.3 SMBus: Intel Corp. 82801DB SMBus (re=
v 02)<BR>=0A00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 =
Audio<BR>=0A(rev 02)<BR>=0A01:00.0 VGA compatible controller: nVidia Corpor=
ation NV18 [GeForce4 MX<BR>=0A440 AGP<BR>=0A8x] (rev c1)<BR>=0A02:05.0 Ethe=
rnet controller: Realtek Semiconductor Co., Ltd.<BR>=0ARTL-8139/8139C/8139<=
BR>=0AC+ (rev 10)<BR>=0A<BR>=0AHow do I come out of this problem?<BR>=0ASha=
ll I able to uninstall everything and install once again? Actually I<BR>=0A=
haven't selected removing the modules option at the time of kernel<BR>=0Aco=
nfiguration. In this case, how to unload the modules?<BR>=0AIf I can uninst=
all and install everything, what are the exact steps I<BR>=0Ashould follow?=
<BR>=0APlease help me out.<BR>=0A<BR>=0A&gt; &gt; Is reboot needed after mo=
difying the /etc/modules.conf file?<BR>=0A&gt;Not if you reload the drivers=
 manually.<BR>=0AI am a new user. Could you please tell me the meaning of r=
eloading<BR>=0Amanually?<BR>=0AIn my case I have installed alsa driver, lib=
, utils and modified the<BR>=0A/etc/modules.conf<BR>=0A<BR>=0A&gt; &gt; I r=
ead that all mixer channels are muted by default. How exactly<BR>=0A&gt; &g=
t; we should adjust the soundcards volume level?.<BR>=0A&gt;There is a spec=
ial tool for your card: envy24control in the alsa-tools<BR>=0A&gt;package.<=
BR>=0A<BR>=0AI haven't installed alsa-tools package. I will install and try=
 this.<BR>=0A<BR>=0A&gt;HTH<BR>=0A&gt;Clemens<BR>=0A&gt;[root@aims-pc-100 a=
lsa-utils-1.0.5]# lspci<BR>=0A&gt;00:00.0 Host bridge: Intel Corp. 82845G/G=
L [Brookdale-G] Chipset Host<BR>=0A&gt;Bridge (re<BR>=0A&gt;v 03)<BR>=0A&gt=
;00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP<BR>=0A=
&gt;Bridge (rev<BR>=0A&gt;03)<BR>=0A&gt;00:1d.0 USB Controller: Intel Corp.=
 82801DB USB (Hub #1) (rev 02)<BR>=0A&gt;00:1d.1 USB Controller: Intel Corp=
. 82801DB USB (Hub #2) (rev 02)<BR>=0A&gt;00:1d.2 USB Controller: Intel Cor=
p. 82801DB USB (Hub #3) (rev 02)<BR>=0A&gt;00:1d.7 USB Controller: Intel Co=
rp. 82801DB USB EHCI Controller (rev 02)<BR>=0A&gt;00:1e.0 PCI bridge: Inte=
l Corp. 82801BA/CA/DB PCI Bridge (rev 82)<BR>=0A&gt;00:1f.0 ISA bridge: Int=
el Corp. 82801DB ISA Bridge (LPC) (rev 02)<BR>=0A&gt;00:1f.1 IDE interface:=
 Intel Corp. 82801DB ICH4 IDE (rev 02)<BR>=0A&gt;00:1f.3 SMBus: Intel Corp.=
 82801DB SMBus (rev 02)<BR>=0A&gt;00:1f.5 Multimedia audio controller: Inte=
l Corp. 82801DB AC'97 Audio<BR>=0A&gt;(rev 02)<BR>=0A&gt;01:00.0 VGA compat=
ible controller: nVidia Corporation NV18 [GeForce4 MX<BR>=0A&gt;440 AGP<BR>=
=0A&gt;8x] (rev c1)<BR>=0A&gt;02:05.0 Ethernet controller: Realtek Semicond=
uctor Co., Ltd.<BR>=0A&gt;RTL-8139/8139C/8139<BR>=0A&gt;C+ (rev 10)<BR>=0A&=
gt;<BR>=0A&gt;<BR>=0A&gt;<BR>=0A&gt;<BR>=0A&gt;<BR>=0A&gt;Confidentiality N=
otice<BR>=0A&gt;<BR>=0A&gt;The information contained in this electronic mes=
sage and any attachments to this message are intended<BR>=0A&gt;for the exc=
lusive use of the addressee(s) and may contain confidential or privileged i=
nformation. If<BR>=0A&gt;you are not the intended recipient, please notify =
the sender at Wipro or Mailadmin@wipro.com immediately<BR>=0A&gt;and destro=
y all copies of this message and any attachments.<BR>=0A=0A</P>=0A<br><br>=
=0A<A target=3D"_blank" HREF=3D"http://clients.rediff.com/signature/track_s=
ig.asp"><IMG SRC=3D"http://ads.rediff.com/RealMedia/ads/adstream_nx.cgi/www=
.rediffmail.com/inbox.htm@Bottom" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1092199783---0-203.199.83.247-5119
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Clemens,=0A=0A  Thanks for the reply.=0A  Please find my comments inline=
..=0ARegards,=0ASailaja=0A=0A>Date: Tue, 10 Aug 2004 11:20:10 +0200 (METDST=
)=0A> From: Clemens Ladisch <clemens@ladisch.de>=0A>Subject: Re: [Alsa-deve=
l] Installed alsa (1.0.5)into 2.6.7 kernel:says=0A>nosoundcards=0A>To: alsa=
-devel@lists.sourceforge.net=0A>SailajaReddy K wrote:=0A> > *I have install=
ed alsa driver,lib, utilities successfully. But I=0A> > couldn't see any ca=
rds in my system. Please see below outputs:=0A> > **[root@aims-pc-100 alsa]=
# cat /proc/asound/cards=0A> > --- no soundcards ---=0A> > **[root@aims-pc-=
100 root]# lsmod=0A> > Module Size Used by=0A> > snd_ice1712 65316 -=0A> >=
=0A> > What else I need to do and check to confirm that ALSA is working=0A>=
 > fine for my card "ICE1712 - M Audio Delta 1010"?=0A>In theory, it should=
 work with the snd-ice1712 driver.=0A>Is the card listed with lspci?=0ANope=
. The below is the output of lspci:=0A[root@aims-pc-100 alsa-utils-1.0.5]# =
lspci=0A00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Ho=
st=0ABridge (rev 03)=0A00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale=
-G] Chipset AGP=0ABridge (rev 03)=0A00:1d.0 USB Controller: Intel Corp. 828=
01DB USB (Hub #1) (rev 02)=0A00:1d.1 USB Controller: Intel Corp. 82801DB US=
B (Hub #2) (rev 02)=0A00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub =
#3) (rev 02)=0A00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Control=
ler (rev 02)=0A00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (re=
v 82)=0A00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)=
=0A00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)=0A00:1f.3 S=
MBus: Intel Corp. 82801DB SMBus (rev 02)=0A00:1f.5 Multimedia audio control=
ler: Intel Corp. 82801DB AC'97 Audio=0A(rev 02)=0A01:00.0 VGA compatible co=
ntroller: nVidia Corporation NV18 [GeForce4 MX=0A440 AGP=0A8x] (rev c1)=0A0=
2:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=0ARTL-8139/8139=
C/8139=0AC+ (rev 10)=0A=0AHow do I come out of this problem?=0AShall I able=
 to uninstall everything and install once again? Actually I=0Ahaven't selec=
ted removing the modules option at the time of kernel=0Aconfiguration. In t=
his case, how to unload the modules?=0AIf I can uninstall and install every=
thing, what are the exact steps I=0Ashould follow?=0APlease help me out.=0A=
=0A> > Is reboot needed after modifying the /etc/modules.conf file?=0A>Not =
if you reload the drivers manually.=0AI am a new user. Could you please tel=
l me the meaning of reloading=0Amanually?=0AIn my case I have installed als=
a driver, lib, utils and modified the=0A/etc/modules.conf=0A=0A> > I read t=
hat all mixer channels are muted by default. How exactly=0A> > we should ad=
just the soundcards volume level?.=0A>There is a special tool for your card=
: envy24control in the alsa-tools=0A>package.=0A=0AI haven't installed alsa=
-tools package. I will install and try this.=0A=0A>HTH=0A>Clemens=0A>[root@=
aims-pc-100 alsa-utils-1.0.5]# lspci=0A>00:00.0 Host bridge: Intel Corp. 82=
845G/GL [Brookdale-G] Chipset Host=0A>Bridge (re=0A>v 03)=0A>00:01.0 PCI br=
idge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP=0A>Bridge (rev=0A>03)=
=0A>00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)=0A>00=
:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)=0A>00:1d.2 =
USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)=0A>00:1d.7 USB Co=
ntroller: Intel Corp. 82801DB USB EHCI Controller (rev 02)=0A>00:1e.0 PCI b=
ridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)=0A>00:1f.0 ISA bridge:=
 Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)=0A>00:1f.1 IDE interface: In=
tel Corp. 82801DB ICH4 IDE (rev 02)=0A>00:1f.3 SMBus: Intel Corp. 82801DB S=
MBus (rev 02)=0A>00:1f.5 Multimedia audio controller: Intel Corp. 82801DB A=
C'97 Audio=0A>(rev 02)=0A>01:00.0 VGA compatible controller: nVidia Corpora=
tion NV18 [GeForce4 MX=0A>440 AGP=0A>8x] (rev c1)=0A>02:05.0 Ethernet contr=
oller: Realtek Semiconductor Co., Ltd.=0A>RTL-8139/8139C/8139=0A>C+ (rev 10=
)=0A>=0A>=0A>=0A>=0A>=0A>Confidentiality Notice=0A>=0A>The information cont=
ained in this electronic message and any attachments to this message are in=
tended=0A>for the exclusive use of the addressee(s) and may contain confide=
ntial or privileged information. If=0A>you are not the intended recipient, =
please notify the sender at Wipro or Mailadmin@wipro.com immediately=0A>and=
 destroy all copies of this message and any attachments.=0A
--Next_1092199783---0-203.199.83.247-5119--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
