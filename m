From: David Shirley <tephra@gmail.com>
Subject: nvidia initial sound being skipped
Date: Tue, 16 Nov 2010 21:05:23 +1100
Message-ID: <AANLkTikvSS+=SwVHOzr9sGmkJC6xuWFUHqnVH9_z-u7J@mail.gmail.com>
References: <AANLkTikH529TdvgfZX7bYvQVEHuj+1zTJS2YwjKc1yp_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5228F243A6
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 11:05:24 +0100 (CET)
Received: by bwz8 with SMTP id 8so452082bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 02:05:24 -0800 (PST)
In-Reply-To: <AANLkTikH529TdvgfZX7bYvQVEHuj+1zTJS2YwjKc1yp_@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Developers,

I am using an nvidia MCP78 to connect to a Denon 1910 AVR via HDMI.

I was using Kernel 2.6.32.21 and noticed that the initial few seconds
of my songs was being chopped off.

After seeing http://www.spinics.net/lists/alsa-devel/msg29408.html I
upgraded to 2.6.35.8 (which has that fix in it) and the problem was
been reduced considerably.

But it is still occurring to some extent.

So to see if the HDMI was the problem I changed it to coax spdif - no
change/same problem.

Now I think it could be mplayer, so I try audacious - no change/same proble=
m.

Now I think it could be the flac file/decoding, so I decode the flac
to wav and use aplay - no change/same problem.

The ONLY way I can get the first 0.5seconds of the file to play is by
using audacious and then MANUALLY rewinding (by dragging the scroll
bar thingy) back to the start... then it will play (on either flac or
wav)

Co-incidentally when I do this I get the following error message
dumped to console:
alsa: snd_pcm_prepare failed: Device or resource busy.

I hope someone can help :)

I am happy to get debug or whatever - just let me know what you need!

mythtv@crystal:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: ALC1200 Analog [ALC1200 Analog]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: ALC1200 Digital [ALC1200 Digital]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 3: NVIDIA HDMI [NVIDIA HDMI]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0

lspci -vvvv
00:07.0 Audio device: nVidia Corporation MCP72XE/MCP72P/MCP78U/MCP78S
High Definition Audio (rev a1)
=A0 =A0 =A0 =A0Subsystem: ASUSTeK Computer Inc. M3N72-D
=A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0 =A0 =A0 =A0Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAb=
ort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
=A0 =A0 =A0 =A0Latency: 0 (500ns min, 1250ns max)
=A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 11
=A0 =A0 =A0 =A0Region 0: Memory at fe020000 (32-bit, non-prefetchable) [siz=
e=3D16K]
=A0 =A0 =A0 =A0Capabilities: [44] Power Management version 2
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 NoSoftRst- PME-Enable- DSel=3D0 D=
Scale=3D0 PME-
=A0 =A0 =A0 =A0Kernel driver in use: HDA Intel

Cheers
David
