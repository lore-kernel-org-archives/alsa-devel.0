From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] ALSA: Fix remaining NULL device with
 memory allocations
Date: Mon, 4 Feb 2019 16:50:17 +0100
Message-ID: <20190204155017.GA14106@lst.de>
References: <20190204134222.9560-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 63FE326746F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:50:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190204134222.9560-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 04, 2019 at 02:42:17PM +0100, Takashi Iwai wrote:
> Hi,
> 
> this patchset covers the still remaining drivers calling the memory
> allocation with NULL device pointer.  Simply card->dev is passed
> there.
> 
> 
> Mark, two of them are trivial fixes for ASoC, and I'd like to merge
> them through my tree, since the last patch adds an explicit WARN_ON().
> Give me Ack's if they are OK.

Thanks a lot for doing this work!

Acked-by: Christoph Hellwig <hch@lst.de>
