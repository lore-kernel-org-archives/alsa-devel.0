From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] emu10k1: fix P16V breakage for non	Audigy2
 cards
Date: Wed, 16 Mar 2005 21:28:54 +0000
Message-ID: <4238A516.7070802@superbug.co.uk>
References: <1110950511.19984.9.camel@mindpipe> <1110950832.19984.13.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110950832.19984.13.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, 2005-03-16 at 00:21 -0500, Lee Revell wrote:
> 
>>The P16V patch unconditionally checks the IPR2 register in the interrupt
>>handler resulting in infinite loop and system lockup on any non Audigy2
>>cards.  I really hate checking emu->is_audigy and emu->revision in a
>>fast path like the IRQ handler but I don't see another way.
>>
>>Also, don't bother allocating/freeing the DMA buffer for P16V unless
>>it's really present.
> 
> 
> Oh, one more thing: this patch restores the "unhandled interrupt"
> printk() that was commented out by the P16V patch.  I am sure this was
> useful for development but seems like a bad idea for production.
> 
> James, were you still getting unhandled interrupts with the version of
> the patch that was merged?
> 
> Lee
> 

Thank you for fixing the bug.
The "unhandled interrupt" should be commented out. It is used for 
reverse engineering certain features.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
