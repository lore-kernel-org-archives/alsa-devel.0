From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Intel8x0 problems with rc1
Date: Tue, 02 Dec 2003 14:57:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCC9A49.3070300@undata.org>
References: <3FCB855F.7080505@undata.org>	<s5hd6b8fl1s.wl@alsa2.suse.de>	<s5h8ylwfk40.wl@alsa2.suse.de>	<3FCC7EC4.6050200@undata.org> <s5hn0abe7vm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0abe7vm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote :

> ok, then please check /proc/asound/card0/codec97#0/* files whether VRA
> is properly set to 44100Hz during the playback.
> 
> 
> Takashi
> 
> 

Bingo, it seems it's not, indeed :

thomas@satellite thomas $ cat /proc/asound/card0/codec97#0/*
0-0/0: Cirrus Logic CS4299 rev 4

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Crystal Semi 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 48000Hz
PCM ADC          : 44100Hz
SPDIF Control    : Consumer PCM Copyright Category=0x22 Generation=1 
Rate=48kHz

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
