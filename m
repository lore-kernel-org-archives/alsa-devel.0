From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v5 05/14] ASoC: SOF:
 Add PCM operations support
Date: Thu, 04 Apr 2019 12:00:57 +0100
Message-ID: <c3b944185e4582ec4d5fda88b90dbff9ef04c68b.camel@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0m2caz6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hd0m2caz6.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@gmail.com>, sound-open-firmware@alsa-project.org, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2019-04-04 at 12:37 +0200, Takashi Iwai wrote:
> > +
> > +     /* set runtime config */
> > +     runtime->hw.info = SNDRV_PCM_INFO_MMAP |
> > +                       SNDRV_PCM_INFO_MMAP_VALID |
> > +                       SNDRV_PCM_INFO_INTERLEAVED |
> > +                       SNDRV_PCM_INFO_PAUSE |
> > +                       SNDRV_PCM_INFO_RESUME |
> > +                       SNDRV_PCM_INFO_NO_PERIOD_WAKEUP;
> 
> Does SOF support the full resume?  That is, the stream gets resumed at
> the exact position that was suspended.  Most devices can't, hence they
> don't set *_INFO_RESUME flag and let user-space restarting.

Not atm, and I don't see this as an ask in the near future either, but it's
technically possible given the open firmware.

Liam
