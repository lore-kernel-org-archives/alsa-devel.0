From: "John W. Cocula" <john@cocula.com>
Subject: Re: intel8x0.c doesn't do mic capture
Date: Tue, 20 Jan 2004 00:47:25 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <65317.138.88.11.209.1074577645.squirrel@cocula.com>
References: <65148.138.88.11.209.1074575164.squirrel@cocula.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <65148.138.88.11.209.1074575164.squirrel@cocula.com>
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

By the way, here is some information about the hardware in question:

$ cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 3

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 8000Hz  <-- why only 8k?
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked
$ cat /proc/asound/card0/codec97#0/ac97#0-0+regs
0:00 = 5980
0:02 = 0808
0:04 = 0000
0:06 = 0008
0:08 = 0000
0:0a = 0018
0:0c = 000e
0:0e = 805f
0:10 = 8909
0:12 = 8b0b
0:14 = 8b0b
0:16 = 0b0b
0:18 = 0909
0:1a = 0000
0:1c = 0f0f
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 05c7
0:2a = 05c1
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = 1f40
0:34 = 0000
0:36 = 8b9f
0:38 = 9f9f
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 0800
0:6c = 0000
0:6e = 0025
0:70 = 0231
0:72 = 00a0
0:74 = 0043
0:76 = 0000
0:78 = 8003
0:7a = 57c7
0:7c = 414c
0:7e = 4720


John W. Cocula said:
> Hi all,
>
> In early December, Takashi updated intel8x0.c to allow fixed rate mic
> capture, but it doesn't work on a Realtek ALC650 rev 3 chip.  It records
> snow.  Can anyone confirm/deny my finding, and can anyone tell me what *I*
> can do about it?  I haven't written a kernel device driver since 1989, but
> I'm willing to dive in and try to fix it, if someone can shine a light on
> the right path for me to follow.
>
> Thanks in advance to any ALSA developers who can help me help myself, and
> the project.
>
> Best,
> John
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
