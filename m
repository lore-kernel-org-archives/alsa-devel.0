From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 2/2] ASoC: add compress stream support
Date: Thu, 2 Aug 2012 19:09:27 +0100
Message-ID: <20120802180926.GL4537@opensource.wolfsonmicro.com>
References: <1343716900-23491-1-git-send-email-vinod.koul@linux.intel.com>
 <1343716900-23491-3-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6743265D83
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 20:09:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343716900-23491-3-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, namartax.kohli@intel.com, lrg@ti.com, ramesh.babu@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 12:11:40PM +0530, Vinod Koul wrote:
> From: Namarta Kohli <namartax.kohli@intel.com>
> 
> This patch adds the support to parse the compress dai's and then also adds the
> soc-compress.c file while handles the compress stream operations, mostly analogous 
> to what is done in the soc-pcm.c and additional handling of the compress
> operations

This is all mostly fine, though it's very sad that there's so much code
duplication between this and the regular PCM streams.  Some smallish
comments below.

> +	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
> +		cpu_dai->playback_active++;
> +		codec_dai->playback_active++;
> +	} else {
> +		cpu_dai->capture_active++;
> +		codec_dai->capture_active++;
> +	}
> +	cpu_dai->active++;
> +	codec_dai->active++;

In quite a few places in the code there's missing blanks between blocks
of code.

> +int soc_compr_set_params(struct snd_compr_stream *cstream,
> +					struct snd_compr_params *params)
> +{

> +	snd_soc_dai_digital_mute(codec_dai, 0);

This looks wrong - the unmute should be associated with the start of the
data transfer rather than the configuration.  But we don't have any
other ops...  can we have one, or a non-atomic trigger?

> +	/* check client and interface hw capabilities */
> +	snprintf(new_name, sizeof(new_name), "%s %s-%d",
> +			rtd->dai_link->stream_name, codec_dai->name, num);
> +	/* TODO add support for cature */

Meow :)

> +	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
> +		cpu_dai->name);

Say it's a compressed mapping?

> +	if (cpu_dai->driver->compress_dai) {
> +		/*create compress device*/
> +		ret = soc_new_compress(rtd, num);
> +		if (ret < 0 ) {
> +			printk(KERN_ERR "asoc: can't create offload %s\n",
> +					 dai_link->stream_name);
> +			return ret;
> +		}

Should we be complaining here if there's PCM operations too?
Alternatively, should we support mixed PCM and compressed DAIs (possibly
be creating two pcms from a single dai_link)?
