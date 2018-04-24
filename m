From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 02/13] soundwire: Add support for
 SoundWire stream management
Date: Tue, 24 Apr 2018 14:32:45 +0530
Message-ID: <20180424090245.GB6014@localhost>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-3-git-send-email-vinod.koul@intel.com>
 <c88bfd9d-3192-5a0a-34d0-24fff829503c@linux.intel.com>
 <20180421161756.GP6014@localhost>
 <f869e5a4-2651-9ee4-aa3a-6f21eaa15c01@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C0658266CA1
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 10:58:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f869e5a4-2651-9ee4-aa3a-6f21eaa15c01@linux.intel.com>
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

On Mon, Apr 23, 2018 at 08:25:21AM -0500, Pierre-Louis Bossart wrote:
> 
> >>
> >>>+			(stream->params.bps != stream_config->bps)) {
> >>>+		dev_err(dev, "bps not matching, stream:%s", stream->name);
> >>>+		return -EINVAL;
> >>>+	}
> >>>+
> >>>+	stream->type = stream_config->type;
> >>>+	stream->params.rate = stream_config->frame_rate;
> >>>+	stream->params.bps = stream_config->bps;
> >>>+	if (is_slave)
> >>>+		stream->params.ch_count += stream_config->ch_count;
> >>
> >>Add comment or TODO that this does not work in device-to-device
> >>communication. This is a known limitation that needs to be tracked.
> >
> >Yes limitation for a feature that we dont support yet. So i dont think we
> >need to do anything atm for this. When the support for device-to-device
> >shows up, that would update this and other conditions valid only for specific
> >cases.
> 
> so if you don't support it yet, add a comment that this will have to be
> modified. This is all I am asking so that this limitation is known and the
> parts that have to be changed identified.

adding a TODO here

-- 
~Vinod
