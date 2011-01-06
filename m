From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC sst v2: Add mid platform driver
Date: Thu, 6 Jan 2011 14:12:15 +0000
Message-ID: <20110106141215.GC6328@opensource.wolfsonmicro.com>
References: <1294152392-8914-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC54724407
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 15:12:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294152392-8914-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, alan@linux.intel.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 04, 2011 at 08:16:32PM +0530, Koul, Vinod wrote:

> This patch adds the platform driver for mid asoc drivers
> This platfrom driver sends commands to sst dsp engine driver for the dai operations.
> For this purpose it depends on intel_sst driver which is currently in staging tree

Wrap lines within changelogs to something less than 80 columns.

> +
> +	spin_lock(&stream->status_lock);
> +	if (stream->stream_status != SST_PLATFORM_RUNNING) {
> +		spin_unlock(&stream->status_lock);
> +		return;
> +	}
> +	spin_unlock(&stream->status_lock);
> +	snd_pcm_period_elapsed(substream);
> +	return;
> +}

This return statement is pointless.  The above code would be much
clearer if you just said something like:

	spin_lock()
	set flag if running
	spin_unlock()

	period_elapsed()

> +	ret_val = sst_platform_init_stream(substream);
> +	if (ret_val)
> +		return ret_val;
> +	substream->runtime->hw.info = SNDRV_PCM_INFO_BLOCK_TRANSFER;
> +	return ret_val;

As with much of the driver the use of blank lines between blocks seems
intermittent.

> +	spin_lock(&stream->status_lock);
> +	if (stream->stream_status == SST_PLATFORM_INIT) {
> +		spin_unlock(&stream->status_lock);
> +		return 0;
> +	}
> +	spin_unlock(&stream->status_lock);

A helper function to do the lock/check would probably make life a lot
easier if you're going to do this a lot so callers could do:

	if (sst_stream_state(stream, SST_PLATFORM_INIT)
		return 0;

or whatever.

> +	return stream->stream_info.buffer_ptr;

I thought you were going to clarify that this isn't exactly a pointer?

> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platfrom: sst-platform");

Typos here - extra space and platform is spelt wrongly.
