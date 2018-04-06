From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Fri, 6 Apr 2018 14:19:35 +0530
Message-ID: <20180406084934.GK6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-9-git-send-email-vinod.koul@intel.com>
 <7fc98a33-6e48-604e-73b7-308a798f5d66@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E04A266E30
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 10:45:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7fc98a33-6e48-604e-73b7-308a798f5d66@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 05, 2018 at 06:42:53PM -0500, Pierre-Louis Bossart wrote:
> >+/**
> >+ * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
> >+ * @dai: DAI
> >+ * @stream: STREAM
> >+ * @direction: Stream direction(Playback/Capture)
> >+ * SoundWire subsystem doesn't have a notion of direction and we reuse
> >+ * the ASoC stream direction to configure sink/source ports.
> 
> Playback == source, Capture == sink?
> what is the mapping convention?

oops, will fix

-- 
~Vinod
