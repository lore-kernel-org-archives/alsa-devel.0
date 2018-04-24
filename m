From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 02/13] soundwire: Add support for
 SoundWire stream management
Date: Tue, 24 Apr 2018 14:55:17 +0530
Message-ID: <20180424092517.GF6014@localhost>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-3-git-send-email-vinod.koul@intel.com>
 <c88bfd9d-3192-5a0a-34d0-24fff829503c@linux.intel.com>
 <20180421161756.GP6014@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F7D2266CA1
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 11:20:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180421161756.GP6014@localhost>
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

On Sat, Apr 21, 2018 at 09:47:56PM +0530, Vinod Koul wrote:
> 
> On Sat, Apr 21, 2018 at 06:02:52AM -0700, Pierre-Louis Bossart wrote:
> > On 4/18/18 3:58 AM, Vinod Koul wrote:
> 
> > >+static int sdw_config_stream(struct device *dev,
> > >+		struct sdw_stream_runtime *stream,
> > >+		struct sdw_stream_config *stream_config, bool is_slave)
> > >+{
> > >+
> > >+	/*
> > >+	 * Update the stream rate, channel and bps based on data
> > >+	 * source. For more than one data source (multilink),
> > >+	 * match the rate, bps, stream type and increment number of channels.
> > >+	 */
> > >+	if ((stream->params.rate) &&
> > 
> > so if the rate is zero there is no error?
> > 
> > >+			(stream->params.rate != stream_config->frame_rate)) {
> > >+		dev_err(dev, "rate not matching, stream:%s", stream->name);
> > >+		return -EINVAL;
> > >+	}
> > >+
> > >+	if ((stream->params.bps) &&
> > 
> > same here, what is the intent behind the first test?
> 
> IIRC this was to check for valid values, but am not too sure, let me get
> back to you on these two..

So if the value previously is not set, we want to allow it be set and then
compare. We are not checking for zero value or wrong values here, we are checking
fir values to be matched

Since you have asked this second time, I am going to add a comment here to
clarify..

-- 
~Vinod
