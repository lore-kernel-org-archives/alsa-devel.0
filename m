From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [asoc:topic/intel 37/40]
 sound/soc/intel/skylake/skl-debug.c:53:1-6: WARNING: invalid free of devm_
 allocated data (fwd)
Date: Mon, 3 Jul 2017 08:55:20 +0530
Message-ID: <20170703032520.GT19154@localhost>
References: <alpine.DEB.2.20.1707011655370.2342@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AE9D2669F3
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 05:22:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1707011655370.2342@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Guneshwor Singh <guneshwor.o.singh@intel.com>, kbuild-all@01.org, Vunny Sodhi <vunnyx.sodhi@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 01, 2017 at 04:56:46PM +0200, Julia Lawall wrote:
> This doesn't show enough of the context to see the allocation, but please
> check.

Yeah this looks right to me, will send a patch to remove the kfree.

Thanks for reporting

> 
> thanks,
> julia
> 
> ---------- Forwarded message ----------
> Date: Sat, 1 Jul 2017 02:40:21 +0800
> From: kbuild test robot <fengguang.wu@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [asoc:topic/intel 37/40] sound/soc/intel/skylake/skl-debug.c:53:1-6:
>     WARNING: invalid free of devm_ allocated data
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   bdd0384a5ada8bb5745e5f29c10a5ba88827efad
> commit: 5cdf6c09ca9de3f037ba2d770206f3374459602d [37/40] ASoC: Intel: Skylake: Add debugfs support
> :::::: branch date: 6 hours ago
> :::::: commit date: 6 hours ago
> 
> >> sound/soc/intel/skylake/skl-debug.c:53:1-6: WARNING: invalid free of devm_ allocated data
> 
> git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> git remote update asoc
> git checkout 5cdf6c09ca9de3f037ba2d770206f3374459602d
> vim +53 sound/soc/intel/skylake/skl-debug.c
> 
> 5cdf6c09 Vinod Koul 2017-06-30  37  				   skl->platform->component.debugfs_root);
> 5cdf6c09 Vinod Koul 2017-06-30  38  	if (IS_ERR(d->fs) || !d->fs) {
> 5cdf6c09 Vinod Koul 2017-06-30  39  		dev_err(&skl->pci->dev, "debugfs root creation failed\n");
> 5cdf6c09 Vinod Koul 2017-06-30  40  		return NULL;
> 5cdf6c09 Vinod Koul 2017-06-30  41  	}
> 5cdf6c09 Vinod Koul 2017-06-30  42
> 5cdf6c09 Vinod Koul 2017-06-30  43  	d->skl = skl;
> 5cdf6c09 Vinod Koul 2017-06-30  44  	d->dev = &skl->pci->dev;
> 5cdf6c09 Vinod Koul 2017-06-30  45
> 5cdf6c09 Vinod Koul 2017-06-30  46  	return d;
> 5cdf6c09 Vinod Koul 2017-06-30  47  }
> 5cdf6c09 Vinod Koul 2017-06-30  48
> 5cdf6c09 Vinod Koul 2017-06-30  49  void skl_debugfs_exit(struct skl_debug *d)
> 5cdf6c09 Vinod Koul 2017-06-30  50  {
> 5cdf6c09 Vinod Koul 2017-06-30  51  	debugfs_remove_recursive(d->fs);
> 5cdf6c09 Vinod Koul 2017-06-30  52
> 5cdf6c09 Vinod Koul 2017-06-30 @53  	kfree(d);
> 5cdf6c09 Vinod Koul 2017-06-30  54
> 5cdf6c09 Vinod Koul 2017-06-30  55  }
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
~Vinod
