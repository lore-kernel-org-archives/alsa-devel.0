From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 09/11] ASoC: Intel: Skylake:	Fix DMA
 position reporting for capture stream
Date: Mon, 27 Mar 2017 15:59:54 +0530
Message-ID: <20170327102954.GM9308@localhost>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
 <1490377234-30257-10-git-send-email-jeeja.kp@intel.com>
 <s5hpoh6ed0k.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60552D1C38C@BGSMSX104.gar.corp.intel.com>
 <s5hlgruech8.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60552D1C563@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AE2B26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 12:28:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85DFEED57DC57344B2483EF7BF8CB60552D1C563@BGSMSX104.gar.corp.intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "R,
 Dharageswari" <dharageswari.r@intel.com>, Patches Audio <patches.audio@intel.com>, "Shah,
 Hardik T" <hardik.t.shah@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Kp, Jeeja" <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 25, 2017 at 02:21:13AM +0530, Ughreja, Rakesh A wrote:
> >> >Are these workarounds needed for the legacy driver?
> >> >If yes, which chips require it?
> >> >
> >>
> >> Yes, these are needed in legacy driver as well.
> >> From SKL and BXT onwards, it is needed.
> >
> >OK, thanks for confirmation.
> >
> >Now, from what I read in the above, is the workaround required *only*
> >after the interrupt is generated?  20us delay isn't so cheap, and we
> >tend to inquire PCM positions often.  If the workaround is needed only
> >after the PCM period elapse, we can set some flag in the irq handler
> >and apply the workaround only when necessary.
> >
> 
> Yes, Takashi the workaround is required only in the period elapsed
> interrupt. In some cases the DMA Position updates are delayed and so
> when the period elapsed interrupt occurs the wait_for_avail thinks that
> one period worth of data is not available and so returns only on the 
> next period elapsed interrupt. This creates problem for 2 periods
> playback/capture streams.
> 
> So even in the period elapsed interrupt the wait is required only if the
> position is less than the period boundary.

Hi Takashi,

So we need this for 2 periods when the device is in irq mode. Not for other
cases. ie SKL_PLUS..

But have you seen any user reports on this till now.

-- 
~Vinod
