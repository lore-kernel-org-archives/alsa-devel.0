From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 08/14] soundwire: Add Slave status
	handling helpers
Date: Thu, 16 Nov 2017 22:38:50 +0530
Message-ID: <20171116170850.GF3187@localhost>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-9-git-send-email-vinod.koul@intel.com>
 <06a1bcfc-eeca-b3ec-1d74-e6ac9cadce53@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7340C266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 18:05:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <06a1bcfc-eeca-b3ec-1d74-e6ac9cadce53@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, Sudheer Papothi <spapothi@codeaurora.org>, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 04:05:29PM +0000, Srinivas Kandagatla wrote:
> 
> Minor Comment!
> 
> On 10/11/17 11:49, Vinod Koul wrote:
> >From: Sanyog Kale <sanyog.r.kale@intel.com>
> >
> >SoundWire Slaves report status to bus. Add helpers to handle
> >the status changes.
> >
> >Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
> >Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> >Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> >---
> 
> >+static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
> >+{
> >+
> >+	if ((slave->id.unique_id != id.unique_id) ||
> >+	    (slave->id.mfg_id != id.mfg_id) ||
> >+	    (slave->id.part_id != id.part_id) ||
> >+	    (slave->id.class_id != id.class_id))
> >+		return -ENODEV;
> >+
> >+	return 0;
> >+}
> >+
> >+/* called with bus_lock held */
> >+static int sdw_get_device_num(struct sdw_slave *slave)
> >+{
> If we use ida we would not need this function.

Not really, find_first_zero_bit and set_bit will be replaced by get_ida()

the bound check will still be required as we have finite set of ids to work
with. Nevertheless I will check if it helps in this case and move if
helpful.

> >+	int bit;
> >+
> >+	bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
> >+	if (bit == SDW_MAX_DEVICES) {
> >+		bit = -ENODEV;
> >+		goto err;
> >+	}
> >+
> >+	/*
> >+	 * Do not update dev_num in Slave data structure here,
> >+	 * Update once program dev_num is successful
> >+	 */
> >+	set_bit(bit, slave->bus->assigned);
> >+
> >+err:
> >+	return bit;
> >+}

-- 
~Vinod
