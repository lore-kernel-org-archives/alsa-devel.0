From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: Re: [PATCH] remove emu10k1 pops/clicks at the  
   beginning and end of playback (fwd)
Date: Sat, 05 Mar 2005 15:46:08 +0100
Message-ID: <4229C630.8040600@kmlinux.fjfi.cvut.cz>
References: <Pine.LNX.4.58.0503040932460.1739@pnote.perex-int.cz> <1109960235.6442.9.camel@mindpipe> <d0bqba$esi$1@sea.gmane.org> <4229925C.6020009@superbug.co.uk> <d0c5th$a56$1@sea.gmane.org> <4229C434.6090005@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <4229C434.6090005@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Jindrich Makovicka wrote:
> 
>> James Courtier-Dutton wrote:
>>
>>> If it is of interest, the PCI transfers happen in blocks of 64 BYTES.
>>> So, if the playback pointer is in the middle of a block of 64 BYTES, 
>>> and you wish to send new samples to the card, without missing any of 
>>> them, you should start sending them at the next 64 bytes boundry.
>>
>>
>>
>> AFAIK, emupcm (at least the part I try to fix) operates in DMA 
>> busmaster mode, so "sending" samples is out of its jurisdiction. It 
>> just sets up looping over the DMA buffer and lets the card do the rest.
>>
>> FX8010 & ASIO is a different story, but I really don't know much in 
>> this matter.
>>
>> Regards,
> 
> 
> Same thing really. I meant DMA mode. The card requests the transfers in 
> 64 byte blocks.

I think transfer alignment is handled by higher layers, due to

static snd_pcm_hardware_t snd_emu10k1_playback = 

{
...
	.period_bytes_min = 64,
...
}

The above bug had nothing to do with alignment, only the sample caches 
were improperly purged and ccis was set to wrong values.

-- 
Jindrich Makovicka


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
