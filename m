From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 03/13] soundwire: Add support for port
 management
Date: Fri, 6 Apr 2018 10:30:29 +0530
Message-ID: <20180406050029.GF6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-4-git-send-email-vinod.koul@intel.com>
 <a5240b66-759a-7a46-8274-e975075ad682@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C6EF1266BBC
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 06:56:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a5240b66-759a-7a46-8274-e975075ad682@linux.intel.com>
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

On Thu, Apr 05, 2018 at 06:04:32PM -0500, Pierre-Louis Bossart wrote:
> On 4/5/18 11:48 AM, Vinod Koul wrote:

> >@@ -70,6 +93,7 @@ struct sdw_slave_runtime {
> >   * @ch_count: Number of channels handled by the Master for
> >   * this stream
> >   * @slave_rt_list: Slave runtime list
> >+ * @port_list: List of Master Ports configured for this stream
> 
> possibly empty for device to device communication.

Not in scope, will add in that series

> >+static void sdw_master_port_deconfig(struct sdw_bus *bus,
> >+			struct sdw_master_runtime *m_rt)
> >+{
> >+	struct sdw_port_runtime *p_rt, *_p_rt;
> >+
> >+	list_for_each_entry_safe(p_rt, _p_rt,
> >+			&m_rt->port_list, port_node) {
> >+
> >+		list_del(&p_rt->port_node);
> >+		kfree(p_rt);
> >+	}
> >+}
> 
> I still don't get the naming conventions. There is no DECONFIGURED state,
> why not call it release? In which state is this called?

it is NOT about stream state, but deconfigure the ports. Well we can make it
sdw_master_port_release() if that makes you happy!

> 
> >+
> >+static void sdw_slave_port_deconfig(struct sdw_bus *bus,
> >+		struct sdw_slave *slave,
> >+		struct sdw_stream_runtime *stream)
> >+{
> >+	struct sdw_port_runtime *p_rt, *_p_rt;
> >+	struct sdw_master_runtime *m_rt = stream->m_rt;
> >+	struct sdw_slave_runtime *s_rt;
> >+
> >+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> >+
> >+		if (s_rt->slave != slave)
> >+			continue;
> >+
> >+		list_for_each_entry_safe(p_rt, _p_rt,
> >+				&s_rt->port_list, port_node) {
> >+
> >+			list_del(&p_rt->port_node);
> >+			kfree(p_rt);
> >+		}
> 
> can we use common code between master and slaves? This looks virtually
> identical.

Nope it is not, we tried in past and end result looked uglier.
Only 4 lines of code are same and previous one iterates
over master and here we have slave...

> >  int sdw_stream_remove_slave(struct sdw_slave *slave,
> >  		struct sdw_stream_runtime *stream)
> >  {
> >  	mutex_lock(&slave->bus->bus_lock);
> >+	sdw_slave_port_deconfig(slave->bus, slave, stream);
> 
> then call it sdw_slave_port_release as I mentioned above...

ok

> >+static int sdw_master_port_config(struct sdw_bus *bus,
> >+			struct sdw_master_runtime *m_rt,
> >+			struct sdw_port_config *port_config,
> >+			unsigned int num_ports)
> >+{
> >+	struct sdw_port_runtime *p_rt;
> >+	int i, ret;
> >+
> >+	/* Iterate for number of ports to perform initialization */
> >+	for (i = 0; i < num_ports; i++) {
> >+
> >+		p_rt = sdw_port_alloc(bus->dev, port_config, i);
> >+		if (!p_rt)
> >+			return -ENOMEM; > +
> >+		ret = sdw_is_valid_port_range(bus->dev, p_rt);
> 
> a master has no definition of ports. You could have more than 14 ports.
> Even if you have a description of those ports, it has to be checking not for
> the standard definition but what the hardware can support

ok will remove check for master

> >+static int sdw_slave_port_config(struct sdw_slave *slave,
> >+			struct sdw_slave_runtime *s_rt,
> >+			struct sdw_port_config *port_config,
> >+			unsigned int num_config)
> >+{
> >+	struct sdw_port_runtime *p_rt;
> >+	int i, ret;
> >+
> >+	/* Iterate for number of ports to perform initialization */
> >+	for (i = 0; i < num_config; i++) {
> >+
> >+		p_rt = sdw_port_alloc(&slave->dev, port_config, i);
> >+		if (!p_rt)
> >+			return -ENOMEM;
> >+
> >+		ret = sdw_is_valid_port_range(&slave->dev, p_rt);
> 
> this is optimistic. You should check the actual port range (as defined in
> DisCo properties or driver), not just the worst case allowed by the
> standard.
> This should include a check that the bi-dir ports are configured for the
> right role and that the direction is compatible for regular fixed-direction
> ports.

well this is better that no check but yes that can be further improved in
future to comprehend DisCo properties and port direction. I will add that to
my list

-- 
~Vinod
