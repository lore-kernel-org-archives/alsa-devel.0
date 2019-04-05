From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH v5 05/14] ASoC: SOF: Add PCM operations
 support
Date: Fri, 05 Apr 2019 07:24:08 -0700
Message-ID: <468a0ad200b51d56f17d8b4acefc3d5f9ea93df0.camel@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0m2caz6.wl-tiwai@suse.de>
 <f5346e231c80876f0fa74e1172d570b0033cbf42.camel@linux.intel.com>
 <s5hv9zsy6qr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hv9zsy6qr.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2019-04-05 at 14:30 +0200, Takashi Iwai wrote:
> On Thu, 04 Apr 2019 21:13:43 +0200,
> Ranjani Sridharan wrote:
> > 
> > > > +
> > > > +	/* set runtime config */
> > > > +	runtime->hw.info = SNDRV_PCM_INFO_MMAP |
> > > > +			  SNDRV_PCM_INFO_MMAP_VALID |
> > > > +			  SNDRV_PCM_INFO_INTERLEAVED |
> > > > +			  SNDRV_PCM_INFO_PAUSE |
> > > > +			  SNDRV_PCM_INFO_RESUME |
> > > > +			  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP;
> > > 
> > > Does SOF support the full resume?  That is, the stream gets
> > > resumed
> > > at
> > > the exact position that was suspended.  Most devices can't, hence
> > > they
> > > don't set *_INFO_RESUME flag and let user-space restarting.
> > 
> > Hi Takashi,
> > 
> > Thanks for your comment. The SOF driver definitely cannot guarantee
> > to
> > resume from the exact same position due to the fact that triggers
> > for
> > the host dma and link dma are not synchronized and also IPC
> > scheduling
> > will affect this. So we should remove INOF_RESUME from hw.info.
> > 
> > I do one follow up question for you. When a stream resumes/restarts
> > after suspend, we have the need for restoring the hw_params in the
> > SOF
> > driver prior to handling the START trigger. I noticed that the
> > legacy/skylake driver does not seem to do this though. Do you have
> > any
> > insights on what we might be missing in the SOF driver?
> 
> So, SOF mandates the re-setup of the hw params in BE at resume?

Yes. That's correct.
> Then the right place to do is in the prepare callback.  Without
> SNDRV_PCM_INFO_RESUME flag, the PCM core won't trigger RESUME, but
> returns -ENOSYS.  Then user-space will do prepare, and start with the
> normal trigger.
> 
> You'd need a flag indicating the BE hw_params resetup, and at the
> beginning of prepare function, the flag is checked and the (internal)
> hw_params is done accordingly.

This makes sense. Thank you for your help. We will change the flow
accordingly.

Thanks,
Ranjani
> 
> 
> Takashi
