From: Sagi Bashari <sagi@boom.org.il>
Subject: Re: Multiple Audio Streams
Date: Mon, 07 Oct 2002 12:24:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA160E7.10608@boom.org.il>
References: <3D9F3D84.4040102@boom.org.il> <1033859918.1118.24.camel@duron> <3DA15968.1000205@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: AthlonRob <athlonrob@data.4t3.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:

> AthlonRob wrote:
>
>> On Sat, 2002-10-05 at 12:29, Sagi Bashari wrote:
>>  
>>
>>> No answer on the users list, forwarding to devel.
>>>   
>>
>>
>> Yes... let me go ahead and re-hash this for those who don't want to read
>> through the earlier email.
>>
>> Sagi and I have two different soundcards with somewhat similar, yet
>> different, problems.  (Ambigious enough?)
>>
>> His soundcard theoretically supports hardware mixing both in actual
>> hardware and in the ALSA drivers, yet when he tries to open a second
>> audio stream, the application attempting to do so simply hangs until the
>> resource is free.  I think he said his card was a GTXP... I am
>> unfamiliar with it.
>>
>> My soundcard also supports hardware mixing, but only in the hardware..
>> not in the ALSA drivers.  Perhaps two threads would be ideal.  Oh 
>> well. I'm running on an nForce board using its integrated audio.  The 
>> drivers
>> nVidia provided (for OSS) simply consisted of an Intel i810 audio
>> patch.  I guess y'all on the ALSA team were able to utilize the
>> nVidia-released patch and do the same thing to the ALSA i810 drivers.
>>
>> Anyway... Sagi needs to know how to get the multiple streams working on
>> his card, globally.
>>
>> I need to know if it is possible to get the nForce (using the patched
>> i810 driver) to support hardware mixing so I can send many audio streams
>> to it at once.  I have basically no programming experience, but may have
>> a few friends who could help me if I had some clue of the how or the why
>> of it.  Alternatively, since I cannot afford to send anybody hardware...
>> if somebody was really interested in working on this, I could give you
>> ssh access and work with me, here, physically... but I don't know how
>> useful or feasable such a thing would be.
>>
>> Anyway... input on either or both topics by you guys who really know
>> what you're doing would be much apperciated!  :-)
>>
>> Rob
>>
>>  
>>
> mypc: /proc/asound/card0/pcm0p# cat info
> card: 0
> device: 0
> subdevice: 0
> stream: PLAYBACK
> id: CS4231
> name: Yamaha OPL3-SA23
> subname: subdevice #0
> class: 0
> subclass: 0
> subdevices_count: 1
> subdevices_avail: 1   <- This tells you how many streams the sound 
> card can handle in hardware at the same time.
> E.g. Only one application at a time can use the card.

This is what I get:

[sagi@beep pcm0p]$ cat info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: CS46xx
name: CS46xx
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
[sagi@beep pcm0p]$

>
>
> As you can see, my old sound card can only handle one stream at once 
> in hardware. Alsa does not do any software mixing.
> I also have a SB Live in another machine, the subdevices_avail is then 
> 32 because the SB Live can handle 32 streams at once in hardware.


Yes, that's the strange thing. According to the output it only supports 
1 subdevice, but the soundcard matrix says it does support hardware 
mixing (and I know that it does, it works perfectly on other OSs).

Does this mean that there's no real ALSA support for the Hardware mixing 
using this chip? If yes, why is it listed in the website with this option?

>
>
> There are other applications/tools you can use, one of which is "JACK" 
> that allows for multiple audio streams mixed in software and lots of 
> other cool stuff.

I used ARTS until now. But I don't want to use software mixing. The 
latency is bad and it eats CPU for nothing, why use it when you have 
hardware support?

Sagi




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
