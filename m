From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 2/4] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Wed, 20 Apr 2016 11:10:21 -0500
Message-ID: <5717A9ED.50706@linux.intel.com>
References: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1461156003-24422-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 53CE8266652
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 18:10:24 +0200 (CEST)
In-Reply-To: <1461156003-24422-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


> + * snd_compr_stop_error: Report a fatal error on a stream
> + * @stream: pointer to stream
> + * @state: state to transition the stream to
> + *
> + * Stop the stream and set its state.
> + *
> + * Should be called with compressed device lock held.
> + */
> +int snd_compr_stop_error(struct snd_compr_stream *stream,
> +			 snd_pcm_state_t state)
> +{
> +	if (stream->runtime->state == state)
> +		return 0;
> +
> +	stream->runtime->state = state;

Minor nit-pick: should there be a consistency check to make sure the new 
state makes sense - or maybe just a log to help debug? e.g. XRUN should 
only come if the state in run or draining stages, applying the new state 
unconditionally could lead to issues.
And question for my education since I see no lock/mutex: is the state 
always consistent or is there a risk of this state being changed while 
some other thread or interrupt handling modifies it was well?
