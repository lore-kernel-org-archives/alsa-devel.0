From: "SailajaReddy  K" <sailaja_reddi@rediffmail.com>
Subject: Re: Re: Installed alsa (1.0.5)into 2.6.7 kernel:says nosoundcards
Date: 10 Aug 2004 13:36:03 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040810133603.11522.qmail@mailweb34.rediffmail.com>
Reply-To: "SailajaReddy  K" <sailaja_reddi@rediffmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="Next_1092144963---0-203.199.83.247-11515"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net, sailaja.reddy@wipro.com
List-Id: alsa-devel@alsa-project.org

 This is a multipart mime message


--Next_1092144963---0-203.199.83.247-11515
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AOn Tue, 10 Aug 2004 Giuliano Pochini wrote :<BR>=0A&gt;On 10 Aug 2004=
 06:56:28 -0000<BR>=0A&gt;&quot;SailajaReddy&nbsp; K&quot; &lt;sailaja_redd=
i@rediffmail.com&gt; wrote:<BR>=0A&gt;<BR>=0A&gt; &gt; *I have installed al=
sa driver,lib, utilities successfully. But I couldn't see any cards in my s=
ystem.&nbsp; Please see below outputs:<BR>=0A&gt;<BR>=0A&gt;Did you check i=
f there is something useful in the logs ?<BR>=0AWhich logs I should check? =
Please suggest.<BR>=0A<BR>=0AThanks,<BR>=0ASailaja<BR>=0A&gt;<BR>=0A&gt;<BR=
>=0A&gt;--<BR>=0A&gt;Giuliano.<BR>=0AHi,.<BR>=0A*I have installed alsa driv=
er,lib, utilities successfully. But I couldn't see any cards in my system.&=
nbsp; Please see below outputs:<BR>=0A&nbsp; **[root@aims-pc-100 alsa]# cat=
 /proc/asound/cards<BR>=0A&nbsp; &nbsp; &nbsp; --- no soundcards ---<BR>=0A=
&nbsp; **[root@aims-pc-100 alsa]# cat /proc/asound/devices<BR>=0A&nbsp; &nb=
sp; &nbsp; 1: : sequencer<BR>=0A&nbsp; &nbsp; &nbsp; 33: : timer<BR>=0A&nbs=
p; **[root@aims-pc-100 alsa]# alsamixer<BR>=0A<BR>=0A&nbsp; &nbsp; &nbsp; a=
lsamixer: function snd_ctl_open failed for default: No such device<BR>=0A&n=
bsp; **[root@aims-pc-100 root]# lsmod<BR>=0A&nbsp; &nbsp; &nbsp; Module&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; Size&nbsp; &nbsp; &nbsp; &nbsp; Used by<BR>=0A&nbsp; &nbsp; &nbsp; snd=
_seq_oss&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 35712&nbsp; &nbsp;=
 &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_seq_midi_event&nbsp; &nbsp;=
 7396&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_se=
q&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; 55824&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_pcm_os=
s&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 52556&nbsp; &nbsp; &nbsp;=
 &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_mixer_oss&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; 19076&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nb=
sp; snd_ice1712&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 6531=
6&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_ice17xx_ak4xx=
x&nbsp; &nbsp; 4004&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp;=
 snd_pcm&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; 96736&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_page_a=
lloc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 11500&nbsp; &nbsp; &nbsp; &nb=
sp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_timer&nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 25028&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=
=0A&nbsp; &nbsp; &nbsp; snd_ak4xxx_adda&nbsp; &nbsp; &nbsp; &nbsp; 5860&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_cs8427&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 10660&nbsp; &nbsp; &nbsp=
; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_ac97_codec&nbsp; &nbsp; &nbsp; &n=
bsp; 71048&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_i2c&=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 5668&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_mp=
u401_uart&nbsp; &nbsp; &nbsp; &nbsp; 7716&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 -<BR>=0A&nbsp; &nbsp; &nbsp; snd_rawmidi&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; 24384&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp=
; &nbsp; snd_seq_device&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 8136&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; 55588&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; soundcore&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9152&nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; autofs&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 16868&=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; 8139too&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 25540&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; ohci1394&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 34820&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; ieee1394&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 108976&nbsp; &nbsp; &nbsp; &nb=
sp; -<BR>=0A&nbsp; &nbsp; &nbsp; parport_pc&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; 24960&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nb=
sp; &nbsp; &nbsp; parport&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; 40544&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A=
&nbsp; &nbsp; &nbsp; ehci_hcd&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; 28900&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nb=
sp; &nbsp; usbcore&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; 111828&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A<BR>=0AAm I missing =
something?<BR>=0A<BR>=0AWhat else I need to do and check to confirm that AL=
SA is working fine for my card &quot;ICE1712 - M Audio Delta 1010&quot;?<BR=
>=0A<BR>=0APleeeeeeeeeeease help me out. <BR>=0A<BR>=0AThe below are the ex=
act steps I have followed:<BR>=0A*Installed redhat linux 9.0 (inbuilt kerne=
l 2.4.20-8)<BR>=0A*Upgraded kernel to 2.6.7, not selected for ALSA(or OSS) =
inclusion in kernel configuration. Selected only sound.<BR>=0A*Downloaded a=
lsa-driver-1.0.5a,alsa-lib-1.0.5, alsa-utils-1.0.5 and alsa-oss-1.0.5 from =
http://www.alsa-project.org.<BR>=0A*Installed alsa-driver-1.0.5a using the =
following:<BR>=0A&nbsp; % ./configure --with-cards=3Dice1712 --with-sequenc=
er=3Dyes &amp;&amp; make<BR>=0A&nbsp; % make install<BR>=0A&nbsp; % ./sndde=
vices<BR>=0A&nbsp; % chmod a+rw /dev/dsp /dev/mixer /dev/sequencer /dev/mid=
i <BR>=0A*Installed alsa-lib-1.0.5 using the following:<BR>=0A&nbsp; % ./co=
nfigure;make;make install<BR>=0A*Installed alsa-utils-1.0.5 using the follo=
wing:<BR>=0A&nbsp; % ./configure;make;make install<BR>=0A*Installed alsa-os=
s-1.0.5 using the following:<BR>=0A&nbsp; % ./configure;make;make install<B=
R>=0A*modprobe snd-ice1712;modprobe snd-pcm-oss;modprobe snd-mixer-oss;modp=
robe snd-seq-oss<BR>=0A*my /etc/modules.conf<BR>=0A&nbsp; [I am not sure wh=
ether this is ok or not, please correct me if I am wrong]<BR>=0A&nbsp; alia=
s eth0 8139too<BR>=0A&nbsp; alias usb-controller ehci-hcd<BR>=0A&nbsp; alia=
s usb-controller1 usb-uhci<BR>=0A&nbsp; alias sound-slot-0 i810_audio<BR>=
=0A&nbsp; post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L =
&gt;/dev/null 2&gt;&amp;1 || :<BR>=0A&nbsp; pre-remove sound-slot-0 /bin/au=
mix-minimal -f /etc/.aumixrc -S &gt;/dev/null 2&gt;&amp;1 || :<BR>=0A&nbsp;=
 # ALSA portion<BR>=0A&nbsp; alias char-major-116 snd<BR>=0A&nbsp; alias sn=
d-card-0 snd-ice1712 <BR>=0A&nbsp; # module options should go here<BR>=0A&n=
bsp; # OSS/Free portion<BR>=0A&nbsp; alias char-major-14 soundcore<BR>=0A&n=
bsp; alias sound-slot-0 snd-card-0<BR>=0A<BR>=0A&nbsp; # card #1<BR>=0A&nbs=
p; alias sound-service-0-0 snd-mixer-oss<BR>=0A&nbsp; alias sound-service-0=
-1 snd-seq-oss<BR>=0A&nbsp; alias sound-service-0-3 snd-pcm-oss<BR>=0A&nbsp=
; alias sound-service-0-8 snd-seq-oss<BR>=0A&nbsp; alias sound-service-0-12=
 snd-pcm-oss<BR>=0A&nbsp; # OSS/Free portion - card #2<BR>=0A&nbsp; alias s=
ound-service-1-0 snd-mixer-oss<BR>=0A&nbsp; alias sound-service-1-3 snd-pcm=
-oss<BR>=0A&nbsp; alias sound-service-1-12 snd-pcm-oss<BR>=0A<BR>=0A* Is re=
boot needed after modifying the /etc/modules.conf file?<BR>=0A* I read that=
 all mixer channels are muted by default. How exactly we should adjust the =
soundcards volume level?. <BR>=0ASomebody please suggest.<BR>=0A<BR>=0ARega=
rds,<BR>=0ASailaja<BR>=0A=0A</P>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"=
http://clients.rediff.com/signature/track_sig.asp"><IMG SRC=3D"http://ads.r=
ediff.com/RealMedia/ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm@Bottom=
" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1092144963---0-203.199.83.247-11515
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 10 Aug 2004 Giuliano Pochini wrote :=0A>On 10 Aug 2004 06:56:28 -00=
00=0A>"SailajaReddy  K" <sailaja_reddi@rediffmail.com> wrote:=0A>=0A> > *I =
have installed alsa driver,lib, utilities successfully. But I couldn't see =
any cards in my system.  Please see below outputs:=0A>=0A>Did you check if =
there is something useful in the logs ?=0AWhich logs I should check? Please=
 suggest.=0A=0AThanks,=0ASailaja=0A>=0A>=0A>--=0A>Giuliano.=0AHi,.=0A*I hav=
e installed alsa driver,lib, utilities successfully. But I couldn't see any=
 cards in my system.  Please see below outputs:=0A  **[root@aims-pc-100 als=
a]# cat /proc/asound/cards=0A      --- no soundcards ---=0A  **[root@aims-p=
c-100 alsa]# cat /proc/asound/devices=0A      1: : sequencer=0A      33: : =
timer=0A  **[root@aims-pc-100 alsa]# alsamixer=0A=0A      alsamixer: functi=
on snd_ctl_open failed for default: No such device=0A  **[root@aims-pc-100 =
root]# lsmod=0A      Module                        Size        Used by=0A  =
    snd_seq_oss              35712        -=0A      snd_seq_midi_event    7=
396          -=0A      snd_seq                      55824        -=0A      =
snd_pcm_oss              52556        -=0A      snd_mixer_oss            19=
076        -=0A      snd_ice1712                65316        -=0A      snd_=
ice17xx_ak4xxx    4004        -=0A      snd_pcm                    96736   =
     -=0A      snd_page_alloc            11500        -=0A      snd_timer  =
                  25028        -=0A      snd_ak4xxx_adda        5860       =
   -=0A      snd_cs8427                10660        -=0A      snd_ac97_code=
c        71048        -=0A      snd_i2c                      5668          =
-=0A      snd_mpu401_uart        7716          -=0A      snd_rawmidi       =
         24384        -=0A      snd_seq_device          8136          -=0A =
     snd                            55588        -=0A      soundcore       =
           9152          -=0A      autofs                        16868     =
     -=0A      8139too                    25540          -=0A      ohci1394=
                  34820          -=0A      ieee1394                  108976=
        -=0A      parport_pc                24960          -=0A      parpor=
t                      40544          -=0A      ehci_hcd                  2=
8900          -=0A      usbcore                    111828        -=0A=0AAm =
I missing something?=0A=0AWhat else I need to do and check to confirm that =
ALSA is working fine for my card "ICE1712 - M Audio Delta 1010"?=0A=0APleee=
eeeeeeeease help me out. =0A=0AThe below are the exact steps I have followe=
d:=0A*Installed redhat linux 9.0 (inbuilt kernel 2.4.20-8)=0A*Upgraded kern=
el to 2.6.7, not selected for ALSA(or OSS) inclusion in kernel configuratio=
n. Selected only sound.=0A*Downloaded alsa-driver-1.0.5a,alsa-lib-1.0.5, al=
sa-utils-1.0.5 and alsa-oss-1.0.5 from http://www.alsa-project.org.=0A*Inst=
alled alsa-driver-1.0.5a using the following:=0A  % ./configure --with-card=
s=3Dice1712 --with-sequencer=3Dyes && make=0A  % make install=0A  % ./sndde=
vices=0A  % chmod a+rw /dev/dsp /dev/mixer /dev/sequencer /dev/midi =0A*Ins=
talled alsa-lib-1.0.5 using the following:=0A  % ./configure;make;make inst=
all=0A*Installed alsa-utils-1.0.5 using the following:=0A  % ./configure;ma=
ke;make install=0A*Installed alsa-oss-1.0.5 using the following:=0A  % ./co=
nfigure;make;make install=0A*modprobe snd-ice1712;modprobe snd-pcm-oss;modp=
robe snd-mixer-oss;modprobe snd-seq-oss=0A*my /etc/modules.conf=0A  [I am n=
ot sure whether this is ok or not, please correct me if I am wrong]=0A  ali=
as eth0 8139too=0A  alias usb-controller ehci-hcd=0A  alias usb-controller1=
 usb-uhci=0A  alias sound-slot-0 i810_audio=0A  post-install sound-slot-0 /=
bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null 2>&1 || :=0A  pre-remove s=
ound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null 2>&1 || :=0A =
 # ALSA portion=0A  alias char-major-116 snd=0A  alias snd-card-0 snd-ice17=
12 =0A  # module options should go here=0A  # OSS/Free portion=0A  alias ch=
ar-major-14 soundcore=0A  alias sound-slot-0 snd-card-0=0A=0A  # card #1=0A=
  alias sound-service-0-0 snd-mixer-oss=0A  alias sound-service-0-1 snd-seq=
-oss=0A  alias sound-service-0-3 snd-pcm-oss=0A  alias sound-service-0-8 sn=
d-seq-oss=0A  alias sound-service-0-12 snd-pcm-oss=0A  # OSS/Free portion -=
 card #2=0A  alias sound-service-1-0 snd-mixer-oss=0A  alias sound-service-=
1-3 snd-pcm-oss=0A  alias sound-service-1-12 snd-pcm-oss=0A=0A* Is reboot n=
eeded after modifying the /etc/modules.conf file?=0A* I read that all mixer=
 channels are muted by default. How exactly we should adjust the soundcards=
 volume level?. =0ASomebody please suggest.=0A=0ARegards,=0ASailaja=0A
--Next_1092144963---0-203.199.83.247-11515--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
