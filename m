From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based rbtree
 compression
Date: Tue, 3 May 2011 15:27:29 +0100
Message-ID: <20110503142729.GP1762@opensource.wolfsonmicro.com>
References: <20110503104701.GD1762@opensource.wolfsonmicro.com>
	<s5hzkn4qcro.wl%tiwai@suse.de>
	<20110503110205.GE1762@opensource.wolfsonmicro.com>
	<s5hliyoq8d3.wl%tiwai@suse.de>
	<20110503130259.GK1762@opensource.wolfsonmicro.com>
	<s5hhb9brkg8.wl%tiwai@suse.de>
	<20110503132420.GM1762@opensource.wolfsonmicro.com>
	<s5hd3jzrjsw.wl%tiwai@suse.de>
	<20110503135117.GA2893@sirena.org.uk>
	<s5h8vunri6p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 990FA1038B7
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 16:27:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8vunri6p.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2011 at 04:07:42PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > If we can't get the data laid out in a contiguous array in memory then
> > we have to gather the data for transmit in the I/O code which is
> > painful and wasteful.

> But it's just a matter of CPU usage to look for the caches.
> Well, what I don't understand is the text you wrote:

No, as I said in my initial reply the big win is I/O bandwidth from
block writes.  There will also be a memory and consequent dcache win
from reducing the size of the data structure but that is likely to be
dwarfed by any write coalescing.

> | This isn't about CPU usage, it's about I/O bandwidth which is a big
> | concern in situations like resume where you can be bringing the device
> | back up from cold.

> How does the contiguous memory layout inside the cache management
> reduce the I/O bandwidth...?

If the data is laid out contiguously then we can easily send it to the
chip in one block.
