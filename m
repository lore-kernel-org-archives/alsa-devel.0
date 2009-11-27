From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] ALSA: pcm - fix page conversion on
 non-coherent MIPS arch
Date: Fri, 27 Nov 2009 08:46:35 +0000
Message-ID: <20091127084635.GA18741@linux-mips.org>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
	<1259248388-20095-2-git-send-email-tiwai@suse.de>
	<1259248388-20095-3-git-send-email-tiwai@suse.de>
	<1259248388-20095-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 33FDF1038A0
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 09:46:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1259248388-20095-4-git-send-email-tiwai@suse.de>
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
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Becky Bruce <beckyb@kernel.crashing.org>, Wu Zhangjin <wuzhangjin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 26, 2009 at 04:13:06PM +0100, Takashi Iwai wrote:

> The non-coherent MIPS arch doesn't give the correct address by a simple
> virt_to_page() for pages allocated via dma_alloc_coherent().
> 
> Original patch by Wu Zhangjin <wuzj@lemote.com>.  A proper check of the
> buffer allocation type was added to avoid the wrong conversion.

The origins of this patch go back far further.  The oldest patch I could
find which is a superset of this was written by Atsushi Nemoto and
various incarnations of it have been sumitted to and reject by me
a number of times through the years.

> Note that this doesn't fix perfectly: the pages should be marked with
> proper pgprot value.  This will be done in a future implementation like
> the conversion to dma_mmap_coherent().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

So while this is ugly I don't think this patch will actually make the
the situation worse for any MIPS platform.  So with both eyes closed:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
