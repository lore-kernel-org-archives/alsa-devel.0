From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/4] ASoC: OMAP3: Report delay on
	playback	caused by the internal FIFO
Date: Tue, 2 Mar 2010 13:47:07 +0000
Message-ID: <20100302134707.GF10658@sirena.org.uk>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B7E5D1038E7
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:47:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267537191-25254-5-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2010 at 03:39:51PM +0200, Peter Ujfalusi wrote:

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		fifo_use = omap_mcbsp_get_tx_buffstat(mcbsp_data->bus_id);
> +	else
> +		return 0;

You're already handling the playback vs. capture thing here! :)

> +	/*
> +	 * Devide the used locations with the channel count to get the

Divide.
