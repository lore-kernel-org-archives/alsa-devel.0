From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Re: [PATCH] remove emu10k1 pops/clicks at the  
 beginning and end of playback (fwd)
Date: Sat, 05 Mar 2005 11:05:00 +0000
Message-ID: <4229925C.6020009@superbug.co.uk>
References: <Pine.LNX.4.58.0503040932460.1739@pnote.perex-int.cz> <1109960235.6442.9.camel@mindpipe> <d0bqba$esi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <d0bqba$esi$1@sea.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jindrich Makovicka wrote:
> Lee Revell wrote:
> 
>> On Fri, 2005-03-04 at 22:30 +0100, Jindrich Makovicka wrote:
>>
>>>> Lee Revell wrote:
>>>
>>>
>>>>> > It's not that the cciss register is buggy, it's just poorly 
>>>>> understood.
>>>
>>>
>>>>
>>>> I don't mean the register alone, I mean the way ALSA sets it.
>>>>
>>>
>>>>> > See US patent 6138207 for the exact function of the cache control
>>>>> > circuitry.  I can't get my brain around it, but maybe you can.
>>>>> > > 
>>>>> http://patft.uspto.gov/netacgi/nph-Parser?u=/netahtml/srchnum.htm&Sect1=PTO1&Sect2=HITOFF&p=1&r=1&l=50&f=G&d=PALL&s1=6138207.WKU.&OS=PN/6138207&RS=PN/6138207 
>>>>>
>>>
>>>
>>>>
>>>> Thanks for the brain food, but today I am too tired to dive in  :)
>>>
>>>
>>>>> > Have you tried leaving the cciss setting alone, and just 
>>>>> increasing cs
>>>>> > to 16, which should cause it to silence the entire cache, not 
>>>>> just the
>>>>> > beginning?
>>>
>>>
>>>>
>>>> When I leave cciss alone, audio still heavily pops (16bit at the 
>>>> end, 8bit at the beginning). When I change cciss the way OSS driver 
>>>> has it, which I believe is correct, there is still a slight pop at 
>>>> the end for both. After decreasing cciss a bit (4 samples), the pop 
>>>> at the end seems to be gone. Unfortunately I cannot test it on other 
>>>> cards than my SB 1024.
>>>>
>>>> My current patch is attached (applies to 2.6.11-mm1). I also moved 
>>>> cciss setting to one place and made invalidate_cache honor the 
>>>> "extra" flag - if extra is on, it does not invalidate the second 
>>>> channel.
>>>>
>>
>>
>> OK, sounds good.
>>
>> You will have to generate the patch against ALSA CVS.  This will require
>> updating it to support the multichannel device, which is made up of 16
>> mono channels, 16 bit, 48KHz only  (plus an extra voice for timing).
>> Should be easy.
>>
>> Then, repost it to alsa-devel.
> 
> 
> So, as the the above patch appeared to be rather a proof of concept, 
> here is the (hopefully) correct fix. It changes the following:
> 
> - CCIS setting, which was previously "upside down" is fixed and modified 
> to supress the pop at the end
> 
> - CCIS values are now in one spot to allow tweaking
> 
> - invalidate_cache now purges complete cache for both channels.
> 
> Big thanks to Lee for his advices.
> 
> I don't see any reason the patch shouldn't apply to CVS, as the only 
> change with wider impact is in invalidate_cache arguments, and all 
> callers are updated.
> 
> Best regards,
> 
> 

If it is of interest, the PCI transfers happen in blocks of 64 BYTES.
So, if the playback pointer is in the middle of a block of 64 BYTES, and 
you wish to send new samples to the card, without missing any of them, 
you should start sending them at the next 64 bytes boundry.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
