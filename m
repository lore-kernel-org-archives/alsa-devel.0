From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: [PATCH] remove emu10k1 pops/clicks at the        beginning and
 end of playback (fwd)
Date: Sat, 05 Mar 2005 22:17:34 +0100
Message-ID: <d0d7bd$rml$1@sea.gmane.org>
References: <Pine.LNX.4.58.0503040932460.1739@pnote.perex-int.cz>	 <1109960235.6442.9.camel@mindpipe> <d0bqba$esi$1@sea.gmane.org>	 <4229925C.6020009@superbug.co.uk> <d0c5th$a56$1@sea.gmane.org>	 <4229C434.6090005@superbug.co.uk> <4229C630.8040600@kmlinux.fjfi.cvut.cz>	 <d0cvpo$a90$1@sea.gmane.org> <1110054327.12513.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110054327.12513.12.camel@mindpipe>
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
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sat, 2005-03-05 at 20:08 +0100, Jindrich Makovicka wrote:
> 
>>Here is one more update of the patch. This version clears only a part of 
>>the cache, saving some register writes. Tested for few hours, no pops so 
>>far. But it might be better to use brute force anyway.
> 
> Tested this on my SBLive, it definitely eliminates the pop at the end of
> playback for 44100Hz mono samples.  Have you tested with a wide variety
> of sample rates?
> 
> The emu10k1 supports continous sample rates from 0 to 192KHz so you
> could never test them all.  But I think testing all of the sample rates
> supported by the capture device would work.

Tested for all sample rates specified in capture_rates (8000, 11025, 
16000, 22050, 24000, 32000, 44100, 48000) plus couple of others in the 
range from 4kHz to 192kHz, everything for stereo/mono/8/16bit. No 
audible popping.

-- 
Jindrich Makovicka



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
