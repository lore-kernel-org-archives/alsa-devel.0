From: Mark Knecht <markknecht@comcast.net>
Subject: Re: VT8233/A/8235 Clock Problem
Date: Mon, 08 Dec 2003 12:16:55 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070914615.1921.24.camel@Wizard.knechthome.com>
References: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: drclaw@dogsolitude.org, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-12-08 at 01:05, Clemens Ladisch wrote:
> This is a module option; instead of changing this line, you are
> supposed to put the following line into modules.conf:
> 
>   options snd-via82xx ac97_clock=44100
> 
> (or, if an options line for this module already exists, add it there)
> 
> 
> HTH
> Clemens

Clemens,
   Hi. This option did not fix my sound problems with the Via 8235. It
still sounds like it's resampling the sound. I hear artifacts all over
the place. 

   I do think the option worked since the PCM stuff now says it's
running at 44100, but I wonder if there is another option for the spdif
side, or is there a bug in that the driver should be setting this at the
same time? I'm not using spdif on this motherboard, but possibly when it
runs at 48K that makes the hardware do something to the PCM data?

   alsaplayer and xmms both sound equally bad though OSS. alsaplayer
says it's playing at 44100. alsaplayer through Jack and my HDSP 9652
sounds good.

   Any other ideas about what to try?

- Mark


Wizard root # !cat
cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=res SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 44100Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked
Wizard root # 




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
