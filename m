From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB recording - repetitive peaks
Date: Wed, 03 Jul 2002 00:35:03 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D21C827.2060602@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de>	<s5hhejibem0.wl@alsa2.suse.de>	<3D21B878.8090902@boosthardware.com> <s5hy9curxdr.wl@alsa2.suse.de>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi Patrick,
> 
> At Tue, 02 Jul 2002 23:28:08 +0900,
> Patrick Shirkey wrote:
> 
>>Thanks to your patch Takashi we have two people who have been able to 
>>record through the quattro.
>>
>>We have both found that there is a constant repetitive peak in the 
>>signal which reminds me of the problems I had with the cmipci for a 
>>brief period.
>>
>>Thorsten Hass has recorded a perfect example for you which he did using 
>>aplay and arecord. It is a sine wave so is easy on the ears.
>>
>>http://www.thorstenhaas.de/alsa/audio.file
> 
>  
> hmm, this sounds like the mismatching of packet size and copy
> destination.  i heard your ogg file, and this was similar, too.
> 
> under which condition were they recorded?
> with 24bit/96kHz/2ch?
> or does it happen generally on every condition?
> 

They were arecord -f cd

> you can see the running status and condition on streamX proc file
> during playback/capture.
> 

----
# cat /proc/asound/card2/stream1
M Audio USB AudioSport Quattro (tm) : USB Audio #1

Playback:
   Status: Stop
   Altset 3
     Format: S16_LE
     Channels: 2
     Endpoint: 3 OUT (ADAPTIVE)
     Rates: 11025, 22050, 44100, 48000
   Altset 2
     Format: S24_3LE
     Channels: 2
     Endpoint: 3 OUT (ADAPTIVE)
     Rates: 11025, 22050, 44100, 48000
   Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 3 OUT (ADAPTIVE)
     Rates: 88200, 96000

Capture:
   Status: Running
     Packets = 20
     URBs = 5
     Packet Size = 192
     Nominal freq = 44.          1682  Altset 3
     Format: S16_LE
     Channels: 2
     Endpoint: 5 IN (SYNC)
     Rates: 11025, 22050, 44100, 48000
   Altset 2
     Format: S24_3LE
     Channels: 2
     Endpoint: 5 IN (SYNC)
     Rates: 11025, 22050, 44100, 48000
   Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 5 IN (SYNC)
     Rates: 88200, 96000

----


> 
> 
>>He has also generated a jpeg plotted by an oscilloscope while recording 
>>which I can send you if it will help.
> 
> 
> can you figure out how long the period of puls is?

They are so regular you can set a use them as a metronome:) Would you 
like me to have a look at the timing in an editor or is there an more 
precise way to find out?

> i guess this has relation between the status shown in the proc file
> above.
> 
> 
> Takashi
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
