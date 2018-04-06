From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 05/13] soundwire: Add helpers for ports
 operations
Date: Fri, 6 Apr 2018 10:35:03 +0530
Message-ID: <20180406050502.GH6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-6-git-send-email-vinod.koul@intel.com>
 <37452688-8d8d-be0f-93cb-45056b68ea04@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CD33266BBC
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 07:01:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <37452688-8d8d-be0f-93cb-45056b68ea04@linux.intel.com>
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

On Thu, Apr 05, 2018 at 06:27:59PM -0500, Pierre-Louis Bossart wrote:

> >+
> >+		/* Wait for completion on port ready */
> >+		port_ready = &s_rt->slave->port_ready[prep_ch.num];
> >+		time_left = wait_for_completion_timeout(port_ready,
> >+				msecs_to_jiffies(dpn_prop->ch_prep_timeout));
> >+
> >+		val = sdw_read(s_rt->slave, SDW_DPN_PREPARESTATUS(p_rt->num));
> >+		val &= p_rt->ch_mask;
> >+		if (!time_left && !val) {
> 
> you sure about this? isn't it if (!time_left || val) ?
> val is one for NotFinished.

Yeah it should be val, thanks for spotting this

> >+			dev_err(&s_rt->slave->dev,
> >+				"Chn prep failed for port:%d", prep_ch.num);
> >+			return -ETIMEDOUT;
> >+		}
> >+	}
> >+
> >+	/* Inform slaves about ports being prepared */
> 
> about ports prepared.

ok

> >  /**
> >+ * struct sdw_enable_ch: Enable/disable Data Port channel
> >+ *
> >+ * @num: Port number
> >+ * @ch_mask: Active channel mask
> >+ * @enable: Enable (true) /disable (false) channel
> >+ */
> >+struct sdw_enable_ch {
> >+	unsigned int num;
> 
> port_num then?

yeah doesnt hurt

-- 
~Vinod
