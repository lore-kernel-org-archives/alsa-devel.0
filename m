From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: AW: usb quattro
Date: Wed, 25 Sep 2002 01:20:38 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9090D6.6010402@boosthardware.com>
References: <3D77A319.3010703@boosthardware.com>	<DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de>	<s5hvg5jwgvk.wl@alsa2.suse.de>	<3D7912A2.1000908@boosthardware.com> <s5hy9abzefz.wl@alsa2.suse.de> <3D8C277C.2070808@boosthardware.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Takashi Iwai wrote:
> 
>> the resolution of usb-audio device is 1ms.  this value is fixed.
>> thus you need to adjust the period size according to the sample rate
>> if you want to achieve the real-time response with a small period
>> size.
>>
>> that means:
>> - the sample rate should be 48kHz (or 32kHz), which can be divided by
>>   1000, and should not be 44.1kHz.
>> - the period size should be aligned to (rate / 1000).
>>   in the case of 48kHz, the period size should be 48, 96, 192, ...
>>
>> please try this combination.
>>
> 
> This is not working properly here.
> 
> Using 48khz with the above or higher sample rates I get many xruns from 
> jackd and it is impossible to connect ardour.
> 
> However if I use 44100/48000 with the default period size of 1024 then 
> it takes jack a while to warm the card up (about 5-10 seconds) and then 
> I get no xruns. However the sound quality is scratchy.
> 
> 

I was thinking about why the sound has been degraded again. It sounds 
the same as what was happening a couple of months back. Is it possible 
that when you added the code for merging multiple endpoints that you 
didn't take into account that fix again?

It seems odd that by changing the endpoint code the audio quality (which 
was perfect) has been degraded to what we were hearing a couple of 
months back.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
