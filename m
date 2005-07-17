From: Raymond <rayau@netvigator.com>
Subject: Re: AC97 codec odd behaviour (STAC9708/11) / Aureal Card IS SUPPORTED!
Date: Sun, 17 Jul 2005 12:12:05 +0800
Message-ID: <42D9DA95.3050002@netvigator.com>
References: <1055454710.889.30.camel@localhost>	<3EEFF6A5.6060102@boosthardware.com> <s5hptlb4kg3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptlb4kg3.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At 12 Jun 2003 17:51:50 -0400,
> Manuel Jander wrote:
> 
>>Hi everyone,
>>
>>I'm facing some odd things with a Aureal MX300 with a
>>AC97 codec. For some reason the AC97 interface doesnt
>>set the EAPD (external amp enable) bit correctly, and i have 
>>to set it explicitly after calling the ac97  mixer initializer.
>>
>>Maybe, that the AC97 codec write function actually implemented
>>for the Aureal cards "misses" some writes, but i just want to be sure
>>if this bit works for other cards with a STAC9708/11 or similar
>>codec that need this bit by default, or if i really need to set it
>>myself ??
> 
> 
> i recommend you to do this in the card driver level.
> 
> the use of EAPD is dependent upon the devices.  also, some uses EAPD
> pin for different purposes...
> 
> 
> 
According to datasheet of STAC9708, the general purpose register (0x20)
has 3D, MIX, MS, LPBK bits.

Is "POP" a undocumented feature of STAC9708 ?

Simple mixer control 'PCM Out Path & Mute',0
   Capabilities: enum
   Items: 'pre 3D' 'post 3D'
   Item0: 'post 3D'

0-0/0: SigmaTel STAC9708,11

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : post 3D        <-------------------------
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 SDAC DSA=0
Extended status  : SDAC

numid=43,iface=MIXER,name='PCM Out Path & Mute'
   ; type=ENUMERATED,access=rw---,values=1,items=2
   ; Item #0 'pre 3D'
   ; Item #1 'post 3D'
   : values=0


STAC9708 on other sound cards such as Soundblaster 4.1

http://thread.gmane.org/gmane.linux.alsa.devel/4818




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
