From: "SailajaReddy  K" <sailaja_reddi@rediffmail.com>
Subject: Installed alsa (1.0.5)into 2.6.7 kernel:says nosoundcards
Date: 10 Aug 2004 06:56:28 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040810065628.2539.qmail@webmail35.rediffmail.com>
Reply-To: "SailajaReddy  K" <sailaja_reddi@rediffmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="Next_1092120988---0-203.199.83.246-2535"
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
Cc: sailaja.reddy@wipro.com
List-Id: alsa-devel@alsa-project.org

 This is a multipart mime message


--Next_1092120988---0-203.199.83.246-2535
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHi,.<BR>=0A*I have installed alsa driver,lib, utilities successfully.=
 But I couldn't see any cards in my system.&nbsp; Please see below outputs:=
<BR>=0A&nbsp;  **[root@aims-pc-100 alsa]# cat /proc/asound/cards<BR>=0A&nbs=
p; &nbsp; &nbsp; --- no soundcards ---<BR>=0A&nbsp;  **[root@aims-pc-100 al=
sa]# cat /proc/asound/devices<BR>=0A&nbsp; &nbsp; &nbsp; 1: : sequencer<BR>=
=0A&nbsp; &nbsp; &nbsp; 33: : timer<BR>=0A&nbsp;  **[root@aims-pc-100 alsa]=
# alsamixer<BR>=0A <BR>=0A&nbsp; &nbsp; &nbsp; alsamixer: function snd_ctl_=
open failed for default: No such device<BR>=0A&nbsp;  **[root@aims-pc-100 r=
oot]# lsmod<BR>=0A&nbsp; &nbsp; &nbsp; Module&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Size&nbsp; &nbsp; &nb=
sp; &nbsp; Used by<BR>=0A&nbsp; &nbsp; &nbsp; snd_seq_oss&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;  35712&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&n=
bsp; &nbsp; &nbsp; snd_seq_midi_event&nbsp; &nbsp;  7396&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_seq&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 55824&nbsp; &nbsp; &n=
bsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_pcm_oss&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; 52556&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &=
nbsp; &nbsp; snd_mixer_oss&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 19076&n=
bsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_ice1712&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 65316&nbsp; &nbsp; &nbsp; &n=
bsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_ice17xx_ak4xxx&nbsp; &nbsp; 4004&nbsp=
; &nbsp; &nbsp; &nbsp;  -<BR>=0A&nbsp; &nbsp; &nbsp; snd_pcm&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  96736&nbsp; &nbsp; =
&nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_page_alloc&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; 11500&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nb=
sp; &nbsp; snd_timer&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; 25028&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp=
; snd_ak4xxx_adda&nbsp; &nbsp; &nbsp; &nbsp; 5860&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_cs8427&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; 10660&nbsp; &nbsp; &nbsp; &nbsp;  -<BR>=0A&nbs=
p; &nbsp; &nbsp; snd_ac97_codec&nbsp; &nbsp; &nbsp; &nbsp;  71048&nbsp; &nb=
sp; &nbsp; &nbsp;  -<BR>=0A&nbsp; &nbsp; &nbsp; snd_i2c&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 5668&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;  -<BR>=0A&nbsp; &nbsp; &nbsp; snd_mpu401_uart&nbsp; &n=
bsp; &nbsp; &nbsp; 7716&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &n=
bsp; &nbsp; snd_rawmidi&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; 24384&nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd_seq_d=
evice&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  8136&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; -<BR>=0A&nbsp; &nbsp; &nbsp; snd&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 55588&nbsp; &nb=
sp; &nbsp; &nbsp;  -<BR>=0A&nbsp; &nbsp; &nbsp; soundcore&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9152&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;  -<BR>=0A&nbsp; &nbsp; &nbsp; autofs&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 16868&nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; 8139too&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  25540&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; ohci1394&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  34820&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; -<BR>=0A&nbsp; &nbsp; &nbsp; ieee1394&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;  108976&nbsp; &nbsp; &nbsp; &nbsp;  -<BR>=
=0A&nbsp; &nbsp; &nbsp; parport_pc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;  24960&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbs=
p; &nbsp; parport&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; 40544&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &=
nbsp; &nbsp; ehci_hcd&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;  28900&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -<BR>=0A&nbsp; &nbsp; &nb=
sp; usbcore&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; 111828&nbsp; &nbsp; &nbsp; &nbsp;  -<BR>=0A <BR>=0AAm I missing somet=
hing?<BR>=0A <BR>=0AWhat else I need to do and check to confirm that ALSA i=
s working fine for my card &quot;ICE1712 - M Audio Delta 1010&quot;?<BR>=0A=
 <BR>=0APleeeeeeeeeeease help me out. <BR>=0A <BR>=0AThe below are the exac=
t steps I have followed:<BR>=0A*Installed redhat linux 9.0 (inbuilt kernel =
2.4.20-8)<BR>=0A*Upgraded kernel to 2.6.7, not selected for ALSA(or OSS) in=
clusion in kernel configuration. Selected only sound.<BR>=0A*Downloaded als=
a-driver-1.0.5a,alsa-lib-1.0.5, alsa-utils-1.0.5 and alsa-oss-1.0.5 from ht=
tp://www.alsa-project.org.<BR>=0A*Installed alsa-driver-1.0.5a using the fo=
llowing:<BR>=0A&nbsp; % ./configure --with-cards=3Dice1712 --with-sequencer=
=3Dyes &amp;&amp; make<BR>=0A&nbsp; % make install<BR>=0A&nbsp; % ./snddevi=
ces<BR>=0A&nbsp; % chmod a+rw /dev/dsp /dev/mixer /dev/sequencer /dev/midi =
<BR>=0A*Installed alsa-lib-1.0.5 using the following:<BR>=0A&nbsp; % ./conf=
igure;make;make install<BR>=0A*Installed alsa-utils-1.0.5 using the followi=
ng:<BR>=0A&nbsp; % ./configure;make;make install<BR>=0A*Installed alsa-oss-=
1.0.5 using the following:<BR>=0A&nbsp; % ./configure;make;make install<BR>=
=0A*modprobe snd-ice1712;modprobe snd-pcm-oss;modprobe snd-mixer-oss;modpro=
be snd-seq-oss<BR>=0A*my /etc/modules.conf<BR>=0A&nbsp; [I am not sure whet=
her this is ok or not, please correct me if I am wrong]<BR>=0A&nbsp; alias =
eth0 8139too<BR>=0A&nbsp; alias usb-controller ehci-hcd<BR>=0A&nbsp; alias =
usb-controller1 usb-uhci<BR>=0A&nbsp; alias sound-slot-0 i810_audio<BR>=0A&=
nbsp; post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L &gt;=
/dev/null 2&gt;&amp;1 || :<BR>=0A&nbsp; pre-remove sound-slot-0 /bin/aumix-=
minimal -f /etc/.aumixrc -S &gt;/dev/null 2&gt;&amp;1 || :<BR>=0A&nbsp; # A=
LSA portion<BR>=0A&nbsp; alias char-major-116 snd<BR>=0A&nbsp; alias snd-ca=
rd-0 snd-ice1712 <BR>=0A&nbsp; # module options should go here<BR>=0A&nbsp;=
 # OSS/Free portion<BR>=0A&nbsp; alias char-major-14 soundcore<BR>=0A&nbsp;=
 alias sound-slot-0 snd-card-0<BR>=0A <BR>=0A&nbsp; # card #1<BR>=0A&nbsp; =
alias sound-service-0-0 snd-mixer-oss<BR>=0A&nbsp; alias sound-service-0-1 =
snd-seq-oss<BR>=0A&nbsp; alias sound-service-0-3 snd-pcm-oss<BR>=0A&nbsp; a=
lias sound-service-0-8 snd-seq-oss<BR>=0A&nbsp; alias sound-service-0-12 sn=
d-pcm-oss<BR>=0A&nbsp; # OSS/Free portion - card #2<BR>=0A&nbsp; alias soun=
d-service-1-0 snd-mixer-oss<BR>=0A&nbsp; alias sound-service-1-3 snd-pcm-os=
s<BR>=0A&nbsp; alias sound-service-1-12 snd-pcm-oss<BR>=0A <BR>=0A* Is rebo=
ot needed after modifying the /etc/modules.conf file?<BR>=0A* I read that a=
ll mixer channels are muted by default. How exactly we should adjust the so=
undcards volume level?. <BR>=0ASomebody please suggest.<BR>=0A <BR>=0ARegar=
ds,<BR>=0ASailaja<BR>=0A=0A</P>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"h=
ttp://clients.rediff.com/signature/track_sig.asp"><IMG SRC=3D"http://ads.re=
diff.com/RealMedia/ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm@Bottom"=
 BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1092120988---0-203.199.83.246-2535
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,.=0A*I have installed alsa driver,lib, utilities successfully. But I cou=
ldn't see any cards in my system.  Please see below outputs:=0A   **[root@a=
ims-pc-100 alsa]# cat /proc/asound/cards=0A      --- no soundcards ---=0A  =
 **[root@aims-pc-100 alsa]# cat /proc/asound/devices=0A      1: : sequencer=
=0A      33: : timer=0A   **[root@aims-pc-100 alsa]# alsamixer=0A =0A      =
alsamixer: function snd_ctl_open failed for default: No such device=0A   **=
[root@aims-pc-100 root]# lsmod=0A      Module                        Size  =
      Used by=0A      snd_seq_oss               35712        -=0A      snd_=
seq_midi_event     7396          -=0A      snd_seq                      558=
24        -=0A      snd_pcm_oss              52556        -=0A      snd_mix=
er_oss            19076        -=0A      snd_ice1712                65316  =
      -=0A      snd_ice17xx_ak4xxx    4004         -=0A      snd_pcm       =
              96736        -=0A      snd_page_alloc            11500       =
 -=0A      snd_timer                    25028        -=0A      snd_ak4xxx_a=
dda        5860          -=0A      snd_cs8427                10660         =
-=0A      snd_ac97_codec         71048         -=0A      snd_i2c           =
           5668           -=0A      snd_mpu401_uart        7716          -=
=0A      snd_rawmidi                24384        -=0A      snd_seq_device  =
         8136          -=0A      snd                            55588      =
   -=0A      soundcore                  9152           -=0A      autofs    =
                    16868          -=0A      8139too                     25=
540          -=0A      ohci1394                   34820          -=0A      =
ieee1394                   108976         -=0A      parport_pc             =
    24960          -=0A      parport                      40544          -=
=0A      ehci_hcd                   28900          -=0A      usbcore       =
             111828         -=0A =0AAm I missing something?=0A =0AWhat else=
 I need to do and check to confirm that ALSA is working fine for my card "I=
CE1712 - M Audio Delta 1010"?=0A =0APleeeeeeeeeeease help me out. =0A =0ATh=
e below are the exact steps I have followed:=0A*Installed redhat linux 9.0 =
(inbuilt kernel 2.4.20-8)=0A*Upgraded kernel to 2.6.7, not selected for ALS=
A(or OSS) inclusion in kernel configuration. Selected only sound.=0A*Downlo=
aded alsa-driver-1.0.5a,alsa-lib-1.0.5, alsa-utils-1.0.5 and alsa-oss-1.0.5=
 from http://www.alsa-project.org.=0A*Installed alsa-driver-1.0.5a using th=
e following:=0A  % ./configure --with-cards=3Dice1712 --with-sequencer=3Dye=
s && make=0A  % make install=0A  % ./snddevices=0A  % chmod a+rw /dev/dsp /=
dev/mixer /dev/sequencer /dev/midi =0A*Installed alsa-lib-1.0.5 using the f=
ollowing:=0A  % ./configure;make;make install=0A*Installed alsa-utils-1.0.5=
 using the following:=0A  % ./configure;make;make install=0A*Installed alsa=
-oss-1.0.5 using the following:=0A  % ./configure;make;make install=0A*modp=
robe snd-ice1712;modprobe snd-pcm-oss;modprobe snd-mixer-oss;modprobe snd-s=
eq-oss=0A*my /etc/modules.conf=0A  [I am not sure whether this is ok or not=
, please correct me if I am wrong]=0A  alias eth0 8139too=0A  alias usb-con=
troller ehci-hcd=0A  alias usb-controller1 usb-uhci=0A  alias sound-slot-0 =
i810_audio=0A  post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixr=
c -L >/dev/null 2>&1 || :=0A  pre-remove sound-slot-0 /bin/aumix-minimal -f=
 /etc/.aumixrc -S >/dev/null 2>&1 || :=0A  # ALSA portion=0A  alias char-ma=
jor-116 snd=0A  alias snd-card-0 snd-ice1712 =0A  # module options should g=
o here=0A  # OSS/Free portion=0A  alias char-major-14 soundcore=0A  alias s=
ound-slot-0 snd-card-0=0A =0A  # card #1=0A  alias sound-service-0-0 snd-mi=
xer-oss=0A  alias sound-service-0-1 snd-seq-oss=0A  alias sound-service-0-3=
 snd-pcm-oss=0A  alias sound-service-0-8 snd-seq-oss=0A  alias sound-servic=
e-0-12 snd-pcm-oss=0A  # OSS/Free portion - card #2=0A  alias sound-service=
-1-0 snd-mixer-oss=0A  alias sound-service-1-3 snd-pcm-oss=0A  alias sound-=
service-1-12 snd-pcm-oss=0A =0A* Is reboot needed after modifying the /etc/=
modules.conf file?=0A* I read that all mixer channels are muted by default.=
 How exactly we should adjust the soundcards volume level?. =0ASomebody ple=
ase suggest.=0A =0ARegards,=0ASailaja=0A
--Next_1092120988---0-203.199.83.246-2535--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
