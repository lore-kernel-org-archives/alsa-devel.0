From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Multiple Audio Streams
Date: Mon, 07 Oct 2002 20:44:50 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA173B2.9020706@boosthardware.com>
References: <3D9F3D84.4040102@boom.org.il> <1033859918.1118.24.camel@duron> <3DA15968.1000205@superbug.demon.co.uk> <3DA160E7.10608@boom.org.il>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Sagi Bashari <sagi@boom.org.il>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, AthlonRob <athlonrob@data.4t3.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sagi Bashari wrote:

> This is what I get:
> 
> [sagi@beep pcm0p]$ cat info
> card: 0
> device: 0
> subdevice: 0
> stream: PLAYBACK
> id: CS46xx
> name: CS46xx
> subname: subdevice #0
> class: 0
> subclass: 0
> subdevices_count: 1
> subdevices_avail: 1
> [sagi@beep pcm0p]$
> 
>>
>>
>> As you can see, my old sound card can only handle one stream at once 
>> in hardware. Alsa does not do any software mixing.
>> I also have a SB Live in another machine, the subdevices_avail is then 
>> 32 because the SB Live can handle 32 streams at once in hardware.
> 
> 
> 
> Yes, that's the strange thing. According to the output it only supports 
> 1 subdevice, but the soundcard matrix says it does support hardware 
> mixing (and I know that it does, it works perfectly on other OSs).
> 
> Does this mean that there's no real ALSA support for the Hardware mixing 
> using this chip? If yes, why is it listed in the website with this option?
> 

It's there because the author of the driver wrote to me and told me it 
has support. It could be that your version of the card has something 
funky going on.

>>
>>
>> There are other applications/tools you can use, one of which is "JACK" 
>> that allows for multiple audio streams mixed in software and lots of 
>> other cool stuff.
> 
> 
> I used ARTS until now. But I don't want to use software mixing. The 
> latency is bad and it eats CPU for nothing, why use it when you have 
> hardware support?
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
