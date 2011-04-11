From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Lower the OSC
 calibration time
Date: Mon, 11 Apr 2011 21:05:32 +0800
Message-ID: <20110411130532.GC11072@qtel.sh.intel.com>
References: <1302526664-1497-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 701071037F9
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 15:06:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302526664-1497-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 11, 2011 at 08:57:44PM +0800, Peter Ujfalusi wrote:
> To get correct calibration, we can decrease the time
> needed for the OSC to calibrate itself.
> With this change we can safe ~15ms in the OSC

s/safe/save/

> calibration phase.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tlv320dac33.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index c109f6d..401a7ce 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -946,8 +946,8 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
>  	/* Write registers 0x08 and 0x09 (MSB, LSB) */
>  	dac33_write16(codec, DAC33_INT_OSC_FREQ_RAT_A, oscset);
>  
> -	/* calib time: 128 is a nice number ;) */
> -	dac33_write(codec, DAC33_CALIB_TIME, 128);
> +	/* OSC calibration time */
> +	dac33_write(codec, DAC33_CALIB_TIME, 96);
>  
>  	/* adjustment treshold & step */
>  	dac33_write(codec, DAC33_INT_OSC_CTRL_B, DAC33_ADJTHRSHLD(2) |
> -- 
> 1.7.4.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
guanqun
