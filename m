From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 08/13] ASoC: Add SoundWire stream
 programming interface
Date: Wed, 25 Apr 2018 08:19:23 +0530
Message-ID: <20180425024923.GG6014@localhost>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-9-git-send-email-vinod.koul@intel.com>
 <79c978d0-0ded-ddcb-5405-18b657c062d7@linux.intel.com>
 <20180421155804.GN6014@localhost>
 <d9b2a2dd-5f60-3916-a759-540d3cfa34ff@linux.intel.com>
 <20180424090633.GD6014@localhost>
 <a439fa96-0338-ad73-8203-4a2f875d44cb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id AE4E42676A6
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 04:44:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a439fa96-0338-ad73-8203-4a2f875d44cb@linux.intel.com>
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

On Tue, Apr 24, 2018 at 06:40:54PM -0500, Pierre-Louis Bossart wrote:
> On 4/24/18 4:06 AM, Vinod Koul wrote:
> >On Mon, Apr 23, 2018 at 08:33:08AM -0500, Pierre-Louis Bossart wrote:
> >>On 4/21/18 10:58 AM, Vinod Koul wrote:
> >>>On Sat, Apr 21, 2018 at 06:59:49AM -0700, Pierre-Louis Bossart wrote:
> >>>>
> >>>>>+/**
> >>>>>+ * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
> >>>>>+ * @dai: DAI
> >>>>>+ * @stream: STREAM
> >>>>>+ * @direction: Stream direction(Playback/Capture)
> >>>>>+ * SoundWire subsystem doesn't have a notion of direction and we reuse
> >>>>>+ * the ASoC stream direction to configure sink/source ports.
> >>>>>+ * Playback maps to source on the TX and sink on Rx. Vice-versa for Capture.
> >>>>
> >>>>this is just confusing...
> >>>>
> >>>>This should be something like
> >>>>"use Playback for source ports and Capture for sink ports".
> >>>
> >>>Source port on ...? This is also confusing to me!
> >>>
> >>>For playback there are two ports, one on transmitter aka
> >>>TX and one on receiver aka RX. For Tx we use source port, and Rx uses sink
> >>>ports. I should probably add port to make people really figure out we are
> >>>talking about ports!
> >>>
> >>>So:
> >>>
> >>>Playback maps to source port on the TX and sink port on Rx. Vice-versa for Capture.
> >>>
> >>>Do you agree to above statement?
> >>
> >>No. Source port and TX are redundant definitions, and your wording isn't
> >>clear: is the PLAYBACK/CAPTURE qualifier for the stream or the DAI used by
> >>the stream?
> >
> >Yes they are redundant, will update. PLAYBACK/CAPTURE qualifier is for stream.
> 
> Let me try again.
> let's say in point-to-point mode you have dai1 as the source and dai2 as the
> sink.
> 
> Which sequence are the higher layers supposed to use:
> 
> a.
> 
> snd_soc_dai_set_sdw_stream(dai1, stream, PLAYBACK);
> snd_soc_dai_set_sdw_stream(dai2, stream, PLAYBACK);
> 
> b.
> 
> snd_soc_dai_set_sdw_stream(dai1, stream, PLAYBACK);
> snd_soc_dai_set_sdw_stream(dai2, stream, CAPTURE);

I believe this.

-- 
~Vinod
