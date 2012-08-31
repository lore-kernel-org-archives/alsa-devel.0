From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [asoc:for-next 127/128] make[1]: *** No rule to
 make target `sound/soc/ep93xx'.
Date: Fri, 31 Aug 2012 12:44:01 -0700
Message-ID: <20120831194401.GB13655@localhost>
References: <20120829053856.GA6107@localhost>
 <20120829201338.bc007a27.shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DCC2526648E
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 21:44:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120829201338.bc007a27.shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 29, 2012 at 08:13:38PM +0400, Alexander Shiyan wrote:
> On Tue, 28 Aug 2012 22:38:56 -0700
> Fengguang Wu <fengguang.wu@intel.com> wrote:
> 
> > FYI, kernel build failed on
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> > head:   03a5da2b72ba426ed475795db375fc7780338ff4
> > commit: 0ed275eff31029c39355828cb48c46c0a006e2f8 [127/128] ASoC: Rename ep93xx soc directory to cirrus
> > config: x86_64-allyesconfig (attached as .config)
> > Build errors:
> > make[1]: *** No rule to make target `sound/soc/ep93xx'.
> 
> Cannot reproduce this bug.  Possible this breakage may be resolved by run
> "make distclean" before "make all".

Sorry! It's actually a bug of the build system.. I just fixed it.

Thanks,
Fengguang
