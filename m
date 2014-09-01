Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 09526262629
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:42:14 +0200 (CEST)
Date: Mon, 1 Sep 2014 17:49:59 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140901121959.GE12898@vinod.koul@linux.intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-9-git-send-email-subhransu.s.prusty@intel.com>
 <20140827204654.GA17528@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140827204654.GA17528@sirena.org.uk>
Subject: Re: [alsa-devel] [v3 08/11] ASoC: Intel: sst: add power management
	handling
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Wed, Aug 27, 2014 at 09:46:54PM +0100, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 06:20:47PM +0530, Subhransu S. Prusty wrote:
> 
> > +	/* When fw_clear_cache is set, clear the cached firmware copy */
> > +	/* fw_clear_cache is set through debugfs support */
> 
> Not in this patch series!
Yes. Will remove.
> 
> > +	if (atomic_read(&ctx->fw_clear_cache) && ctx->fw_in_mem) {
> 
> Why is this an atomic operation?  They're a bit of an alarm bell for
> correctness and it'd seem useful if the clear just happened immediately
> anyway.
> 
> > +	if (ret) {
> > +		pr_err("FW download fail %x\n", ret);
> > +		ctx->sst_state = SST_RESET;
> > +		mutex_unlock(&ctx->sst_lock);
> > +		sst_pm_runtime_put(ctx);
> 
> This is a runtime_pm_put() in the runtime PM callback?  That doesn't
> look right.
Mistakenly added. Not required.


-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
