From: Stefan.Hagendorn@lindy.cc
Subject: intel8x0 mic input even with gain and 100% vol. too quietly
Date: Sat, 13 Jul 2002 15:21:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <agp9no$ktl$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I try to play with my microphone attached to my intel810 soundsystem. But 
even with 100% mic volume and +20db gain it is too silent. Is this a known 

problem of the I810 Chipset ???

Too silent means, I have to blow directly into the mic to hear anything 
... normal speak, even cry load doesn't realy help ...

Thanks in advance
Stefan

[root@voyager cvoicecontrol]# cat /proc/asound/cards
0 [card0          ]: ICH - Intel 82801BA-ICH2
                     Intel 82801BA-ICH2 at 0xe000, irq 10


[root@voyager cvoicecontrol]# cat /proc/asound/card0/ac97#0
0-0/0: Avance Logic ALC200/200P rev 0

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x2 Generation=1 
Rate=48kHz




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
