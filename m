From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 06/13] soundwire: Add bank switch routine
Date: Thu, 5 Apr 2018 18:35:26 -0500
Message-ID: <b34d6646-3d3e-bc2a-c59b-fcbe23a868aa@linux.intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AFF6267299
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 01:35:30 +0200 (CEST)
In-Reply-To: <1522946904-2089-7-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


> +static int _sdw_bank_switch(struct sdw_bus *bus)
> +{
> +	int col_index, row_index;
> +	struct sdw_msg *wr_msg;
> +	u8 *wbuf = NULL;
> +	int ret = 0;
> +	u16 addr;
> +
> +	wr_msg = kzalloc(sizeof(*wr_msg), GFP_KERNEL);
> +	if (!wr_msg)
> +		return -ENOMEM;
> +
> +	wbuf = kzalloc(sizeof(*wbuf), GFP_KERNEL);
> +	if (!wbuf) {
> +		ret = -ENOMEM;
> +		goto error_1;
> +	}
> +
> +	/* Get row and column index to program register */
> +	col_index = sdw_find_col_index(bus->params.col);
> +	row_index = sdw_find_row_index(bus->params.row);
> +	wbuf[0] = col_index | (row_index << 3);
> +
> +	if (bus->params.next_bank)
> +		addr = SDW_SCP_FRAMECTRL_B1;
> +	else
> +		addr = SDW_SCP_FRAMECTRL_B0;
> +
> +	sdw_fill_msg(wr_msg, NULL, addr, 1, SDW_BROADCAST_DEV_NUM,
> +					SDW_MSG_FLAG_WRITE, wbuf);
> +	wr_msg->ssp_sync = true;
> +
> +	ret = sdw_transfer(bus, wr_msg);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Slave frame_ctrl reg write failed");
> +		goto error;
> +	}
> +
> +	kfree(wr_msg);
> +	kfree(wbuf);
> +	bus->defer_msg.msg = NULL;
> +	bus->params.curr_bank = !bus->params.curr_bank;
> +	bus->params.next_bank = !bus->params.next_bank;
> +
> +	return 0;
> +
> +error:
> +	kfree(wbuf);
> +error_1:
> +	kfree(wr_msg);
> +	return ret;
> +}
> +
> +static int sdw_bank_switch(struct sdw_bus *bus)
> +{
> +	const struct sdw_master_ops *ops = bus->ops;
> +	int ret = 0;
> +
> +	/* Pre-bank switch */
> +	if (ops->pre_bank_switch) {
> +		ret = ops->pre_bank_switch(bus);
> +		if (ret < 0) {
> +			dev_err(bus->dev, "Pre bank switch op failed: %d", ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Bank-switch */
> +	ret = _sdw_bank_switch(bus);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Bank switch op failed: %d", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sdw_post_bank_switch(struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_master_runtime *m_rt = stream->m_rt;
> +	const struct sdw_master_ops *ops;
> +	struct sdw_bus *bus = m_rt->bus;
> +	int ret = 0;
> +
> +	ops = bus->ops;
> +
> +	/* Post-bank switch */
> +	if (ops->post_bank_switch) {
> +		ret = ops->post_bank_switch(bus);
> +		if (ret < 0) {
> +			dev_err(bus->dev,
> +					"Post bank switch op failed: %d", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int do_bank_switch(struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_master_runtime *m_rt = stream->m_rt;
> +	struct sdw_bus *bus = m_rt->bus;
> +	int ret;
> +
> +	/* Bank switch */
> +	ret = sdw_bank_switch(bus);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Bank switch failed: %d", ret);
> +		goto err;
> +	}
> +
> +	ret = sdw_post_bank_switch(stream);
> +	if (ret < 0)
> +		dev_err(bus->dev, "Post Bank switch failed: %d", ret);

The structure of the code makes little sense here, it could be
pre-bank-switch();
bank-switch();
post-band-switch();
in the same routine.

you need to add information that post-bank will need handled in a 
specific manner with multi-link streams.



> +
> +err:
> +	return ret;
> +}
> +
