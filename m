From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 12/15] soundwire: cdns: Add
 sdw_master_ops and IO transfer support
Date: Fri, 1 Dec 2017 18:02:24 -0600
Message-ID: <a3167578-df2b-e871-cd5e-94adcc549a4e@linux.intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-13-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id C39B72670F4
 for <alsa-devel@alsa-project.org>; Sat,  2 Dec 2017 01:02:28 +0100 (CET)
In-Reply-To: <1512122177-2889-13-git-send-email-vinod.koul@intel.com>
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
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


>   struct sdw_cdns {
>   	struct device *dev;
>   	struct sdw_bus bus;
>   	unsigned int instance;
>   
> +	u32 response_buf[0x80];

last nit-pick: use a #define for the size.
Also are you sure about the value? I vaguely recall that the FIFO was 
32-deep, you are confusing bytes and words here?

> +	struct completion tx_complete;
> +	struct sdw_defer *defer;
> +
>   	void __iomem *registers;
>   
>   	bool link_up;
> +	unsigned int msg_count;
>   };
>   
