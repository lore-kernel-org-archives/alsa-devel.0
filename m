From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: DMA feature question.
Date: Mon, 28 Jun 2004 18:32:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E0564A.3030905@superbug.demon.co.uk>
References: <40DD8BD0.40705@superbug.demon.co.uk> <s5hisdbd69v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7473E290
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2004 18:29:34 +0200 (MEST)
In-Reply-To: <s5hisdbd69v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>If not, I will just have to make (1) a bit bigger, and place the "table 
>>of periods" in there.
> 
> 
> I don't think it's a good idea.
> The buffer will be mmapped to the user-space, and obviously you don't
> want to expose it.

The terms "Massive security hole!" comes to mind!

> 
> I'd suggest to allocate a table (one page should be large enough) via
> snd_dma_alloc_pages() statically at the driver initialization, and
> sets the max. number of periods according to the page size.
> 
> 
> Takashi
> 
> 

Is a page 1024 bytes or 4096 bytes? Does it vary depending on which type 
of CPU is in use? Is there a sensible minimum size to set it.

I only need to allow for a max of 16 periods per buffer. (does anyone 
need >16 periods per buffer ? )
There are 4 channels, with 8 bytes per period, that gives 16*4*8 = 512 
bytes.

Thanks, I will use snd_dma_alloc_pages().
For your info, this is for the AudigyLS driver.

Cheers
James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
