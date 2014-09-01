From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [v3 04/11] ASoC: Intel: sst: Add IPC handling
Date: Mon, 1 Sep 2014 19:27:07 +0530
Message-ID: <46537.7343622551$1409589042@news.gmane.org>
References: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
 <20140827203737.GY17528@sirena.org.uk>
 <20140901121753.GC12898@vinod.koul@linux.intel.com>
 <20140901125114.GV29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C055926561E
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 16:21:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140901125114.GV29327@sirena.org.uk>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 01, 2014 at 01:51:14PM +0100, Mark Brown wrote:
> On Mon, Sep 01, 2014 at 05:47:53PM +0530, Subhransu S. Prusty wrote:
> > On Wed, Aug 27, 2014 at 09:37:37PM +0100, Mark Brown wrote:
> 
> > > > +			spin_unlock_bh(&ctx->block_lock);
> > > > +			return 0;
> > > > +		}
> > > > +	}
> > > > +	spin_unlock_bh(&ctx->block_lock);
> > > > +	return -EINVAL;
> 
> > > I'd expect much louder complaints if we try to free something that's not
> > > allocated - what happens if we end up reallocating something quickly and
> > > then double freeing?  Better to complain if we hit such a code path.
> 
> > "freed" is a block which is passed by the caller to be freed up. Will add a
> > comment.
> 
> How would that address the problem?  Obviously the caller is trying to
> free what they're passing in.

sst_create_block() which allocates the memory and sst_free_block() which
frees the memory are called in a synchronous way. A single thread who is
allocating waits till a response arrives, if that response is valid then
after processing the response the sst_free_block() is called to free up the
memory. So the double freeing will not happen. Does this address your concern?



-- 
