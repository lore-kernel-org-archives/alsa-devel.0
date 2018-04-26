From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v5 07/13] soundwire: Add stream
	configuration APIs
Date: Thu, 26 Apr 2018 09:30:16 +0530
Message-ID: <20180426040016.GA15388@buildpc-HP-Z230>
References: <1524649163-12088-1-git-send-email-vkoul@kernel.org>
 <1524649163-12088-8-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8410F26772B
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 06:00:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1524649163-12088-8-git-send-email-vkoul@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vkoul@kernel.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 25, 2018 at 03:09:17PM +0530, Vinod Koul wrote:
> From: Sanyog Kale <sanyog.r.kale@intel.com>
> 
> Add APIs for prepare, enable, disable and de-prepare stream.
> 
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soundwire/bus.c       |   9 ++
>  drivers/soundwire/stream.c    | 246 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/soundwire/sdw.h |   4 +
>  3 files changed, 259 insertions(+)
> 
> +
> +static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_master_runtime *m_rt = stream->m_rt;
> +	struct sdw_bus *bus = m_rt->bus;
> +	int ret = 0;
> +
> +	/* De-prepare port(s) */
> +	ret = sdw_prep_deprep_ports(m_rt, false);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "De-prepare port(s) failed: %d", ret);
> +		return ret;
> +	}
> +
> +	/* TODO: Update this during Device-Device support */
> +	bus->params.bandwidth -= m_rt->stream->params.rate *
> +		m_rt->ch_count * m_rt->stream->params.bps;
> +

We should have kept zero bandwidth check here because there is no need
to perform sdw_program_params when no stream is running on bus.

> +	/* Program params */
> +	ret = sdw_program_params(bus);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Program params failed: %d", ret);
> +		return ret;
> +	}
> +
> +	return do_bank_switch(stream);

Change the state to DEPREPARE and then return.

> +
> +	stream->state = SDW_STREAM_DEPREPARED;
> +
> +	return ret;
> +}
> +
>  
> -- 
> 2.7.4
> 

-- 
