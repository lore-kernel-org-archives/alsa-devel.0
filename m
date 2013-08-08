From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] 6fire: fix URB transfer buffer for midi
 output
Date: Thu, 08 Aug 2013 09:16:27 +0200
Message-ID: <520345CB.3030307@ladisch.de>
References: <s5hli4d5uj7.wl%tiwai@suse.de>
 <Pine.LNX.4.44L0.1308071334590.886-100000@iolanthe.rowland.org>
 <s5hy58cafd0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id BEE5226564A
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 09:16:49 +0200 (CEST)
In-Reply-To: <s5hy58cafd0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Torsten Schenk <torsten.schenk@zoho.com>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Alan Stern wrote:
>> A buffer _can_ be in the middle of a kmalloc'ed space, but the CPU must
>> not access any of the fields around it that might occupy the same cache
>> line while the buffer is being used for DMA.
>
> Hrm, but does the kmalloc buffer always guarantee such cache line
> exclusiveness...?  I thought a simple one like SLOB doesn't care.

Documentation/DMA-API-HOWTO.txt says:
|  Architectures must ensure that kmalloc'ed buffer is
|  DMA-safe. Drivers and subsystems depend on it. If an architecture
|  isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
|  the CPU cache is identical to data in main memory),
|  ARCH_DMA_MINALIGN must be set so that the memory allocator
|  makes sure that kmalloc'ed buffer doesn't share a cache line with
|  the others.


Regards,
Clemens
