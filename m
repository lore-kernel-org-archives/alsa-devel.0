From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Tue, 17 Apr 2018 21:19:05 +0530
Message-ID: <20180417154904.GY6014@localhost>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
 <1523892221-16169-9-git-send-email-vinod.koul@intel.com>
 <20180417111118.GF8973@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 0319B2673DC
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 17:44:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180417111118.GF8973@sirena.org.uk>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 17, 2018 at 12:11:18PM +0100, Mark Brown wrote:
> On Mon, Apr 16, 2018 at 08:53:36PM +0530, Vinod Koul wrote:
> 
> > +/**
> > + * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
> > + * @dai: DAI
> > + * @stream: STREAM
> > + * @direction: Stream direction(Playback/Capture)
> > + * SoundWire subsystem doesn't have a notion of direction and we reuse
> > + * the ASoC stream direction to configure source/sink ports.
> > + *
> > + * Returns 0 on success, a negative error code otherwise.
> > + */
> > +static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
> > +				void *stream, int direction)
> > +{
> 
> How do we clear the stream that's been set up?  I'd expect that to be a
> useful thing to do from a housekeeping point of view if nothing else.

Right it needs to be cleared and that is achieved by setting with NULL.

Thanks
-- 
~Vinod
