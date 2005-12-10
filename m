From: Jonathan Murphy <typetosmurky@yahoo.com.au>
Subject: snd-usb-audio and snd-virmidi problems
Date: Sat, 10 Dec 2005 13:10:29 -0500 (EST)
Message-ID: <20051210181029.2135.qmail@web33012.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1507353597-1134238229=:1474"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

--0-1507353597-1134238229=:1474
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

 Hi All,
=20
 Sorry about posting to this list with what is probably a trivial and ann=
oying request for assistance, however I've posted to the alsa-users and o=
ther lists and haven't been able to work this out for myself so I figured=
 I'd ask the people most likely to know. I'm having problems compiling sn=
d-usb-audio and snd-virmidi. The kernel versions I'm working with are 2.6=
.12.5 and 2.6.12.6. I've tried compiling the modules into the kernel, and=
 when that failed from the alsa-drivers-1.0.10 package. I came across thi=
s post to the alsa-users list:
=20
 http://sourceforge.net/mailarchive/message.php?msg_id=3D13731737
=20
 and have tried GCC-3.3.6 and GCC-4.0.2 (my default version). In all case=
s I get these warnings when compiling snd-usb-audio:
=20
 *** Warning: "__compound_literal.132" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.189" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.130" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.122" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.91" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.85" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.104" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning:  "__compound_literal.152" [sound/usb/snd-usb-audio.ko] und=
efined!
  *** Warning: "__compound_literal.100" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.145" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.106" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.164" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.136" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.154" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.175" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.81" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.95" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.83" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.182" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning:  "__compound_literal.139" [sound/usb/snd-usb-audio.ko] und=
efined!
  *** Warning: "__compound_literal.87" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.156" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.118" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.143" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.148" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.168" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.160" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.116" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.124" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.187" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.126" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning:  "__compound_literal.128" [sound/usb/snd-usb-audio.ko] und=
efined!
  *** Warning: "__compound_literal.93" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.141" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.185" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.162" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.134" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.180" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.177" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.108" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.166" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.79" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.120" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning:  "__compound_literal.114" [sound/usb/snd-usb-audio.ko] und=
efined!
  *** Warning: "__compound_literal.158" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.102" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.150" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.110" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.112" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.173" [sound/usb/snd-usb-audio.ko] unde=
fined!
  *** Warning: "__compound_literal.89" [sound/usb/snd-usb-audio.ko] undef=
ined!
  *** Warning: "__compound_literal.170" [sound/usb/snd-usb-audio.ko] unde=
fined!
=20
 and the module is built but will not load. snd-virmidi gives no warnings=
 during compilation however when I try to load it it segfaults. Here is t=
he dump from dmesg:
=20
 Oops: 0000 [#1]
 PREEMPT=20
 Modules linked in: snd_virmidi snd_seq_virmidi snd_rawmidi snd_seq_midi_=
event snd_seq snd_seq_device snd_ali5451 snd_ac97_codec snd_ac97_bus snd_=
pcm snd_timer snd snd_page_alloc
 CPU:    0
 EIP:    0060:[<00000000>]    Not tainted VLI
 EFLAGS: 00010282   (2.6.12.5)=20
 EIP is at stext+0x3feffdd8/0x8
 eax: f6fa7780   ebx: f88b5874   ecx: 00000000   edx: f88b5874
 esi: f6fa7788   edi: c04848a0   ebp: f6fa77ac   esp: f1801e8c
 ds: 007b   es: 007b   ss: 0068
 Process modprobe (pid: 3748, threadinfo=3Df1800000 task=3Df4b24a20)
 Stack: c02a7640 f6fa7780 f88b5874 f88b58a4 f6fa7788 c02a76da f88b5874 f6=
fa7788=20
        c02301f4 c048486c f6fa7788 f6fa7788 c0484840 c02a797c f6fa7788 c0=
2aab93=20
        f6fa7788 f6fa7788 f6fa77e0 00000000 c02a6a12 f6fa7788 00000001 f6=
fa77e0=20
 Call Trace:
  [<c02a7640>] driver_probe_device+0x29/0x64
  [<c02a76da>] device_attach+0x5f/0xaa
  [<c02301f4>] kobject_get+0x17/0x1e
  [<c02a797c>] bus_add_device+0x56/0xb7
  [<c02aab93>] device_pm_add+0x56/0x8b
  [<c02a6a12>] device_add+0xca/0x14f
  [<c02a9190>] platform_device_register+0x13f/0x186
  [<f88a9766>] snd_generic_device_register+0x5c/0xa3 [snd]
  [<f88a97f0>] snd_card_set_generic_dev+0x10/0x3b [snd]
  [<f888d13b>] snd_card_virmidi_probe+0x13b/0x1ac [snd_virmidi]
  [<f888d1c5>] alsa_card_virmidi_init+0x19/0x59 [snd_virmidi]
  [<c0133c66>] sys_init_module+0xc0/0x1fc
  [<c0102f0f>] sysenter_past_esp+0x54/0x75
 Code:  Bad EIP value.
=20
 If anyone could provide me with the following pieces of information I wo=
uld be grateful:
=20
 1.    What is the recommended version of GCC to use when compiling alsa-=
drivers-1.0.10?
=20
 2.   Are there known issues with the kernel versions that I'm trying to =
use, and if so which version of the 2.6.12 kernel is known to work best, =
and/or are there patches that will help.
=20
 3.   Are there possible conflicts with other USB related areas in the ke=
rnel? Anything (other than  obviously  CONFIG_USB=3Dy) which needs to be =
turned on or off in order for snd-usb-audio to compile cleanly?=20
=20
 Thanking you in advance,
=20
 Jonathan Murphy.
=20
=20
=20
=20

	=09
---------------------------------
Find your next car at Yahoo! Canada Autos
--0-1507353597-1134238229=:1474
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<div id=3D"RTEContent">&nbsp;Hi All,<br> <br> Sorry about posting to this=
 list with what is probably a trivial and annoying request for assistance=
, however I've posted to the alsa-users and other lists and haven't been =
able to work this out for myself so I figured I'd ask the people most lik=
ely to know. I'm having problems compiling snd-usb-audio and snd-virmidi.=
 The kernel versions I'm working with are 2.6.12.5 and 2.6.12.6. I've tri=
ed compiling the modules into the kernel, and when that failed from the a=
lsa-drivers-1.0.10 package. I came across this post to the alsa-users lis=
t:<br> <br> <a href=3D"http://sourceforge.net/mailarchive/message.php?msg=
_id=3D13731737">http://sourceforge.net/mailarchive/message.php?msg_id=3D1=
3731737</a><br> <br> and have tried GCC-3.3.6 and GCC-4.0.2 (my default v=
ersion). In all cases I get these warnings when compiling snd-usb-audio:<=
br> <br> *** Warning: "__compound_literal.132" [sound/usb/snd-usb-audio.k=
o] undefined!<br>  *** Warning: "__compound_literal.189"
 [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_li=
teral.130" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__c=
ompound_literal.122" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** War=
ning: "__compound_literal.91" [sound/usb/snd-usb-audio.ko] undefined!<br>=
  *** Warning: "__compound_literal.85" [sound/usb/snd-usb-audio.ko] undef=
ined!<br>  *** Warning: "__compound_literal.104" [sound/usb/snd-usb-audio=
.ko] undefined!<br>  *** Warning:  "__compound_literal.152" [sound/usb/sn=
d-usb-audio.ko] undefined!<br>  *** Warning: "__compound_literal.100" [so=
und/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_litera=
l.145" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compo=
und_literal.106" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning=
: "__compound_literal.164" [sound/usb/snd-usb-audio.ko] undefined!<br>  *=
** Warning: "__compound_literal.136" [sound/usb/snd-usb-audio.ko] undefin=
ed!<br>  *** Warning: "__compound_literal.154"
 [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_li=
teral.175" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__c=
ompound_literal.81" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warn=
ing: "__compound_literal.95" [sound/usb/snd-usb-audio.ko] undefined!<br> =
 *** Warning: "__compound_literal.83" [sound/usb/snd-usb-audio.ko] undefi=
ned!<br>  *** Warning: "__compound_literal.182" [sound/usb/snd-usb-audio.=
ko] undefined!<br>  *** Warning:  "__compound_literal.139" [sound/usb/snd=
-usb-audio.ko] undefined!<br>  *** Warning: "__compound_literal.87" [soun=
d/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_literal.=
156" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compoun=
d_literal.118" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: =
"__compound_literal.143" [sound/usb/snd-usb-audio.ko] undefined!<br>  ***=
 Warning: "__compound_literal.148" [sound/usb/snd-usb-audio.ko] undefined=
!<br>  *** Warning: "__compound_literal.168"
 [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_li=
teral.160" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__c=
ompound_literal.116" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** War=
ning: "__compound_literal.124" [sound/usb/snd-usb-audio.ko] undefined!<br=
>  *** Warning: "__compound_literal.187" [sound/usb/snd-usb-audio.ko] und=
efined!<br>  *** Warning: "__compound_literal.126" [sound/usb/snd-usb-aud=
io.ko] undefined!<br>  *** Warning:  "__compound_literal.128" [sound/usb/=
snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_literal.93" [s=
ound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_liter=
al.141" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__comp=
ound_literal.185" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warnin=
g: "__compound_literal.162" [sound/usb/snd-usb-audio.ko] undefined!<br>  =
*** Warning: "__compound_literal.134" [sound/usb/snd-usb-audio.ko] undefi=
ned!<br>  *** Warning: "__compound_literal.180"
 [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_li=
teral.177" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__c=
ompound_literal.108" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** War=
ning: "__compound_literal.166" [sound/usb/snd-usb-audio.ko] undefined!<br=
>  *** Warning: "__compound_literal.79" [sound/usb/snd-usb-audio.ko] unde=
fined!<br>  *** Warning: "__compound_literal.120" [sound/usb/snd-usb-audi=
o.ko] undefined!<br>  *** Warning:  "__compound_literal.114" [sound/usb/s=
nd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_literal.158" [s=
ound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_liter=
al.102" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__comp=
ound_literal.150" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warnin=
g: "__compound_literal.110" [sound/usb/snd-usb-audio.ko] undefined!<br>  =
*** Warning: "__compound_literal.112" [sound/usb/snd-usb-audio.ko] undefi=
ned!<br>  *** Warning: "__compound_literal.173"
 [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__compound_li=
teral.89" [sound/usb/snd-usb-audio.ko] undefined!<br>  *** Warning: "__co=
mpound_literal.170" [sound/usb/snd-usb-audio.ko] undefined!<br> <br> and =
the module is built but will not load. snd-virmidi gives no warnings duri=
ng compilation however when I try to load it it segfaults. Here is the du=
mp from dmesg:<br> <br> Oops: 0000 [#1]<br> PREEMPT <br> Modules linked i=
n: snd_virmidi snd_seq_virmidi snd_rawmidi snd_seq_midi_event snd_seq snd=
_seq_device snd_ali5451 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd=
 snd_page_alloc<br> CPU:&nbsp;&nbsp;&nbsp; 0<br> EIP:&nbsp;&nbsp;&nbsp; 0=
060:[&lt;00000000&gt;]&nbsp;&nbsp;&nbsp; Not tainted VLI<br> EFLAGS: 0001=
0282&nbsp;&nbsp; (2.6.12.5) <br> EIP is at stext+0x3feffdd8/0x8<br> eax: =
f6fa7780&nbsp;&nbsp; ebx: f88b5874&nbsp;&nbsp; ecx: 00000000&nbsp;&nbsp; =
edx: f88b5874<br> esi: f6fa7788&nbsp;&nbsp; edi: c04848a0&nbsp;&nbsp; ebp=
: f6fa77ac&nbsp;&nbsp; esp: f1801e8c<br> ds:
 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<br> Process modprobe (pid=
: 3748, threadinfo=3Df1800000 task=3Df4b24a20)<br> Stack: c02a7640 f6fa77=
80 f88b5874 f88b58a4 f6fa7788 c02a76da f88b5874 f6fa7788 <br> &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; c02301f4 c048486c f6fa7788 f6fa7788 c0484840 c0=
2a797c f6fa7788 c02aab93 <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f6fa77=
88 f6fa7788 f6fa77e0 00000000 c02a6a12 f6fa7788 00000001 f6fa77e0 <br> Ca=
ll Trace:<br> &nbsp;[&lt;c02a7640&gt;] driver_probe_device+0x29/0x64<br> =
&nbsp;[&lt;c02a76da&gt;] device_attach+0x5f/0xaa<br> &nbsp;[&lt;c02301f4&=
gt;] kobject_get+0x17/0x1e<br> &nbsp;[&lt;c02a797c&gt;] bus_add_device+0x=
56/0xb7<br> &nbsp;[&lt;c02aab93&gt;] device_pm_add+0x56/0x8b<br> &nbsp;[&=
lt;c02a6a12&gt;] device_add+0xca/0x14f<br> &nbsp;[&lt;c02a9190&gt;] platf=
orm_device_register+0x13f/0x186<br> &nbsp;[&lt;f88a9766&gt;] snd_generic_=
device_register+0x5c/0xa3 [snd]<br> &nbsp;[&lt;f88a97f0&gt;] snd_card_set=
_generic_dev+0x10/0x3b [snd]<br>
 &nbsp;[&lt;f888d13b&gt;] snd_card_virmidi_probe+0x13b/0x1ac [snd_virmidi=
]<br> &nbsp;[&lt;f888d1c5&gt;] alsa_card_virmidi_init+0x19/0x59 [snd_virm=
idi]<br> &nbsp;[&lt;c0133c66&gt;] sys_init_module+0xc0/0x1fc<br> &nbsp;[&=
lt;c0102f0f&gt;] sysenter_past_esp+0x54/0x75<br> Code:&nbsp; Bad EIP valu=
e.<br> <br> If anyone could provide me with the following pieces of infor=
mation I would be grateful:<br> <br> 1.&nbsp;&nbsp;  What is the recommen=
ded version of GCC to use when compiling alsa-drivers-1.0.10?<br> <br> 2.=
&nbsp;&nbsp; Are there known issues with the kernel versions that I'm try=
ing to use, and if so which version of the 2.6.12 kernel is known to work=
 best, and/or are there patches that will help.<br> <br> 3.&nbsp;&nbsp; A=
re there possible conflicts with other USB related areas in the kernel? A=
nything (other than&nbsp; obviously&nbsp; CONFIG_USB=3Dy) which needs to =
be turned on or off in order for snd-usb-audio to compile cleanly? <br> <=
br> Thanking you in advance,<br> <br> Jonathan
 Murphy.<br> <br> <br> <br> </div><p>
		<hr size=3D1>Find your next car at <a href=3D"http://autos.yahoo.ca"><b=
>Yahoo! Canada Autos</b></a>
--0-1507353597-1134238229=:1474--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
