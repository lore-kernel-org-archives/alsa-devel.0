From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 02/13] soundwire: Add support for
 SoundWire stream management
Date: Fri, 6 Apr 2018 10:23:39 +0530
Message-ID: <20180406045338.GE6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-3-git-send-email-vinod.koul@intel.com>
 <bd17bb61-11cb-c1d5-d9cc-29cb9b01d928@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B21A266BBC
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 06:49:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd17bb61-11cb-c1d5-d9cc-29cb9b01d928@linux.intel.com>
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

On Thu, Apr 05, 2018 at 05:34:18PM -0500, Pierre-Louis Bossart wrote:
> On 4/5/18 11:48 AM, Vinod Koul wrote:

> >+/**
> >+ * sdw_master_runtime: Runtime stream parameters for Master
> >+ *
> >+ * @bus: Bus handle
> >+ * @stream: Stream runtime handle
> >+ * @direction: Data direction for Master
> >+ * @ch_count: Number of channels handled by the Master for
> >+ * this stream
> 
> Didn't we say that this count could be zero for device-to-device
> communication? 'handled by the Master' is not really correct.

Yes for device-to-device this would be zero. And master will handle no
channels as indicated by zero value. Won't that be right?

> >+ * @slave_rt_list: Slave runtime list
> >+ * @bus_node: sdw_bus m_rt_list node
> 
> I think the intention was to progress in steps, but by omitting references
> to the multi-master case in this series or comments explaining the next
> steps the structure and code are not easy to follow.

We cannot have any ref to multi-master as it is not in this series. That is how
patches would be done, you add a step and then increment with another.

Ofcourse if you have any question feel free to ask and we can clarify, but I
do not think it would be correct to add comments/reference here for
multi-master. These will be updated as required when we post multi-master.

> There should be a clear explanation that
> - a stream can be connected a least one Slave Device with one or more ports.

explained in document patch

> - a stream may be connected to zero or more Master Devices. In the former
> case one of the Slave devices has provide TX ports.

That's multi-link/device-device not under review here

> - the slave runtime keeps track of all the masters the stream is connected
> to

not that is not a correct assumption

> - the master runtime keeps track of
> 1. all the Slaves it is physically connected to which support a stream.

Yes that is added here

> 2. all bus instances (and related masters) that support this stream.

That's again multi-link!

Again we are not writing a spec but code and comments to explain the code.
The above is not related to "this" series so we should not add it here. When
we add device-device support, multi-master support these can be added

We are adding blocks in a giant building, but you are only looking at the
giant picture but not the block in discussion!

> >+/**
> >+ * sdw_alloc_stream: Allocate and return stream runtime
> >+ *
> >+ * @stream_name: SoundWire stream name
> >+ *
> >+ * Allocates a SoundWire stream runtime instance.
> >+ * sdw_alloc_stream should be called only once per stream
> 
> You should explain who the caller might be, and probably check if a stream
> with the same name was not already allocated.

Checking name might be bit iffy as we would need to check all streams. The
name is used for prints so if caller screws up name then it would be at his
own peril to get confused between same stream names in logs :)

> >+static struct sdw_master_runtime
> >+*sdw_alloc_master_rt(struct sdw_bus *bus,
> >+			struct sdw_stream_config *stream_config,
> >+			struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_master_runtime *m_rt;
> >+
> >+	m_rt = stream->m_rt;
> >+	if (m_rt)
> >+		goto stream_config;
> 
> I know there is a reason for this code pattern but I just can't remember it
> and there is no comment indicated why this is valid.

If m_rt is already allocated we skip the initialization and configure it.
As we have told you earlier, the slave runtime can be added which triggers
master runtime to be allocated as well, so we need to check.

We do have such a comment in sdw_stream_add_slave() as you advised. Should
we duplicate it here too?

> >+int sdw_stream_add_master(struct sdw_bus *bus,
> >+		struct sdw_stream_config *stream_config,
> >+		struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_master_runtime *m_rt = NULL;
> >+	int ret;
> >+
> >+	if (stream->state != SDW_STREAM_ALLOCATED &&
> >+			stream->state != SDW_STREAM_CONFIGURED) {
> >+		dev_err(bus->dev,
> >+			"Invalid stream state %d", stream->state);
> >+		return -EINVAL;
> >+	}
> 
> Humm, this check looks like new code but I don't get it. Why would one add a
> master in either of those two states? Why not ALLOCATED only?

So slave or master can be added to a stream in any order. Only if slave is
called first we need master_rt to be allocated too. In ideal world we would
do allocation and then configuration, but due to user calling in any order
we may do allocation and configuration of slave first followed by
configuring the master.

> 
> The documentation states that:
> 
> +SDW_STREAM_CONFIGURED
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Configuration state of stream. Operations performed before entering in
> +this state:
> +
> +  (1) The resources allocated for stream information in
> SDW_STREAM_ALLOCATED
> +      state are updated here. This includes stream parameters, Master(s)
> +      and Slave(s) runtime information associated with current stream.
> +
> +  (2) All the Master(s) and Slave(s) associated with current stream provide
> +      the port information to Bus which includes port numbers allocated by
> +      Master(s) and Slave(s) for current stream and their channel mask.
> 
> so how can Master ports be configured if it is added to a stream *after* the
> CONFIGURED state?

Yes you have a valid point wrt documentation, will update it.

> 
> >+
> >+	mutex_lock(&bus->bus_lock);
> >+
> >+	m_rt = sdw_alloc_master_rt(bus, stream_config, stream);
> >+	if (!m_rt) {
> >+		dev_err(bus->dev,
> >+				"Master runtime config failed for stream:%s",
> >+				stream->name);
> >+		ret = -ENOMEM;
> >+		goto error;
> >+	}
> >+
> >+	ret = sdw_config_stream(bus->dev, stream, stream_config, false);
> >+	if (ret)
> >+		goto stream_error;
> >+
> >+	if (!list_empty(&m_rt->slave_rt_list) &&
> >+			stream->state == SDW_STREAM_ALLOCATED)
> >+		stream->state = SDW_STREAM_CONFIGURED;
> 
> this looks also like new code, what is the idea about this configuration
> business?
> To me this is inconsistent with the documentation which says
> sdw_stream_add_master is called in ALLOCATED state. Under what circumstances
> would this routing be called from two different states?

Yes it "may" be due to sequencing in callers control.

> This may be ok but the intent is clear as mud.

Yes that is a bit unfortunate :(

> >+int sdw_stream_add_slave(struct sdw_slave *slave,
> >+		struct sdw_stream_config *stream_config,
> >+		struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_slave_runtime *s_rt;
> >+	struct sdw_master_runtime *m_rt;
> >+	int ret;
> >+
> >+	if (stream->state != SDW_STREAM_ALLOCATED &&
> >+			stream->state != SDW_STREAM_CONFIGURED) {
> >+		dev_err(&slave->dev,
> >+			"Invalid stream state %d", stream->state);
> >+		return -EINVAL;
> >+	}
> 
> same as for the master, why would one call this routine from two separate
> states?

as discussed above

> 
> >+
> >+	mutex_lock(&slave->bus->bus_lock);
> >+
> >+	/*
> >+	 * If this API is invoked by slave first then m_rt is not valid.
> >+	 * So, allocate that and add the slave to it.
> >+	 */
> >+	m_rt = sdw_alloc_master_rt(slave->bus, stream_config, stream);
> >+	if (!m_rt) {
> >+		dev_err(&slave->dev,
> >+				"alloc master runtime failed for stream:%s",
> >+				stream->name);
> >+		ret = -ENOMEM;
> >+		goto error;
> >+	}
> >+
> >+	s_rt = sdw_alloc_slave_rt(slave, stream_config, stream);
> >+	if (!s_rt) {
> >+		dev_err(&slave->dev,
> >+				"Slave runtime config failed for stream:%s",
> >+				stream->name);
> >+		ret = -ENOMEM;
> >+		goto stream_error;
> >+	}
> >+
> >+	ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
> >+	if (ret)
> >+		goto stream_error;
> >+
> >+	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
> 
> so you have a potential to add the same node twice from ALLOCATED and
> CONFIGURED states? I am completely lost.

That would be the case if Slave invokes this routine erroneously twice. We expect this
would be called only once by caller.

-- 
~Vinod
