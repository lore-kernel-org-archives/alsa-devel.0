From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: quake3 and alsa trouble: resampler probably doesn't
 work properly?
Date: Thu, 15 Jan 2004 17:23:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4006BE9B.50802@gmx.de>
References: <3FF85629.5070507@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FF85629.5070507@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Perhaps this helps:

bash-2.05b# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 3

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
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 22050Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked

As I mailed, the error is still present in lastest alsa release
1.0.1. Any news? I got no response if this is taken as bug report or 
just being ignored.

bye,

Prakash

Prakash K. Cheemplavam wrote:
> Hi all,
> 
> I am using nforce2 with intel8x0 compiled into 2.6.1-rc1-mm1 based kernel.
> 
> if you just start quake3 then you will have no sound. If you apply the 
> famous cat "bla direct" > /bla/pcm/bla (and the other disable for 
> capture), then sound reappears. Ok. But as soon as I load a map (except 
> the very first one) quake will "soft freeze" ie you will hear a portion 
> of sound getting repeated and quake3 as such seems to be frozen. But you 
> can simple kill it and the rest of the system is not affected. I then 
> compiled debug into alsa and got this assert error in the "soft freeze":
> 
> ALSA sound/core/pcm_lib.c:61: BUG? (runtime->silence_filled <= 
> runtime->buffer_size) (called from c030c7ad)
> 
> (I got this error with alsa0.9.8, which can be provoked if you set 
> soundspeed to something high in the quake config, setting it to 0 quake 
> works with alsa 0.9.8, but not with latest alsa)
> 
> I treid setting the other alsa-oss options (read in the alsa 
> Documentation about alsa-oss) , as well, but didn't help. I noticed that 
> the "whole-frag" option didn't appear, even if I cat it into the proc 
> setting. might that be the problem? I looked into the source and this 
> option isn't there, so docs are not up to date.
> 
> 
> 
> So, I have an idea, what is wrong with alsa1.x. When using alsa 0.9.8:
> 
> ------- sound initialization -------
> ------------------------------------
> ----- Sound Info -----
> sound system is muted
> 1 stereo
> 32768 samples
> 16 samplebits
> 1 submission_chunk
> 22050 speed
> 0x46a0c000 dma buffer
> No background file.
> 
> 
> and quake3 works. Whereas with alsa1.x speed is set to 48000, no matter 
> what I set in the config file. Furthermore *if* I set sndspeed to 48000 
> then quake3 hangs also with alsa 0.9.8.
> 
> So my conclusion: There is something wrong with alsa resampler. This 
> also can be seen in other instances and reports users have filed in. I 
> hope this gets fixed soon.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
