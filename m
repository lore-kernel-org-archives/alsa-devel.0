From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/6] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Thu, 7 Apr 2016 00:40:03 +0000
Message-ID: <1459989603.3136.95.camel@intel.com>
References: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1459938115-25456-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E55926506E
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 02:40:20 +0200 (CEST)
In-Reply-To: <1459938115-25456-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <1A9ED51B6DDA8D4E8C8F7B2E3DD64B85@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-04-06 at 11:21 +0100, Charles Keepax wrote:

> +int snd_compr_stop_xrun(struct snd_compr_stream *stream)
> +{
> +	if (stream->runtime->state == SNDRV_PCM_STATE_XRUN)
> +		return 0;
> +
> +	stream->runtime->state = SNDRV_PCM_STATE_XRUN;
> +
> +	queue_delayed_work(system_power_efficient_wq, &stream
> ->xrun_work, 0);

why do we want to do this in workqueue and not stop the compress stream
immediately.

Also if we do this, then why should pointer return error?


-- 
~Vinod
