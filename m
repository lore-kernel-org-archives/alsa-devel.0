From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/8] sound: intel/sst: don't pass GFP_DMA32
 to dma_alloc_coherent
Date: Wed, 17 Oct 2018 09:19:00 +0200
Message-ID: <20181017071900.GA23407@lst.de>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-6-hch@lst.de> <s5ho9bxn7ho.wl-tiwai@suse.de>
 <s5hefctm0m3.wl-tiwai@suse.de> <20181015095858.GA6277@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 by alsa0.perex.cz (Postfix) with ESMTP id E9BF8267545
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 09:19:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181015095858.GA6277@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 15, 2018 at 10:58:58AM +0100, Mark Brown wrote:
> On Sun, Oct 14, 2018 at 09:46:44AM +0200, Takashi Iwai wrote:
> > Takashi Iwai wrote:
> > > Christoph Hellwig wrote:
> 
> > > > The DMA API does its own zone decisions based on the coherent_dma_mask.
> 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> > > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> > Mark, let me know whether you'd take this via your tree or may I take
> > via mine (with a minor correction of the subject line).
> 
> I don't have the patch...  in fact, having found it in list archives I
> see there's also a SPI patch I'll have to go hunting for so I guess I'll
> apply this one when I find that :(  Christoph, please CC maintainers.

I tend to only add the list as there just are way too many maintainers
for this sorts of series, and maintainers should read their list anyway.
