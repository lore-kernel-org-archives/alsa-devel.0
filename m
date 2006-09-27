From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Issue with Intel HDA Sound card : 82801G
Date: Wed, 27 Sep 2006 10:58:55 -0700
Message-ID: <1159379935.7201.250.camel@razman>
References: <1159377385.451ab1e99c682@imp7-g19.free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0045949760=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1159377385.451ab1e99c682@imp7-g19.free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: albox@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0045949760==
Content-Type: multipart/alternative; boundary="=-BPt1nFWqHMJITUYR10a/"


--=-BPt1nFWqHMJITUYR10a/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

You didn't mention which version of alsa driver this is
(cat /proc/asound/version).  Depeding on the version, you could try
adding "options snd model=acer" to your /etc/modprobe.conf file and see
if that works.  If this doesn't work, try downloading and building the
latest version of alsa (1.0.13rc3).  If it works with this option, we
can (hopefully) get it added before 1.0.13 final (~Friday).

Tobin Davis

On Wed, 2006-09-27 at 19:16 +0200, albox@free.fr wrote:

> Hi,
> 
> I've just installed Ubuntu Dapper on my laptop (this model came out very
> recently and was made by a french brand called Medion) and I can't get my sound
> card works.
> 
> Everything loads fine, all the modules seems to be installed successfully. Even
> if the volume is at its maximum, there is no sound at all.
> 
> Could you help me to resolve this issue ?
> 
> Here is all the information regarding my machine that I thought could be
> relevant to this issue.
> 
> $ lspci -v | grep -i audio
> 0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition Audio
> Controller (rev 02)
> 
> $ lspci -nv
> ...
> 0000:00:1b.0 0403: 8086:27d8 (rev 02)
>         Subsystem: 161f:2054
>         Flags: bus master, fast devsel, latency 0, IRQ 58
>         Memory at d5300000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: <available only to root>
> 
> $ lsmod | grep hda
> snd_hda_intel          21332  0
> snd_hda_codec         180944  1 snd_hda_intel
> snd_pcm                88004  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
> snd                    61604  6
> snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
> snd_page_alloc         11336  2 snd_hda_intel,snd_pcm
> 
> cat /proc/asound/card0/codec#0
> Codec: Realtek ALC883
> Address: 0
> Vendor Id: 0x10ec0883
> Subsystem Id: 0x161fd82b
> Revision Id: 0x100002
> Default PCM: rates 0x560, bits 0x0e, types 0x1
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x02 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x03 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x04 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x05 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
>   PCM: rates 0x560, bits 0x1e, types 0x1
> Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80]
>   PCM: rates 0x160, bits 0x06, types 0x1
>   Connection: 1
>      0x23
> Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x00 0x00]
>   PCM: rates 0x160, bits 0x06, types 0x1
>   Connection: 1
>      0x22
> Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
>   PCM: rates 0x560, bits 0x1e, types 0x1
>   Connection: 1
>      0x1f
> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x1f 0x1f] [0x00 0x00] [0x06 0x06] [0x00 0x00] [0x00 0x00]
> [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 10
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x1f 0x1f]
>   Connection: 2
>      0x02 0x0b
> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x06 0x06]
>   Connection: 2
>      0x03 0x0b
> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x0b 0x07]
>   Connection: 2
>      0x04 0x0b
> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x05 0x0b
> Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x01011110: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x01011112: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d* 0x0e 0x0f 0x26
> Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x01011111: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x20: IN
>   Connection: 5
>      0x0c 0x0d 0x0e 0x0f* 0x26
> Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08173e: IN OUT HP Detect
>   Pin Default 0x02a11c3f: [Jack] Mic at Ext Front
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x24: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08173e: IN OUT HP Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x20: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08173e: IN OUT HP Detect
>   Pin Default 0x99830130: [Fixed] Line In at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x20: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x08173e: IN OUT HP Detect
>   Pin Default 0x0221111f: [Jack] HP Out at Ext Front
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0xc0: OUT HP
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x00:
> Node 0x1d [Pin Complex] wcaps 0x400000: Mono
>   Pincap 0x0820: IN
>   Pin Default 0x99830131: [Fixed] Line In at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x00:
> Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear
>     Conn = Optical, Color = Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x06
> Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
>   Pincap 0x0820: IN
>   Pin Default 0x01c46160: [Jack] SPDIF In at Ext Rear
>     Conn = RCA, Color = Orange
>   Pin-ctls: 0x00:
> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x80 0x80]
> [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00]
> [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x25 [Audio Output] wcaps 0x11: Stereo
>   PCM: rates 0x560, bits 0x0e, types 0x1
> Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x25 0x0b
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-BPt1nFWqHMJITUYR10a/
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
You didn't mention which version of alsa driver this is (cat /proc/asound/version).&nbsp; Depeding on the version, you could try adding &quot;options snd model=acer&quot; to your /etc/modprobe.conf file and see if that works.&nbsp; If this doesn't work, try downloading and building the latest version of alsa (1.0.13rc3).&nbsp; If it works with this option, we can (hopefully) get it added before 1.0.13 final (~Friday).<BR>
<BR>
Tobin Davis<BR>
<BR>
On Wed, 2006-09-27 at 19:16 +0200, albox@free.fr wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi,</FONT>

<FONT COLOR="#000000">I've just installed Ubuntu Dapper on my laptop (this model came out very</FONT>
<FONT COLOR="#000000">recently and was made by a french brand called Medion) and I can't get my sound</FONT>
<FONT COLOR="#000000">card works.</FONT>

<FONT COLOR="#000000">Everything loads fine, all the modules seems to be installed successfully. Even</FONT>
<FONT COLOR="#000000">if the volume is at its maximum, there is no sound at all.</FONT>

<FONT COLOR="#000000">Could you help me to resolve this issue ?</FONT>

<FONT COLOR="#000000">Here is all the information regarding my machine that I thought could be</FONT>
<FONT COLOR="#000000">relevant to this issue.</FONT>

<FONT COLOR="#000000">$ lspci -v | grep -i audio</FONT>
<FONT COLOR="#000000">0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition Audio</FONT>
<FONT COLOR="#000000">Controller (rev 02)</FONT>

<FONT COLOR="#000000">$ lspci -nv</FONT>
<FONT COLOR="#000000">...</FONT>
<FONT COLOR="#000000">0000:00:1b.0 0403: 8086:27d8 (rev 02)</FONT>
<FONT COLOR="#000000">        Subsystem: 161f:2054</FONT>
<FONT COLOR="#000000">        Flags: bus master, fast devsel, latency 0, IRQ 58</FONT>
<FONT COLOR="#000000">        Memory at d5300000 (64-bit, non-prefetchable) [size=16K]</FONT>
<FONT COLOR="#000000">        Capabilities: &lt;available only to root&gt;</FONT>

<FONT COLOR="#000000">$ lsmod | grep hda</FONT>
<FONT COLOR="#000000">snd_hda_intel          21332  0</FONT>
<FONT COLOR="#000000">snd_hda_codec         180944  1 snd_hda_intel</FONT>
<FONT COLOR="#000000">snd_pcm                88004  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss</FONT>
<FONT COLOR="#000000">snd                    61604  6</FONT>
<FONT COLOR="#000000">snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer</FONT>
<FONT COLOR="#000000">snd_page_alloc         11336  2 snd_hda_intel,snd_pcm</FONT>

<FONT COLOR="#000000">cat /proc/asound/card0/codec#0</FONT>
<FONT COLOR="#000000">Codec: Realtek ALC883</FONT>
<FONT COLOR="#000000">Address: 0</FONT>
<FONT COLOR="#000000">Vendor Id: 0x10ec0883</FONT>
<FONT COLOR="#000000">Subsystem Id: 0x161fd82b</FONT>
<FONT COLOR="#000000">Revision Id: 0x100002</FONT>
<FONT COLOR="#000000">Default PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Default Amp-In caps: N/A</FONT>
<FONT COLOR="#000000">Default Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">Node 0x02 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x03 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x04 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x05 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x1e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM: rates 0x160, bits 0x06, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x23</FONT>
<FONT COLOR="#000000">Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  PCM: rates 0x160, bits 0x06, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x22</FONT>
<FONT COLOR="#000000">Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x1e, types 0x1</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x1f</FONT>
<FONT COLOR="#000000">Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x1f 0x1f] [0x00 0x00] [0x06 0x06] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Connection: 10</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17</FONT>
<FONT COLOR="#000000">Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x1f 0x1f]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x02 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x06 0x06]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x03 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x0b 0x07]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x04 0x0b</FONT>
<FONT COLOR="#000000">Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x05 0x0b</FONT>
<FONT COLOR="#000000">Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x083e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01011110: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x083e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01011112: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d* 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x083e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x01011111: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d 0x0e* 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x083e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c 0x0d 0x0e 0x0f* 0x26</FONT>
<FONT COLOR="#000000">Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08173e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x02a11c3f: [Jack] Mic at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x24: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08173e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Pincap 0x08173e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x99830130: [Fixed] Line In at Int ATAPI</FONT>
<FONT COLOR="#000000">    Conn = ATAPI, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Pincap 0x08173e: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x0221111f: [Jack] HP Out at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0xc0: OUT HP</FONT>
<FONT COLOR="#000000">  Connection: 5</FONT>
<FONT COLOR="#000000">     0x0c* 0x0d 0x0e 0x0f 0x26</FONT>
<FONT COLOR="#000000">Node 0x1c [Pin Complex] wcaps 0x400001: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">Node 0x1d [Pin Complex] wcaps 0x400000: Mono</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x99830131: [Fixed] Line In at Int ATAPI</FONT>
<FONT COLOR="#000000">    Conn = ATAPI, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0810: OUT</FONT>
<FONT COLOR="#000000">  Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = Optical, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x06</FONT>
<FONT COLOR="#000000">Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x01c46160: [Jack] SPDIF In at Ext Rear</FONT>
<FONT COLOR="#000000">    Conn = RCA, Color = Orange</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono</FONT>
<FONT COLOR="#000000">Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 11</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b</FONT>
<FONT COLOR="#000000">Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00]</FONT>
<FONT COLOR="#000000">[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 11</FONT>
<FONT COLOR="#000000">     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b</FONT>
<FONT COLOR="#000000">Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>
<FONT COLOR="#000000">Node 0x25 [Audio Output] wcaps 0x11: Stereo</FONT>
<FONT COLOR="#000000">  PCM: rates 0x560, bits 0x0e, types 0x1</FONT>
<FONT COLOR="#000000">Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x00 0x00] [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x25 0x0b</FONT>

<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys -- and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Alsa-devel mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-BPt1nFWqHMJITUYR10a/--



--===============0045949760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0045949760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0045949760==--
