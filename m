From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 02/13] soundwire: Add support for
 SoundWire stream management
Date: Sat, 21 Apr 2018 21:47:56 +0530
Message-ID: <20180421161756.GP6014@localhost>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-3-git-send-email-vinod.koul@intel.com>
 <c88bfd9d-3192-5a0a-34d0-24fff829503c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 59ED6267230
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 18:13:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <c88bfd9d-3192-5a0a-34d0-24fff829503c@linux.intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


On Sat, Apr 21, 2018 at 06:02:52AM -0700, Pierre-Louis Bossart wrote:
> On 4/18/18 3:58 AM, Vinod Koul wrote:

> >+static int sdw_config_stream(struct device *dev,
> >+		struct sdw_stream_runtime *stream,
> >+		struct sdw_stream_config *stream_config, bool is_slave)
> >+{
> >+
> >+	/*
> >+	 * Update the stream rate, channel and bps based on data
> >+	 * source. For more than one data source (multilink),
> >+	 * match the rate, bps, stream type and increment number of channels.
> >+	 */
> >+	if ((stream->params.rate) &&
> 
> so if the rate is zero there is no error?
> 
> >+			(stream->params.rate != stream_config->frame_rate)) {
> >+		dev_err(dev, "rate not matching, stream:%s", stream->name);
> >+		return -EINVAL;
> >+	}
> >+
> >+	if ((stream->params.bps) &&
> 
> same here, what is the intent behind the first test?

IIRC this was to check for valid values, but am not too sure, let me get
back to you on these two..

> 
> >+			(stream->params.bps != stream_config->bps)) {
> >+		dev_err(dev, "bps not matching, stream:%s", stream->name);
> >+		return -EINVAL;
> >+	}
> >+
> >+	stream->type = stream_config->type;
> >+	stream->params.rate = stream_config->frame_rate;
> >+	stream->params.bps = stream_config->bps;
> >+	if (is_slave)
> >+		stream->params.ch_count += stream_config->ch_count;
> 
> Add comment or TODO that this does not work in device-to-device
> communication. This is a known limitation that needs to be tracked.

Yes limitation for a feature that we dont support yet. So i dont think we
need to do anything atm for this. When the support for device-to-device
shows up, that would update this and other conditions valid only for specific
cases.

> >+/**
> >+ * sdw_stream_state: Stream states
> >+ *
> >+ * @SDW_STREAM_RELEASED: Stream released
> >+ * @SDW_STREAM_ALLOCATED: New stream allocated.
> >+ * @SDW_STREAM_CONFIGURED: Stream configured
> >+ * @SDW_STREAM_PREPARED: Stream prepared
> >+ * @SDW_STREAM_ENABLED: Stream enabled
> >+ * @SDW_STREAM_DISABLED: Stream disabled
> >+ * @SDW_STREAM_DEPREPARED: Stream de-prepared
> >+ */
> >+enum sdw_stream_state {
> >+	SDW_STREAM_ALLOCATED = 0,
> 
> with the kzalloc used in sdw_alloc_stream() the default state is
> ALLOCATED...You may want to use values which don't include zero.

How would that help. If we use kzalloc then stream init to
SDW_STREAM_ALLOCATED is no op. If we dont then it initializes... so seems
better to me!

-- 
~Vinod
