From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: AW: usb quattro
Date: Mon, 09 Sep 2002 22:32:47 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D7CA2FF.2030705@boosthardware.com>
References: <3D77A319.3010703@boosthardware.com>	<DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de>	<s5hvg5jwgvk.wl@alsa2.suse.de>	<3D7912A2.1000908@boosthardware.com> <s5hy9abzefz.wl@alsa2.suse.de> <3D7C8C53.7060001@boosthardware.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:

>>
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
>>
> 
> Takashi you little beauty :)
> 
> The sound is infinitely better.
> 
> I'll add a note to the docs.
> 
> Hmm. Now I have no excuses when people ask to hear my music though ;)
> 

Blah. I spoke too soon. I should have been worried when it was so easy.

I can get much better sound quality using this:

jackd -v -R -d alsa -d q4 -p 1152

which is through the plug layer. Currently the hw layer produces white 
noise.

I will have to track down the correct settings.



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
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
