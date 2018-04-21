From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 05/13] soundwire: Add helpers for ports
 operations
Date: Sat, 21 Apr 2018 21:23:32 +0530
Message-ID: <20180421155331.GL6014@localhost>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-6-git-send-email-vinod.koul@intel.com>
 <50695e9e-c9a2-9636-d982-64f8c570cc06@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 116F6267230
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 17:48:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50695e9e-c9a2-9636-d982-64f8c570cc06@linux.intel.com>
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

On Sat, Apr 21, 2018 at 06:47:24AM -0700, Pierre-Louis Bossart wrote:
> 
> >+static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
> >+				struct sdw_slave_runtime *s_rt,
> >+				struct sdw_port_runtime *p_rt, bool en)
> >+{
> >+	struct sdw_transport_params *t_params = &p_rt->transport_params;
> >+	u32 addr;
> >+	int ret;
> >+
> >+	if (bus->params.next_bank)
> >+		addr = SDW_DPN_CHANNELEN_B1(p_rt->num);
> >+	else
> >+		addr = SDW_DPN_CHANNELEN_B0(p_rt->num);
> >+
> >+	/*
> >+	 * Since bus doesn't support sharing a port across two streams,
> >+	 * it is safe to reset this register
> >+	 */
> >+	if (en)
> >+		ret = sdw_update(s_rt->slave, addr, 0xFF, p_rt->ch_mask);
> >+	else
> >+		ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
> >+
> >+	if (ret < 0)
> >+		dev_err(&s_rt->slave->dev,
> >+			"Slave chn_en reg write failed:%d port:%d",
> >+			ret, t_params->port_num);
> >+
> >+	return ret;
> >+}
> 
> Add a clarification that this routine only sets the enable/disable bits in
> the relevant bank, the actual enable/disable is done with a bank switch.

Isn't that something spec tells the reader? this is a SDW concept that we
program bank and then switch to have the effect, so why would i add comment
for that?

-- 
~Vinod
