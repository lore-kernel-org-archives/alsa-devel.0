From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 2/4] ASoC: core: Add delay operation to
	snd_soc_dai_ops
Date: Tue, 2 Mar 2010 15:49:33 +0200
Message-ID: <201003021549.33189.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-3-git-send-email-peter.ujfalusi@nokia.com>
	<20100302134508.GD10658@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 627B11038EA
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:49:39 +0100 (CET)
In-Reply-To: <20100302134508.GD10658@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 02 March 2010 15:45:08 ext Mark Brown wrote:
> On Tue, Mar 02, 2010 at 03:39:49PM +0200, Peter Ujfalusi wrote:
> > +	/* Query the delay only for playback stream */
> > +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> > +		if (cpu_dai->ops->delay)
> > +			delay += cpu_dai->ops->delay(substream, cpu_dai);
> > +
> > +		if (codec_dai->ops->delay)
> > +			delay += codec_dai->ops->delay(substream, codec_dai);
> > +
> > +		runtime->delay = delay;
> > +	}
> 
> I'd be inclined to leave this up to the drivers to avoid surprises if it
> becomes useful for the capture case in the future.  Not sure that that's
> likely, but I'd rather avoid potential future transitions.

Sure, actually I have added this check later, since I had some trouble to make 
sensible reporting on the capture path.
But sure, I can remove this check and leave it to the dais to deal with.

Thanks
Peter
