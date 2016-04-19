From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 2/4] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Tue, 19 Apr 2016 11:55:52 +0530
Message-ID: <20160419062552.GI2274@localhost>
References: <1460457129-23281-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1460457129-23281-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C37682651DB
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 08:21:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1460457129-23281-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 12, 2016 at 11:32:07AM +0100, Charles Keepax wrote:

> + * @state: state to transition the stream to
> + *
> + * Stop the stream and set its state.
> + *
> + * Should be called with compressed device lock held.
> + */
> +int snd_compr_stop_error(struct snd_compr_stream *stream,
> +			 snd_pcm_state_t state)

Do we want the state as an agument here, since we are invoking stop, it
should transistion to the stopped state

> +{
> +	if (stream->runtime->state == state)
> +		return 0;
> +
> +	stream->runtime->state = state;
> +
> +	queue_delayed_work(system_power_efficient_wq, &stream->error_work, 0);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_compr_stop_error);

-- 
~Vinod
