From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: why would i *not* be able to update a register in
 ac97#0-0+regs when it's read write?
Date: Tue, 20 Feb 2007 09:46:59 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF899@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF896@sea-exch-01.na.corp.dmxmusic.com>
	<75b66ecd0702161724ncd340a8o1feea138fa98963c@mail.gmail.com>
	<F8FB97052F1BEF409F7842E960E49B5AAAF897@sea-exch-01.na.corp.dmxmusic.com>
	<75b66ecd0702161801l3e1492c3j37e001bbf57eaac9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0482135723=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0482135723==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75517.1ECF8DAC"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75517.1ECF8DAC
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

once again, plz forgive the lack of proper citing.

my delayed response is due to the fact that the previously 3 days was a =
holiday weekend.

-----Original Message-----
From: rlrevell@gmail.com on behalf of Lee Revell
Sent: Fri 2/16/2007 6:01 PM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?
=20
On 2/16/07, John Utz <John.Utz@dmxmusic.com> wrote:
>  i think the configure help should be changed; what would you conclude =
from
> this list:
>
>   --with-debug=3Dlevel      give the debug level =
(none,basic,full,detect)
>
>  to me, this certainly implies detect>full>basic>none
>

Agreed.

Good, i am not crazy :-)

Anyway, i went back and reconfigured/recompiled/reinstalled/remodprobed =
as --with-debug=3Dfull

Nothing changed, i can still write to many registers but not the 1 that =
i am attempting to change: 60h UAJ Control; Does the '(Page ID =3D 00h)' =
alter how i need to access the register?:

Vendor Defined Register (Page ID =3D 00h)
UAJ Control
Index: 60h                                                           =
Default Value: 0038h
    Bit     Attr. Description
   15:6      RO   Reserved
    5:4     RW    UAJ_2 (pin 21/22) Control
                  00: Reserved
                  01: Output from DAC_2 without analog mixing
                  10: Input as Line-In signal
                  11: Input as MIC1 & MIC2 signals (default)
    3:2     RW    UAJ_1 (pin 23/24) Control
                  00: Reserved
                  01: Output from DAC_1 without analog mixing
                  10: Input as Line-In signal (default)
                  11: Input as MIC1 & MIC2 signals
    1:0     RW    UAJ_0 (pin 35/36) Control
                  00: Output from DAC_0 with analog mixing (default)
                  01: Output from DAC_0 without analog mixing
                  10: Input as Line-In signal
                  11: Input as MIC1 & MIC2 signals


>  there are two issues:
>
>  1. attempting to write to registers that are documented to be =
read-write
> doesnt
>     result in a change of value; how do i debug this?
>

The mode in /proc is misleading but the documentation in
Documentation/ALSA-Configuration.txt is correct.

What portion of that documentation are you refering to?

Note that I can change lots of other registers to my heart's content.


>  2. i have an msi motherboard with a via8237Rplus and a vt1618 8ch =
codec. it
> has only
>     three plugs on the back that default to a stereo out, line in and =
mic
> in.
>
>     they are supposed to be 'Universal Audio Jacks' and thus =
reconfigurable
> in the manner
>     mentioned in the documentation that i listed previously - i wont =
really
> know if i have this
>     write until i get the write to work
>

How do you know that surround out from this device isn't already =
supported?

Does:

speaker-test -c 6 -Dsurround51

produce output on all speakers?

That's a very reasonable question to ask;=20

No, it does not, otherwise i wouldnt be attempting to manipulate =
registers involved with causing the mic and line input plugs to be =
repurposed as center/lfe and surround outputs.

What is the output of "amixer"?


Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [-9.00dB] [on]
  Front Right: Playback 25 [81%] [-9.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [3.00dB] [on]
  Front Right: Playback 25 [81%] [3.00dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [-9.00dB] [on]
  Front Right: Playback 25 [81%] [-9.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 25 [81%] [-9.00dB] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 25 [81%] [-9.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch =
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [off]
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch =
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [-34.50dB] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 0 [0%] [-45.00dB] [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [on]
  Front Right: Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Input Source Select',0
  Capabilities: enum
  Items: 'Input1' 'Input2'
  Item0: 'Input1'
Simple mixer control 'Input Source Select',1
  Capabilities: enum
  Items: 'Input1' 'Input2'
  Item0: 'Input1'
Simple mixer control 'VIA DXS',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [-48.00dB]
  Front Right: Playback 31 [100%] [-48.00dB]
Simple mixer control 'VIA DXS',1
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [-48.00dB]
  Front Right: Playback 31 [100%] [-48.00dB]
Simple mixer control 'VIA DXS',2
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [-48.00dB]
  Front Right: Playback 31 [100%] [-48.00dB]
Simple mixer control 'VIA DXS',3
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [-48.00dB]
  Front Right: Playback 31 [100%] [-48.00dB]


Lee



------_=_NextPart_001_01C75517.1ECF8DAC
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>once again, plz forgive the lack of proper citing.<BR>
<BR>
my delayed response is due to the fact that the previously 3 days was a =
holiday weekend.<BR>
<BR>
-----Original Message-----<BR>
From: rlrevell@gmail.com on behalf of Lee Revell<BR>
Sent: Fri 2/16/2007 6:01 PM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?<BR>
<BR>
On 2/16/07, John Utz &lt;John.Utz@dmxmusic.com&gt; wrote:<BR>
&gt;&nbsp; i think the configure help should be changed; what would you =
conclude from<BR>
&gt; this list:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp; --with-debug=3Dlevel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; give =
the debug level (none,basic,full,detect)<BR>
&gt;<BR>
&gt;&nbsp; to me, this certainly implies =
detect&gt;full&gt;basic&gt;none<BR>
&gt;<BR>
<BR>
Agreed.<BR>
<BR>
Good, i am not crazy :-)<BR>
<BR>
Anyway, i went back and reconfigured/recompiled/reinstalled/remodprobed =
as --with-debug=3Dfull<BR>
<BR>
Nothing changed, i can still write to many registers but not the 1 that =
i am attempting to change: 60h UAJ Control; Does the '(Page ID =3D 00h)' =
alter how i need to access the register?:<BR>
<BR>
Vendor Defined Register (Page ID =3D 00h)<BR>
UAJ Control<BR>
Index: =
60h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Default =
Value: 0038h<BR>
&nbsp;&nbsp;&nbsp; Bit&nbsp;&nbsp;&nbsp;&nbsp; Attr. Description<BR>
&nbsp;&nbsp; 15:6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RO&nbsp;&nbsp; =
Reserved<BR>
&nbsp;&nbsp;&nbsp; 5:4&nbsp;&nbsp;&nbsp;&nbsp; RW&nbsp;&nbsp;&nbsp; =
UAJ_2 (pin 21/22) Control<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00: Reserved<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01: Output from DAC_2 without analog =
mixing<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10: Input as Line-In signal<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11: Input as MIC1 &amp; MIC2 signals =
(default)<BR>
&nbsp;&nbsp;&nbsp; 3:2&nbsp;&nbsp;&nbsp;&nbsp; RW&nbsp;&nbsp;&nbsp; =
UAJ_1 (pin 23/24) Control<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00: Reserved<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01: Output from DAC_1 without analog =
mixing<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10: Input as Line-In signal (default)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11: Input as MIC1 &amp; MIC2 signals<BR>
&nbsp;&nbsp;&nbsp; 1:0&nbsp;&nbsp;&nbsp;&nbsp; RW&nbsp;&nbsp;&nbsp; =
UAJ_0 (pin 35/36) Control<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00: Output from DAC_0 with analog mixing =
(default)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01: Output from DAC_0 without analog =
mixing<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10: Input as Line-In signal<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11: Input as MIC1 &amp; MIC2 signals<BR>
<BR>
<BR>
&gt;&nbsp; there are two issues:<BR>
&gt;<BR>
&gt;&nbsp; 1. attempting to write to registers that are documented to be =
read-write<BR>
&gt; doesnt<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; result in a change of value; how do i debug =
this?<BR>
&gt;<BR>
<BR>
The mode in /proc is misleading but the documentation in<BR>
Documentation/ALSA-Configuration.txt is correct.<BR>
<BR>
What portion of that documentation are you refering to?<BR>
<BR>
Note that I can change lots of other registers to my heart's =
content.<BR>
<BR>
<BR>
&gt;&nbsp; 2. i have an msi motherboard with a via8237Rplus and a vt1618 =
8ch codec. it<BR>
&gt; has only<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; three plugs on the back that default to a =
stereo out, line in and mic<BR>
&gt; in.<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; they are supposed to be 'Universal Audio =
Jacks' and thus reconfigurable<BR>
&gt; in the manner<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; mentioned in the documentation that i =
listed previously - i wont really<BR>
&gt; know if i have this<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; write until i get the write to work<BR>
&gt;<BR>
<BR>
How do you know that surround out from this device isn't already =
supported?<BR>
<BR>
Does:<BR>
<BR>
speaker-test -c 6 -Dsurround51<BR>
<BR>
produce output on all speakers?<BR>
<BR>
That's a very reasonable question to ask;<BR>
<BR>
No, it does not, otherwise i wouldnt be attempting to manipulate =
registers involved with causing the mic and line input plugs to be =
repurposed as center/lfe and surround outputs.<BR>
<BR>
What is the output of &quot;amixer&quot;?<BR>
<BR>
<BR>
Simple mixer control 'Master',0<BR>
&nbsp; Capabilities: pvolume pswitch pswitch-joined<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono:<BR>
&nbsp; Front Left: Playback 25 [81%] [-9.00dB] [on]<BR>
&nbsp; Front Right: Playback 25 [81%] [-9.00dB] [on]<BR>
Simple mixer control 'PCM',0<BR>
&nbsp; Capabilities: pvolume pswitch pswitch-joined<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono:<BR>
&nbsp; Front Left: Playback 25 [81%] [3.00dB] [on]<BR>
&nbsp; Front Right: Playback 25 [81%] [3.00dB] [on]<BR>
Simple mixer control 'Surround',0<BR>
&nbsp; Capabilities: pvolume pswitch<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono:<BR>
&nbsp; Front Left: Playback 25 [81%] [-9.00dB] [on]<BR>
&nbsp; Front Right: Playback 25 [81%] [-9.00dB] [on]<BR>
Simple mixer control 'Center',0<BR>
&nbsp; Capabilities: pvolume pvolume-joined pswitch pswitch-joined<BR>
&nbsp; Playback channels: Mono<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono: Playback 25 [81%] [-9.00dB] [off]<BR>
Simple mixer control 'LFE',0<BR>
&nbsp; Capabilities: pvolume pvolume-joined pswitch pswitch-joined<BR>
&nbsp; Playback channels: Mono<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono: Playback 25 [81%] [-9.00dB] [on]<BR>
Simple mixer control 'Line',0<BR>
&nbsp; Capabilities: pvolume pswitch pswitch-joined cswitch =
cswitch-exclusive<BR>
&nbsp; Capture exclusive group: 0<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]<BR>
&nbsp; Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]<BR>
Simple mixer control 'CD',0<BR>
&nbsp; Capabilities: pvolume pswitch pswitch-joined cswitch =
cswitch-exclusive<BR>
&nbsp; Capture exclusive group: 0<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]<BR>
&nbsp; Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]<BR>
Simple mixer control 'Mic',0<BR>
&nbsp; Capabilities: pvolume pvolume-joined pswitch pswitch-joined =
cswitch cswitch-exclusive<BR>
&nbsp; Capture exclusive group: 0<BR>
&nbsp; Playback channels: Mono<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono: Playback 0 [0%] [-34.50dB] [off]<BR>
&nbsp; Front Left: Capture [on]<BR>
&nbsp; Front Right: Capture [on]<BR>
Simple mixer control 'Mic Boost (+20dB)',0<BR>
&nbsp; Capabilities: pswitch pswitch-joined<BR>
&nbsp; Playback channels: Mono<BR>
&nbsp; Mono: Playback [off]<BR>
Simple mixer control 'Mic Select',0<BR>
&nbsp; Capabilities: enum<BR>
&nbsp; Items: 'Mic1' 'Mic2'<BR>
&nbsp; Item0: 'Mic1'<BR>
Simple mixer control 'Video',0<BR>
&nbsp; Capabilities: cswitch cswitch-exclusive<BR>
&nbsp; Capture exclusive group: 0<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Front Left: Capture [off]<BR>
&nbsp; Front Right: Capture [off]<BR>
Simple mixer control 'Phone',0<BR>
&nbsp; Capabilities: pvolume pvolume-joined pswitch pswitch-joined =
cswitch cswitch-exclusive<BR>
&nbsp; Capture exclusive group: 0<BR>
&nbsp; Playback channels: Mono<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono: Playback 0 [0%] [-34.50dB] [off]<BR>
&nbsp; Front Left: Capture [off]<BR>
&nbsp; Front Right: Capture [off]<BR>
Simple mixer control 'PC Speaker',0<BR>
&nbsp; Capabilities: pvolume pvolume-joined pswitch pswitch-joined<BR>
&nbsp; Playback channels: Mono<BR>
&nbsp; Limits: Playback 0 - 15<BR>
&nbsp; Mono: Playback 0 [0%] [-45.00dB] [off]<BR>
Simple mixer control 'Aux',0<BR>
&nbsp; Capabilities: pvolume pswitch pswitch-joined cswitch =
cswitch-exclusive<BR>
&nbsp; Capture exclusive group: 0<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Front Left: Playback 0 [0%] [-34.50dB] [off] Capture [off]<BR>
&nbsp; Front Right: Playback 0 [0%] [-34.50dB] [off] Capture [off]<BR>
Simple mixer control 'Capture',0<BR>
&nbsp; Capabilities: cvolume cswitch cswitch-joined<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Limits: Capture 0 - 15<BR>
&nbsp; Front Left: Capture 0 [0%] [0.00dB] [on]<BR>
&nbsp; Front Right: Capture 0 [0%] [0.00dB] [on]<BR>
Simple mixer control 'Mix',0<BR>
&nbsp; Capabilities: cswitch cswitch-exclusive<BR>
&nbsp; Capture exclusive group: 0<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Front Left: Capture [off]<BR>
&nbsp; Front Right: Capture [off]<BR>
Simple mixer control 'Mix Mono',0<BR>
&nbsp; Capabilities: cswitch cswitch-exclusive<BR>
&nbsp; Capture exclusive group: 0<BR>
&nbsp; Capture channels: Front Left - Front Right<BR>
&nbsp; Front Left: Capture [off]<BR>
&nbsp; Front Right: Capture [off]<BR>
Simple mixer control 'External Amplifier',0<BR>
&nbsp; Capabilities: pswitch pswitch-joined<BR>
&nbsp; Playback channels: Mono<BR>
&nbsp; Mono: Playback [on]<BR>
Simple mixer control 'Input Source Select',0<BR>
&nbsp; Capabilities: enum<BR>
&nbsp; Items: 'Input1' 'Input2'<BR>
&nbsp; Item0: 'Input1'<BR>
Simple mixer control 'Input Source Select',1<BR>
&nbsp; Capabilities: enum<BR>
&nbsp; Items: 'Input1' 'Input2'<BR>
&nbsp; Item0: 'Input1'<BR>
Simple mixer control 'VIA DXS',0<BR>
&nbsp; Capabilities: pvolume<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono:<BR>
&nbsp; Front Left: Playback 31 [100%] [-48.00dB]<BR>
&nbsp; Front Right: Playback 31 [100%] [-48.00dB]<BR>
Simple mixer control 'VIA DXS',1<BR>
&nbsp; Capabilities: pvolume<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono:<BR>
&nbsp; Front Left: Playback 31 [100%] [-48.00dB]<BR>
&nbsp; Front Right: Playback 31 [100%] [-48.00dB]<BR>
Simple mixer control 'VIA DXS',2<BR>
&nbsp; Capabilities: pvolume<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono:<BR>
&nbsp; Front Left: Playback 31 [100%] [-48.00dB]<BR>
&nbsp; Front Right: Playback 31 [100%] [-48.00dB]<BR>
Simple mixer control 'VIA DXS',3<BR>
&nbsp; Capabilities: pvolume<BR>
&nbsp; Playback channels: Front Left - Front Right<BR>
&nbsp; Limits: Playback 0 - 31<BR>
&nbsp; Mono:<BR>
&nbsp; Front Left: Playback 31 [100%] [-48.00dB]<BR>
&nbsp; Front Right: Playback 31 [100%] [-48.00dB]<BR>
<BR>
<BR>
Lee<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75517.1ECF8DAC--



--===============0482135723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0482135723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0482135723==--
