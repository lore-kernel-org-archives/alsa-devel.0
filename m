From: Maggio <voloterreno@tin.it>
Subject: Re: DXS broken with some cards in 1.0.X in module snd-via82xx?
Date: Mon, 01 Mar 2004 16:38:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4043590A.6060700@tin.it>
References: <40434209.6020903@tin.it> <20040301142317.GB6542@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040301142317.GB6542@master.mivlgu.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sergey Vlasov wrote:

>On Mon, Mar 01, 2004 at 03:00:41PM +0100, Maggio wrote:
>  
>
>>I was just wondering if the DXS support in 1.0.X has broken the 
>>DXS_SUPPORT=1 with some cards .
>>
>>I have an Abit KV7 Motherboard , and I use snd-via82xx for sound .
>>
>>I use this module from the version "0.9.8" , and I've never had any 
>>problems in enabling "dxs_support=1" with the 0.9.X series of the 
>>drivers , yesterday , by trying 1.0.2c and today the 1.0.3 versions of 
>>the kernel modules , I've noticed that ALSA doesn't work anymore with 
>>DXS_SUPPORT=1 , because the sound is garbled  , and I can only use DXS 
>>with DXS_SUPPORT=4 .
>>
>>What's up?
>>    
>>
>
>I suspect that dxs_support=4 is really the correct value in most (if
>not all) cases.  The resampling engine in VT82xx has a register for
>the source sample rate, but does not have any register to indicate
>the destination sample rate.  Unless the controller snoops the AC'97
>accesses in some way, this probably means that the destination
>sample rate is fixed at 48000 Hz.  I'm not sure what really happens
>when the codec is set to VRA mode in this case - probably this
>depends on quirks of a particular codec.  On my ASUS A7V8X (VT8235
>and ALC650) both dxs_support=1 and dxs_support=4 seem to work
>fine...
>  
>
dxs_support=4 works well for me in any cases , with 0.9.8 I don't hear 
(apparently) any difference between dxs_support=1 and dxs_support=4 , 
but with  1.0.2c/1.0.3 for me dxs_support=1 is pretty unusable , because 
of garbaged sound . I've just noticed that if I enable first 
dxs_support=4 , and then "rmmod" the driver , and then again reloading 
the driver with dxs_support=1 I get garbaged sound also with 0.9.8 . 
This is very obscure to me ...

I don't anyway completly understood how NO_VRA works and what this do , 
and what you lose what using NO_VRA instead of  VRA .

Thanks

Marcello


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
