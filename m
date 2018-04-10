From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH] sound: soc: intel: bxt_da7219_max98357a:
 Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Date: Tue, 10 Apr 2018 19:47:22 +0530
Message-ID: <20180410141721.GQ6014@localhost>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
 <482591fb-bf12-2e0a-e0ef-2ae0b4095000@linux.intel.com>
 <s5h3704dvad.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h3704dvad.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Adam.Thomson.Opensource@diasemi.com, Jia-Ju Bai <baijiaju1990@gmail.com>, lgirdwood@gmail.com, sathyanarayana.nujella@intel.com, broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 09, 2018 at 09:39:06PM +0200, Takashi Iwai wrote:
> On Mon, 09 Apr 2018 20:57:43 +0200,
> Pierre-Louis Bossart wrote:
> > 
> > On 4/9/18 5:46 AM, Jia-Ju Bai wrote:
> > > broxton_audio_probe() is never called in atomic context.
> > > This function is only set as ".probe" in "struct platform_driver".
> > >
> > > Despite never getting called from atomic context,
> > > broxton_audio_probe() calls devm_kzalloc() with GFP_ATOMIC,
> > > which waits busily for allocation.
> > > GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> > > to avoid busy waiting and improve the possibility of sucessful allocation.
> > 
> > [answering for the series]
> > Humm, this is interesting.
> > If indeed we can afford to sleep then the change should be done on ALL
> > 14 boards in sound/soc/intel/boards which follow the same code
> > pattern.
> > If we cannot sleep then then none of these changes should be applied.
> > Liam and Vinod?
> 
> It must be sleepable context as it's a standard platform driver probe
> callback.
> 
> And now looking at grep output, only sound/soc/intel contains so many
> calls with GFP_ATOMIC.  I bet that almost all can be done with
> GFP_KERNEL, maybe only one or two in atom/sst would be conditionally
> with GFP_ATOMIC.

Yeah I don't see many cases which would warrant atomic context, I will review
them and fix these after merge window closes. Clearly machines have no
reason for that, and I guess most are copy-paste from 1st culprit

-- 
~Vinod
