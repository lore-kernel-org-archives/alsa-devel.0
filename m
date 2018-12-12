From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 05/14] ASoC: SOF: Add PCM operations
	support
Date: Wed, 12 Dec 2018 15:12:22 +0200
Message-ID: <20181212131222.GQ10650@smile.fi.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0q7uq5l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5hd0q7uq5l.wl-tiwai@suse.de>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 12, 2018 at 09:04:38AM +0100, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 22:23:09 +0100,
> Pierre-Louis Bossart wrote:
> > 
> > +	/* number of pages should be rounded up */
> > +	if (runtime->dma_bytes % PAGE_SIZE)
> > +		pcm.params.buffer.pages = (runtime->dma_bytes / PAGE_SIZE) + 1;
> > +	else
> > +		pcm.params.buffer.pages = runtime->dma_bytes / PAGE_SIZE;
> 
> There is likely some nice macro for this :)

DIV_ROUND_UP() ?

-- 
With Best Regards,
Andy Shevchenko
