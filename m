From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 02/13] soundwire: Add support for
 SoundWire stream management
Date: Tue, 17 Apr 2018 09:16:24 +0530
Message-ID: <20180417034624.GS6014@localhost>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
 <1523892221-16169-3-git-send-email-vinod.koul@intel.com>
 <52ad5fec-c439-0342-9801-855e053aa742@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 41D24266C99
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 05:41:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <52ad5fec-c439-0342-9801-855e053aa742@linux.intel.com>
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

On Mon, Apr 16, 2018 at 06:15:11PM -0500, Pierre-Louis Bossart wrote:

> >+static struct sdw_slave_runtime
> >+*sdw_alloc_slave_rt(struct sdw_slave *slave,
> >+			struct sdw_stream_config *stream_config,
> >+			struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_slave_runtime *s_rt = NULL;
> >+
> >+	s_rt = kzalloc(sizeof(*s_rt), GFP_KERNEL);
> >+	if (!s_rt)
> >+		return NULL;
> >+
> >+
> remove extra line

ok

> >+static void sdw_release_slave_stream(struct sdw_slave *slave,
> >+			struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_slave_runtime *s_rt, *_s_rt;
> >+	struct sdw_master_runtime *m_rt = stream->m_rt;
> >+
> >+	/* Retrieve Slave runtime handle */
> >+	list_for_each_entry_safe(s_rt, _s_rt,
> >+			&m_rt->slave_rt_list, m_rt_node) {
> >+
> >+		if (s_rt->slave == slave) {
> >+			list_del(&s_rt->m_rt_node);
> >+			kfree(s_rt);
> >+			return;
> >+		}
> >+	}
> >+}
> add kernel doc style for sdw_release_master_stream(), with same note that
> it's called with bus_lock held?

done

> 
> >+static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_master_runtime *m_rt = stream->m_rt;
> >+	struct sdw_slave_runtime *s_rt, *_s_rt;
> >+
> >+	list_for_each_entry_safe(s_rt, _s_rt,
> >+			&m_rt->slave_rt_list, m_rt_node)
> >+		sdw_release_slave_stream(s_rt->slave, stream);
> So if the release_master_stream is called first it'll call
> sdw_release_slave_stream(), so sdw_stream_remove_slave() will in effect do
> nothing?
> 
> I guess it's the dual of what happens for allocation - where the master_rt
> might be allocated by the first slave_add but might be worth a comment or
> two so that people understand the intent and don't believe it's a design
> issue.

Yes makes sense, added now

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
> >+			(stream->params.rate != stream_config->frame_rate)) {
> >+		dev_err(dev, "rate not matching, stream:%s", stream->name);
> >+		return -EINVAL;
> >+	}
> >+
> >+	if ((stream->params.bps) &&
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
> I just realized this will not work for device-to-device communication. You
> have to count all TX ports or all RX ports, not the ports for Slaves.

Correct, will update the check when we add support for device-to-device
communication

-- 
~Vinod
