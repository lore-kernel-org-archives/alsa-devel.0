From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 01/11] ASoC: SOF: Add Sound Open Firmware
	driver core
Date: Wed, 22 Aug 2018 17:26:12 +0100
Message-ID: <9917502368e18d908fb3a125c7779d00e68b0fb1.camel@linux.intel.com>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
 <20180723185633.GI13981@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CE2F1267663
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 18:26:16 +0200 (CEST)
In-Reply-To: <20180723185633.GI13981@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-07-23 at 19:56 +0100, Mark Brown wrote:
> > 

Apologies for the delay.


> On Thu, Jul 19, 2018 at 07:53:25PM +0100, Liam Girdwood wrote:
> 
> 
> > +static inline unsigned int sof_get_pages(size_t size)
> > +{
> > +	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +}
> 
> This feels like there should be a generic MM function for it?

There is and there is not even a user for this inline ! Removed.

> 
> > +/*
> > + * Generic buffer page table creation.
> > + */
> > +
> > +int snd_sof_create_page_table(struct snd_sof_dev *sdev,
> > +			      struct snd_dma_buffer *dmab,
> > +			      unsigned char *page_table, size_t size)
> > +{
> > +	int i, pages;
> > +
> > +	pages = snd_sgbuf_aligned_pages(size);
> > +
> > +	dev_dbg(sdev->dev, "generating page table for %p size 0x%zx pages
> > %d\n",
> > +		dmab->area, size, pages);
> > +
> > +	for (i = 0; i < pages; i++) {
> > +		u32 idx = (((i << 2) + i)) >> 1;
> > +		u32 pfn = snd_sgbuf_get_addr(dmab, i * PAGE_SIZE) >>
> > PAGE_SHIFT;
> > +		u32 *pg_table;
> > +
> > +		dev_dbg(sdev->dev, "pfn i %i idx %d pfn %x\n", i, idx,
> > pfn);
> > +
> > +		pg_table = (u32 *)(page_table + idx);
> > +
> > +		if (i & 1)
> > +			*pg_table |= (pfn << 4);
> > +		else
> > +			*pg_table |= pfn;
> > +	}
> 
> I'm not 100% clear what this is intended to do - lots of magic numbers
> and dependencies on the host memory configuration.

I'll add some more detail in the comments here, but the general gist is that we
compress PHY pages addresses (i.e. drop 12 lsb from each) and pack them into a
buffer. The intention is to make this compressed PFN buffer as small as possible
(so it cant describe a large set of SG pages in an architecture agnostic
manner).

Liam
