From: Mathias Kretschmer <mathias@lemur.sytes.net>
Subject: VIA EPIA (VT1612A) and SPDIF
Date: Tue, 18 Feb 2003 19:17:47 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E52CD2B.7090505@lemur.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm wondering if anyone has SPDIF working on the
VIA EPIA ESP5000 under rc7?

Analog output is working fine for me using rc7 and the CVS via82xx 
module (1.25). But, I didn't have any luck getting SPDIF (PCM) to work 
using a Pioneer Digital Receiver.

Any success reports or any hints which knobs to turn to make it work ?

Cheers,

Mathias

Some info from /proc/asound:

[root@musicbox root]# cat /proc/asound/cards
0 [rev40          ]: VIA686A - VIA 82C686A/B rev40
                      VIA 82C686A/B rev40 at 0xdc00, irq 10

[root@musicbox root]# cat /proc/asound/card0/ac97#0
0-0/0: VIA Technologies VIA1612A

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : Reserved 27

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 SPDIF VRA
Extended status  : SPDIF=3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x2 Generation=1 
Rate=48kHz



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
