From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [sound-unstable:topic/hda-spdif-fix 99/124] ERROR:
 "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
Date: Sun, 21 Oct 2012 21:40:54 +0800
Message-ID: <20121021134054.GB32592@localhost>
References: <5083733a.T3zEi6cLE4psrO1W%fengguang.wu@intel.com>
 <20121021053354.GA23699@localhost> <s5hsj98jkpv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 31C76265152
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 15:40:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsj98jkpv.wl%tiwai@suse.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 21, 2012 at 10:25:00AM +0200, Takashi Iwai wrote:
> At Sun, 21 Oct 2012 13:33:54 +0800,
> Fengguang Wu wrote:
> > 
> > On Sun, Oct 21, 2012 at 11:59:54AM +0800, Fengguang Wu wrote:
> > > Hi Peter,
> > > 
> > > FYI, kernel build failed on
> > > 
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git topic/hda-spdif-fix
> > > head:   afc51e492b36bd61b46f4d70dd646678d96f5f97
> > > commit: e7736cdea223f3a5b867c359fb35cf08250dd771 [99/124] dmaengine: Add flags parameter to dmaengine_prep_dma_cyclic()
> > 
> > Sorry that's a wrong bisection. The kernel build on previous commit
> > has errors in header file that hide the below errors.
> > 
> > The real bad commit should be
> > 
> > commit 946cc36ae550ea52adee0f42ac5034a34b5393be
> > Author:     Peter Ujfalusi <peter.ujfalusi@ti.com>
> > AuthorDate: Fri Sep 14 15:05:58 2012 +0300
> > Commit:     Mark Brown <broonie@opensource.wolfsonmicro.com>
> > CommitDate: Sat Sep 22 11:13:02 2012 -0400
> > 
> >     ASoC: omap-pcm: Convert to use dmaengine
> 
> The branch must be in a half-baked state that is missing the fix patch
> that has been applied later on.  Please ignore.

OK. 

> The sound-unstable tree is really unstable, so I'm afraid that
> checking all branches in the tree may annoy people like this.
> 
> Fengguang, could you change the setup to check only the master branch
> of sound-unstable tree?

No problem. I'll whitelist sound-unstable/master and blacklist the
other sound-unstable branches.

Thanks,
Fengguang
