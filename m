From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: intel8x0 has stopped working.
Date: Mon, 02 Feb 2004 20:34:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401EA650.2030107@gmx.de>
References: <401E8BAE.6010802@superbug.demon.co.uk> <s5hn081uztv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id UAA23082
	for <alsa-devel@alsa-project.org>; Mon, 2 Feb 2004 20:35:20 +0100
In-Reply-To: <s5hn081uztv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> hmm, it looks like a generic problem of intel8x0 with ALC65x.
> in the recent version, the detection and implementation of PCM streams
> have been changed, and i guess it's broken for these codecs.

I would think the same. I told you/alsa list about oss emulation with 
mmap and quake3 problem (since first 1.0.0pre) as quake now detecs pcm 
rate of 48kHz, which was 22kHz before. (48kHz with quake3 didn't work in 
0.9.x alsa, as well.) Alsa release 1.0.2 seems to break several things, 
like xmms won't play with alsa using mmap (works with alsa1.0.1). Arts 
doesn't play with 48000kHz in xmms, and in 44,1kHz I get distorted 
sound. (I guess this was with earlier version, as well.) There were some 
other things I forgot.

I have ALC650, btw.

Dunno if it of help:

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
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked

bye,

Prakash


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
