From: Michael Corlett <ad@corlett.plus.com>
Subject: Re: ISA pnp & kernel 2.6
Date: Thu, 12 Feb 2004 17:19:13 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402BB591.3010205@gremlin>
References: <402AA54F.3050705@gremlin> <s5h8yj8a8m6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yj8a8m6.wl@alsa2.suse.de>
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

Takashi Iwai wrote:
> At Wed, 11 Feb 2004 21:57:35 +0000,
> Michael Corlett wrote:
> 
>>
>>I have an ISA pnp card (opti931) which stopped working when I
>>installed kernel 2.6 and the problem is as follows:
>>
>>The kernel function that sets and activates the card is
>>isapnp_set_resources (in drivers/pnp/isapnp/core.c) and for
>>each resource, it is checking that the correct flag is set
>>before writing to the port (i.e. IORESOURCE_IO, IORESOURCE_IRQ,
>>IORESOURCE_DMA, IORESOURCE_MEM) however, these flags are never
>>being set because the driver code is just using
>>pnp_init_resource_table followed by pnp_resource_change for each
>>setting and so the configuration is never written to the card.
>>(I believe that the equivalent code in 2.4 just checked for
>>flags != 0).
> 
> 
> did you try the latest 2.6.3-rc kernel?
> many pnp fixes are included.
> 

I have just tried rc2 and it is indeed fixed.  Thankyou.

Michael.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
