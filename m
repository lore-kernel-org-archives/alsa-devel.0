From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/7] ASoC: soc-compress: Deduce stream
	direction
Date: Fri, 19 Apr 2013 18:57:33 +0530
Message-ID: <20130419132733.GB6081@intel.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
 <7fc1dd75-f695-43eb-8c76-c5aaca52a76a@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A6CC52610CC
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 15:58:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7fc1dd75-f695-43eb-8c76-c5aaca52a76a@opensource.wolfsonmicro.com>
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
Cc: girdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2013 at 11:02:38AM +0100, Charles Keepax wrote:
> Previously we just hard coded all streams as playback streams, this
> patch checks the DAI to see if it is a capture or playback stream. It is
> worth noting that at this time only unidirectional streams are
> supported.
well the intention was the compress device would be either playback or record.
you should have two devices if you support both.

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-compress.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index da83e56..3853f7e 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -384,7 +384,14 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  	/* check client and interface hw capabilities */
>  	snprintf(new_name, sizeof(new_name), "%s %s-%d",
>  			rtd->dai_link->stream_name, codec_dai->name, num);
> -	direction = SND_COMPRESS_PLAYBACK;
> +
> +	if (codec_dai->driver->playback.channels_min)
> +		direction = SND_COMPRESS_PLAYBACK;
> +	else if (codec_dai->driver->capture.channels_min)
> +		direction = SND_COMPRESS_CAPTURE;
> +	else
> +		return -EINVAL;
> +
>  	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
>  	if (compr == NULL) {
>  		snd_printk(KERN_ERR "Cannot allocate compr\n");
> -- 
> 1.7.2.5
> 
