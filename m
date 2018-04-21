From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 05/13] soundwire: Add helpers for ports
 operations
Date: Sat, 21 Apr 2018 06:39:13 -0700
Message-ID: <df19c739-9658-b1ee-f48c-b182afa352d0@linux.intel.com>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F71C267232
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 17:02:58 +0200 (CEST)
In-Reply-To: <1524049146-8725-6-git-send-email-vinod.koul@intel.com>
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


> +static int sdw_enable_disable_mstr_ports(struct sdw_master_runtime *m_rt,
> +			struct sdw_port_runtime *p_rt, bool en)
> +{
> +	struct sdw_transport_params *t_params = &p_rt->transport_params;
> +	struct sdw_bus *bus = m_rt->bus;
> +	struct sdw_enable_ch enable_ch;
> +	int ret = 0;
> +
> +	enable_ch.port_num = p_rt->num;
> +	enable_ch.ch_mask = p_rt->ch_mask;
> +	enable_ch.enable = en;
> +
> +	/* Perform Master port channel(s) enable/disable */
> +	if (bus->port_ops->dpn_port_enable_ch) {
> +		ret = bus->port_ops->dpn_port_enable_ch(bus,
> +				&enable_ch, bus->params.next_bank);
> +		if (ret < 0) {
> +			dev_err(bus->dev,
> +				"Master chn_en write failed:%d port:%d",
> +				ret, t_params->port_num);
> +			return ret;
> +		}
> +	} else {
> +		dev_err(bus->dev,
> +			"dpn_port_enable_ch not supported, trying %s\n",
> +			en ? "enable" : "disable");

the error message is a bit confusing, you are not trying anything here.
Should it be
"dpn_port_enable_ch not supported, %s failed\n", en ? "enable" : "disable"
