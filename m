From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 08/13] ASoC: Add SoundWire stream
 programming interface
Date: Sat, 21 Apr 2018 21:28:04 +0530
Message-ID: <20180421155804.GN6014@localhost>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-9-git-send-email-vinod.koul@intel.com>
 <79c978d0-0ded-ddcb-5405-18b657c062d7@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 926E7267230
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 17:53:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <79c978d0-0ded-ddcb-5405-18b657c062d7@linux.intel.com>
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

On Sat, Apr 21, 2018 at 06:59:49AM -0700, Pierre-Louis Bossart wrote:
> 
> >+/**
> >+ * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
> >+ * @dai: DAI
> >+ * @stream: STREAM
> >+ * @direction: Stream direction(Playback/Capture)
> >+ * SoundWire subsystem doesn't have a notion of direction and we reuse
> >+ * the ASoC stream direction to configure sink/source ports.
> >+ * Playback maps to source on the TX and sink on Rx. Vice-versa for Capture.
> 
> this is just confusing...
> 
> This should be something like
> "use Playback for source ports and Capture for sink ports".

Source port on ...? This is also confusing to me!

For playback there are two ports, one on transmitter aka
TX and one on receiver aka RX. For Tx we use source port, and Rx uses sink
ports. I should probably add port to make people really figure out we are
talking about ports!

So:

Playback maps to source port on the TX and sink port on Rx. Vice-versa for Capture.

Do you agree to above statement?

-- 
~Vinod
