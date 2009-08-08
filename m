From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: DaVinci: i2s,
 reduce underruns by combining into 1 element
Date: Sat, 8 Aug 2009 09:59:11 +0100
Message-ID: <20090808085911.GE4519@sirena.org.uk>
References: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-2-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-3-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DF8582434A
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 10:59:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249602935-1267-3-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 06, 2009 at 04:55:33PM -0700, Troy Kisky wrote:

> @@ -37,6 +37,12 @@ struct snd_platform_data {
>  	u32 rx_dma_offset;
>  	enum dma_event_q eventq_no;	/* event queue number */
>  	unsigned int codec_fmt;
> +	/*
> +	 * Allowing this is more efficient and eliminates left and right swaps
> +	 * caused by underruns, but will swap the left and right channels
> +	 * when compared to previous behavior.
> +	 */
> +	unsigned disable_channel_combine:1;

It seems rather surprising to have this be enabled by default given that
it does swap the channels - I'd expect it to catch people out and it's
not really obvious that Linux would do something like this and it's not
quite so discoverable as it might be.  On the other hand, it does sound
like a useful performance win though I'm not sure how bad the problems
are in general and if the use of SRAM won't deal with things well
enough.

I'll apply the patch, copying the comment here into the commit message
to make things more discoverable, but I'd strongly suggest considering a
followup patch which changes the default to the original behaviour.  It
might even be worth making the behaviour runtime configurable.
