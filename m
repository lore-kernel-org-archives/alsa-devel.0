From: Richard Chan <rspchan@starhub.net.sg>
Subject: Re: Testers of via82xx 5.1 output - report - swapped output still there
Date: Thu, 20 Nov 2003 18:29:17 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBC977D.5000202@starhub.net.sg>
References: <3FBB8699.10602@starhub.net.sg> <s5hptfo1irr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hptfo1irr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

via82xx with ALC655/8 patch and 1.0.0pre1

Summary -
Swapped output 2,3==Center/LFE and 4,5==Surround
has not been fixed by the patch.

/proc/asound> cat version
Advanced Linux Sound Architecture Driver Version 1.0.0pre1.
Compiled on Nov 20 2003 for kernel 2.6.0-test9.2R.

/proc/asound> cat card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC655 rev 0
 
Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement
 
Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF
Extended status  : SPCV LDAC SDAC CDAC SPDIF=res SPDIF
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

/proc/asound> cat card0/codec97#0/ac97#0-0+regs
0:00 = 0000
0:02 = 0606
0:04 = 0000
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 0000
0:14 = 0000
0:16 = 9f1f
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0400
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 09c4
0:2a = 05f4
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
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
0:68 = 0aea
0:6a = 0600
0:6c = 0000
0:6e = 0004
0:70 = 81e0
0:72 = 22e8
0:74 = 8000
0:76 = 0000
0:78 = 0007
0:7a = 0042
0:7c = 414c
0:7e = 4760





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
