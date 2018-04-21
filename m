From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 07/13] soundwire: Add stream
 configuration APIs
Date: Sat, 21 Apr 2018 21:43:15 +0530
Message-ID: <20180421161315.GO6014@localhost>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-8-git-send-email-vinod.koul@intel.com>
 <bca948a4-a668-73d0-5e6d-63287a21a636@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C664267230
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 18:08:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bca948a4-a668-73d0-5e6d-63287a21a636@linux.intel.com>
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

On Sat, Apr 21, 2018 at 06:56:26AM -0700, Pierre-Louis Bossart wrote:
> 
> >+static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_master_runtime *m_rt = stream->m_rt;
> >+	struct sdw_bus *bus = m_rt->bus;
> >+	struct sdw_master_prop *prop = NULL;
> >+	struct sdw_bus_params params;
> >+	int ret;
> >+
> >+	prop = &bus->prop;
> >+	memcpy(&params, &bus->params, sizeof(params));
> >+
> >+	/* TODO: Support Asynchronous mode */
> >+	if ((prop->max_freq % stream->params.rate) != 0) {
> >+		dev_err(bus->dev, "Async mode not supported");
> >+		return -EINVAL;
> >+	}
> >+
> >+	/* Increment cumulative bus bandwidth */
> >+	bus->params.bandwidth += m_rt->stream->params.rate *
> >+		m_rt->ch_count * m_rt->stream->params.bps;
> 
> This also does not work for device-to-device communication, see e.g.
> the earlier documentation.

Sure it doesn't work for a feature which is **NOT** supported. So I am not
going to do anything here

> ch_count: Number of channels handled by the Master for
> + * this stream, can be zero.
> 
> should it be m_rt->stream->params->ch_count?

Not for this case. In future when we support multi-link then yes.

> >+static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_master_runtime *m_rt = stream->m_rt;
> >+	struct sdw_bus *bus = m_rt->bus;
> >+	int ret = 0;
> >+
> >+	/* De-prepare port(s) */
> >+	ret = sdw_prep_deprep_ports(m_rt, false);
> >+	if (ret < 0) {
> >+		dev_err(bus->dev, "De-prepare port(s) failed: %d", ret);
> >+		return ret;
> >+	}
> >+
> >+	bus->params.bandwidth -= m_rt->stream->params.rate *
> >+		m_rt->ch_count * m_rt->stream->params.bps;
> 
> And same here, the ch_count can be zero.

Same as above..

> 
> >+
> >+	if (!bus->params.bandwidth) {
> >+		bus->params.row = 0;
> >+		bus->params.col = 0;
> >+		goto exit;
> 
> What is the intent with this test+goto? Shouldn't you program the parameters
> if you want to change the frame shape?

hmmm that seems correct point to me, but then we are going idle and should
ideally power down. Let me check again if that is the reason.

> 
> >+	}
> >+
> >+	/* Program params */
> >+	ret = sdw_program_params(bus);
> >+	if (ret < 0) {
> >+		dev_err(bus->dev, "Program params failed: %d", ret);
> >+		return ret;
> >+	}
> >+
> >+	return do_bank_switch(stream);
> >+
> >+exit:
> >+	stream->state = SDW_STREAM_DEPREPARED;
> >+
> >+	return ret;
> >+}

-- 
~Vinod
