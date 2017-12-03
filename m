From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 04/15] soundwire: Add MIPI DisCo
 property helpers
Date: Sun, 3 Dec 2017 22:22:03 +0530
Message-ID: <20171203165203.GM32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-5-git-send-email-vinod.koul@intel.com>
 <4a79c26c-db39-700c-627b-f474200f9a7f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 947DB266B0F
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 17:48:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4a79c26c-db39-700c-627b-f474200f9a7f@linux.intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 01, 2017 at 04:49:01PM -0600, Pierre-Louis Bossart wrote:

> >+int sdw_master_read_prop(struct sdw_bus *bus)
> >+{
> >+	struct sdw_master_prop *prop = &bus->prop;
> >+	struct fwnode_handle *link;
> >+	unsigned int count = 0;
> >+	char name[32];
> >+	int nval, i;
> >+
> >+	device_property_read_u32(bus->dev,
> >+			"mipi-sdw-sw-interface-revision", &prop->revision);
> >+	device_property_read_u32(bus->dev, "mipi-sdw-master-count", &count);
> >+
> >+	/* Find link handle */
> >+	snprintf(name, sizeof(name),
> >+			"mipi-sdw-link-%d-subproperties", bus->link_id);
> 
> if you follow the DisCo spec, this property is at the controller level,
> isn't there a confusion between controller/master here, and consequently are
> we reading the same things multiple times or using the wrong bus parameter?

Not sure I follow, this one is for a specific master ie a specfic link.
we need to read respective master thru mipi-sdw-link-N-subproperties

> If I look at intel_probe(), there is a clear reference to a link_id, and
> then you set the pointer to this read_prop which reads the number of links,
> which looks like the wrong order. You can't assign a link ID before knowing
> how many links there are - or you may be unable to detect issues.

Sorry I dont follow this part. FWIW, when master driver is enumerated it
know the link_id value and then sets the read_prop and then these are read.

Here we are reading "a specific link property" with the knowledge of link_id
value...

> >+	fwnode_property_read_u32(link, "mipi-sdw-default-frame-rate",
> >+				&prop->default_frame_rate);
> >+	fwnode_property_read_u32(link, "mipi-sdw-default-frame-row-size",
> >+				&prop->default_row);
> >+	fwnode_property_read_u32(link, "mipi-sdw-default-frame-col-size",
> 
> This is fine, just wondering if we should warnings if the values make no
> sense, e.g. the DisCo spec states in Note1 page 15 that the values are
> interrelated.

I think we discussed in past and that would kind of form the firmware
validation. We check all the values to see if firmware gave us sane values..

> >+	/*
> >+	 * Based on each DPn port, get source and sink dpn properties.
> >+	 * Also, some ports can operate as both source or sink.
> >+	 */
> >+
> >+	/* Allocate memory for set bits in port lists */
> >+	nval = hweight32(prop->source_ports);
> >+	num_of_ports += nval;
> 
> this and...
> 
> >+	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
> >+				sizeof(*prop->src_dpn_prop), GFP_KERNEL);
> >+	if (!prop->src_dpn_prop)
> >+		return -ENOMEM;
> >+
> >+	/* Read dpn properties for source port(s) */
> >+	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
> >+			prop->source_ports, "source");
> >+
> >+	nval = hweight32(prop->sink_ports);
> >+	num_of_ports += nval;
> 
> ... this is no longer needed since...
> 
> >+	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
> >+				sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
> >+	if (!prop->sink_dpn_prop)
> >+		return -ENOMEM;
> >+
> >+	/* Read dpn properties for sink port(s) */
> >+	sdw_slave_read_dpn(slave, prop->sink_dpn_prop, nval,
> >+			prop->sink_ports, "sink");
> >+
> >+	/* some ports are bidirectional so check total ports by ORing */
> >+	nval = prop->source_ports | prop->sink_ports;
> >+	num_of_ports = hweight32(nval) + 1; /* add 1 for DP0 */
> 
> ... you reassign the value here. That was one earlier feedback from me but
> you left the variable incrementation in the code.

This seems to have artifact of merge conflicts as I clearly remember removing
this, thanks for pointing will remove these..

> >+/**
> >+ * enum sdw_clk_stop_mode - Clock Stop modes
> >+ * @SDW_CLK_STOP_MODE0: Slave can continue operation seamlessly on clock
> >+ * restart
> >+ * @SDW_CLK_STOP_MODE1: Slave may have entered a deeper power-saving mode,
> >+ * not capable of continuing operation seamlessly when the clock restarts
> >+ */
> >+enum sdw_clk_stop_mode {
> >+	SDW_CLK_STOP_MODE0 = 1,
> >+	SDW_CLK_STOP_MODE1 = 2,
> 
> why not 0 and 1?

why not 1 and 2 :D

I think it was to ensure we have a non zero value, but am not sure, will
check though..

-- 
~Vinod
