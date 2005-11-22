From: Jon Grosshart <jgrosshart@gmail.com>
Subject: Re: kernel 2.6.14.x and alsamixer problems
Date: Tue, 22 Nov 2005 00:48:29 -0500
Message-ID: <9cf823c60511212148o2fa440b7vb3b151c97b1a78db@mail.gmail.com>
References: <437EB3E6.6030205@gmail.com> <437F073D.4070906@superbug.co.uk>
	 <437FF88A.5070502@gmail.com> <43805484.70902@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_31121_30368280.1132638509110"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43805484.70902@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_31121_30368280.1132638509110
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/20/05, James Courtier-Dutton <James@superbug.co.uk> wrote:
>
> Jon wrote:
> > James Courtier-Dutton wrote:
> >
> >> Jon wrote:
> >>
> >>> Greetings all. Ever since I upgraded to linux-2.6.14 and up, I get
> this
> >>> error when running 'alsamixer'
> >>>
> >>>
> >>> ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playbac=
k
> >>> Volume',0,0,0) appears twice or more
> >>> alsamixer: function snd_mixer_load failed: Invalid argument
> >>>
> >>>
> >>> It does it with alsa-1.0.9 and 1.0.10... I use alsa
> >>> {driver,lib,oss,utils} on my box and leave the kernel sound section
> >>> alone. As soon as I switch back to 2.6.13.4 <http://2.6.13.4> it play=
s
> nice once again
> >>> which is confusing to me...... I'm using the emu10k1 chip (SB Live!
> >>> Value 5.1). Any insight on this matter would be greatly appreciated..=
.
> >>>
> >>> Jon
> >>>
> >>>
> >>
> >> Does you alsa-lib version match your alsa-driver version.
> >> Use the troubleshooter on
> >> http://alsa.opensrc.org/TroubleShooting
> >> to find out.
> >>
> > Yes, I'm always carefull to run matching versions. As soon as I upgrade=
d
> > to the 2.6.14 kernel, this started happening. I hadn'nt even touched my
> > alsa packages, except alsa-driver ofcourse. I used the same version but
> > just compiled the new modules against the new kernel. I've found other
> > people having the same problem on the web, but the posts ussually go
> > unanswered... :-(
> >
>
> Can you post the output from the troubleshooting steps here please.
>
>

I sure can.. Sorry about that. Here is the output from aadebug


[root@jaguar ~/Desktop] ./aadebug
ALSA Audio Debug v0.1.0 - Tue Nov 22 00:29:54 EST 2005
http://alsa.opensrc.org/index.php?page=3Daadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux jaguar 2.6.14.2 <http://2.6.14.2> #1 SMP Wed Nov 16 15:38:45 EST 2005
i686 Intel(R) Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

Loaded Modules --------------------------------------------
snd_pcm_oss 48544 0
snd_mixer_oss 17664 2 snd_pcm_oss
snd_emu10k1 117412 1
snd_rawmidi 21408 1 snd_emu10k1
snd_seq_device 7948 2 snd_emu10k1,snd_rawmidi
snd_ac97_codec 91936 1 snd_emu10k1
snd_pcm 81412 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec
snd_timer 22148 2 snd_emu10k1,snd_pcm
snd_ac97_bus 2816 1 snd_ac97_codec
snd_page_alloc 9352 2 snd_emu10k1,snd_pcm
snd_util_mem 4352 1 snd_emu10k1
snd_hwdep 7968 1 snd_emu10k1
snd 49124 9
snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_c=
odec,snd_pcm,snd_timer,snd_hwdep

Proc Config -----------------------------------------------
CONFIG_SOUND=3Dm
# CONFIG_SND is not set
# CONFIG_SOUND_PRIME is not set

Modprobe Conf ---------------------------------------------
alias snd-card-0 snd-emu10k1
alias sound-slot-0 snd-emu10k1

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.10.
Compiled on Nov 18 2005 for kernel 2.6.14.2 <http://2.6.14.2> (SMP).
0 [Live ]: EMU10K1 - SB Live [Unknown]
SB Live [Unknown] (rev.10, serial:0x80661102) at 0xdda0, irq 21
4: [0- 0]: hardware dependent
8: [0- 0]: raw midi
19: [0- 3]: digital audio playback
18: [0- 2]: digital audio playback
26: [0- 2]: digital audio capture
25: [0- 1]: digital audio capture
16: [0- 0]: digital audio playback
24: [0- 0]: digital audio capture
0: [0- 0]: ctl
33: : timer
00-00: EMU10K1 (FX8010)
00-00: emu10k1 : ADC Capture/Standard PCM Playback : playback 32 : capture =
1
00-01: emu10k1 mic : Mic Capture : capture 1
00-02: emu10k1 efx : Multichannel Capture/PT Playback : playback 8 : captur=
e
1
00-03: emu10k1 : Multichannel Playback : playback 1
cat: /proc/asound/seq/clients: No such file or directory

Dev Snd ---------------------------------------------------
controlC0 midiC0D0 pcmC0D0p pcmC0D2c pcmC0D3p
hwC0D0 pcmC0D0c pcmC0D1c pcmC0D2p timer

CPU -------------------------------------------------------
model name : Intel(R) Pentium(R) 4 CPU 3.00GHz
cpu MHz : 2992.835
model name : Intel(R) Pentium(R) 4 CPU 3.00GHz
cpu MHz : 2992.835

RAM -------------------------------------------------------
MemTotal: 514840 kB
SwapTotal: 1020116 kB

Hardware --------------------------------------------------
00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub
(rev 02)
02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a=
)



Now, I still have sound... Somewhat.... It comes out the back two speakers
but not the front two. I can use the gnome sound control to atleast get it
to where I can hear something... I just can't open alsamixer and tweak it
out...
>From the Troubleshooting list:


1.) I am using alsa-driver and not the built-in kernel modules

2.) [root@jaguar ~/Desktop] cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10.
Compiled on Nov 18 2005 for kernel 2.6.14.2 <http://2.6.14.2> (SMP).

3.) [root@jaguar ~/Desktop] grep VERSION_STR /usr/include/alsa/version.h
#define SND_LIB_VERSION_STR "1.0.10"

4.) [root@jaguar ~/Desktop] cat /proc/asound/cards
0 [Live ]: EMU10K1 - SB Live [Unknown]
SB Live [Unknown] (rev.10, serial:0x80661102) at 0xdda0, irq 21

[root@jaguar ~/Desktop] lspci | egrep audio
02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a=
)


5.) [root@jaguar ~/Desktop] alsamixer
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback
Volume',0,0,0) appears twice or more

alsamixer: function snd_mixer_load failed: Invalid argument

6.) I hate to admit it, but I ussually only run as root. From step 6 and
beyond, it seems pretty trivial to do.



Let me know if there is anything else I can provide and thank you James for
your help. I really do apprecieate it...

------=_Part_31121_30368280.1132638509110
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/20/05, <b class=3D"gmail_sendername">James Courtier-Dutton</b> &lt;<a=
 href=3D"mailto:James@superbug.co.uk">James@superbug.co.uk</a>&gt; wrote:<d=
iv><span class=3D"gmail_quote"></span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
Jon wrote:<br>&gt; James Courtier-Dutton wrote:<br>&gt;<br>&gt;&gt; Jon wro=
te:<br>&gt;&gt;<br>&gt;&gt;&gt; Greetings all. Ever since I upgraded to lin=
ux-2.6.14 and up, I get this<br>&gt;&gt;&gt; error when running 'alsamixer'
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; ALSA lib simple_none.c:121=
6:(simple_add1) helem (MIXER,'Front Playback<br>&gt;&gt;&gt; Volume',0,0,0)=
 appears twice or more<br>&gt;&gt;&gt; alsamixer: function snd_mixer_load f=
ailed: Invalid argument
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; It does it with alsa-1.0.9=
 and 1.0.10... I use alsa<br>&gt;&gt;&gt; {driver,lib,oss,utils} on my box =
and leave the kernel sound section<br>&gt;&gt;&gt; alone. As soon as I swit=
ch back to=20
<a href=3D"http://2.6.13.4">2.6.13.4</a> it plays nice once again<br>&gt;&g=
t;&gt; which is confusing to me...... I'm using the emu10k1 chip (SB Live!<=
br>&gt;&gt;&gt; Value 5.1). Any insight on this matter would be greatly app=
reciated...
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Jon<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt=
;&gt;<br>&gt;&gt; Does you alsa-lib version match your alsa-driver version.=
<br>&gt;&gt; Use the troubleshooter on<br>&gt;&gt; <a href=3D"http://alsa.o=
pensrc.org/TroubleShooting">
http://alsa.opensrc.org/TroubleShooting</a><br>&gt;&gt; to find out.<br>&gt=
;&gt;<br>&gt; Yes, I'm always carefull to run matching versions. As soon as=
 I upgraded<br>&gt; to the 2.6.14 kernel, this started happening. I hadn'nt=
 even touched my
<br>&gt; alsa packages, except alsa-driver ofcourse. I used the same versio=
n but<br>&gt; just compiled the new modules against the new kernel. I've fo=
und other<br>&gt; people having the same problem on the web, but the posts =
ussually go
<br>&gt; unanswered... :-(<br>&gt;<br><br>Can you post the output from the =
troubleshooting steps here please.<br><br></blockquote></div><br>
<br>
I sure can.. Sorry about that. Here is the output from aadebug<br>

<br>

<br>

[root@jaguar ~/Desktop] ./aadebug<br>

ALSA Audio Debug v0.1.0 - Tue Nov 22 00:29:54 EST 2005<br>

<a href=3D"http://alsa.opensrc.org/index.php?page=3Daadebug">http://alsa.op=
ensrc.org/index.php?page=3Daadebug</a><br>

<a href=3D"http://www.gnu.org/licenses/gpl.txt">http://www.gnu.org/licenses=
/gpl.txt</a><br>

<br>

Kernel ----------------------------------------------------<br>

Linux jaguar <a href=3D"http://2.6.14.2">2.6.14.2</a> #1 SMP Wed Nov 16 15:=
38:45 EST 2005 i686 Intel(R) Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linu=
x<br>

<br>

Loaded Modules --------------------------------------------<br>

snd_pcm_oss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 48544&nbsp; 0<br>

snd_mixer_oss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17664&n=
bsp; 2 snd_pcm_oss<br>

snd_emu10k1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 117=
412&nbsp; 1<br>

snd_rawmidi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 21408&nbsp; 1 snd_emu10k1<br>

snd_seq_device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7948&n=
bsp; 2 snd_emu10k1,snd_rawmidi<br>

snd_ac97_codec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 91936&nbsp; =
1 snd_emu10k1<br>
snd_pcm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
81412&nbsp; 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec<br>

snd_timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 22148&nbsp; 2 snd_emu10k1,snd_pcm<br>

snd_ac97_bus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 2816&nbsp; 1 snd_ac97_codec<br>

snd_page_alloc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9352&n=
bsp; 2 snd_emu10k1,snd_pcm<br>

snd_util_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 4352&nbsp; 1 snd_emu10k1<br>

snd_hwdep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 7968&nbsp; 1 snd_emu10k1<br>
snd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
49124&nbsp; 9
snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_c=
odec,snd_pcm,snd_timer,snd_hwdep<br>

<br>

Proc Config -----------------------------------------------<br>

CONFIG_SOUND=3Dm<br>

# CONFIG_SND is not set<br>

# CONFIG_SOUND_PRIME is not set<br>

<br>

Modprobe Conf ---------------------------------------------<br>

alias snd-card-0 snd-emu10k1<br>

alias sound-slot-0 snd-emu10k1<br>

<br>

Proc Asound -----------------------------------------------<br>

Advanced Linux Sound Architecture Driver Version 1.0.10.<br>

Compiled on Nov 18 2005 for kernel <a href=3D"http://2.6.14.2">2.6.14.2</a>=
 (SMP).<br>

0 [Live&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]: EMU1=
0K1 - SB Live [Unknown]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SB Live [Unknown] (rev.10, serial:0x80661102) at 0xdda0, irq 21<br>

&nbsp; 4: [0- 0]: hardware dependent<br>

&nbsp; 8: [0- 0]: raw midi<br>

&nbsp;19: [0- 3]: digital audio playback<br>

&nbsp;18: [0- 2]: digital audio playback<br>

&nbsp;26: [0- 2]: digital audio capture<br>

&nbsp;25: [0- 1]: digital audio capture<br>

&nbsp;16: [0- 0]: digital audio playback<br>

&nbsp;24: [0- 0]: digital audio capture<br>

&nbsp; 0: [0- 0]: ctl<br>

&nbsp;33:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : timer<br>

00-00: EMU10K1 (FX8010)<br>

00-00: emu10k1 : ADC Capture/Standard PCM Playback : playback 32 : capture =
1<br>

00-01: emu10k1 mic : Mic Capture : capture 1<br>

00-02: emu10k1 efx : Multichannel Capture/PT Playback : playback 8 : captur=
e 1<br>

00-03: emu10k1 : Multichannel Playback : playback 1<br>

cat: /proc/asound/seq/clients: No such file or directory<br>

<br>

Dev Snd ---------------------------------------------------<br>

controlC0&nbsp; midiC0D0&nbsp; pcmC0D0p&nbsp; pcmC0D2c&nbsp; pcmC0D3p<br>

hwC0D0&nbsp;&nbsp;&nbsp;&nbsp; pcmC0D0c&nbsp; pcmC0D1c&nbsp; pcmC0D2p&nbsp;=
 timer<br>

<br>

CPU -------------------------------------------------------<br>

model name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Intel(R) Pentium(R) 4 CPU 3.00GH=
z<br>

cpu MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 2992.835<br>

model name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Intel(R) Pentium(R) 4 CPU 3.00GH=
z<br>

cpu MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 2992.835<br>

<br>

RAM -------------------------------------------------------<br>

MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 514840 kB<br>

SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp; 1020116 kB<br>

<br>

Hardware --------------------------------------------------<br>

00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub (=
rev 02)<br>

02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a=
)<br>

<br>

<br>

<br>
Now, I still have sound... Somewhat.... It comes out the back two
speakers but not the front two. I can use the gnome sound control to
atleast get it to where I can hear something... I just can't open
alsamixer and tweak it out...<br>
>From the Troubleshooting list:<br>
<br>
<br>
1.) I am using alsa-driver and not the built-in kernel modules<br>
<br>
2.) [root@jaguar ~/Desktop] cat /proc/asound/version<br>
Advanced Linux Sound Architecture Driver Version 1.0.10.<br>
Compiled on Nov 18 2005 for kernel <a href=3D"http://2.6.14.2">2.6.14.2</a>=
 (SMP).<br>
<br>
3.) [root@jaguar ~/Desktop] grep VERSION_STR /usr/include/alsa/version.h<br=
>
#define SND_LIB_VERSION_STR&nbsp;&nbsp;&nbsp;&nbsp; &quot;1.0.10&quot;<br>
<br>
4.)  [root@jaguar ~/Desktop] cat /proc/asound/cards<br>
0 [Live&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]: EMU1=
0K1 - SB Live [Unknown]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SB Live [Unknown] (rev.10, serial:0x80661102) at 0xdda0, irq 21<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [root@jaguar ~/Desktop] lspci | egrep audio<=
br>
02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a=
)<br>
<br>
<br>
5.) [root@jaguar ~/Desktop] alsamixer<br>
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volu=
me',0,0,0) appears twice or more<br>
<br>
alsamixer: function snd_mixer_load failed: Invalid argument<br>
<br>
6.) I hate to admit it, but I ussually only run as root. From step 6 and be=
yond, it seems pretty trivial to do.<br>
<br>
<br>
<br>
Let me know if there is anything else I can provide and thank you James for=
 your help. I really do apprecieate it...<br>
<br>

------=_Part_31121_30368280.1132638509110--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
