From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA for SoC audio support full duplex problem
Date: Tue, 12 May 2009 11:04:24 +0100
Message-ID: <20090512100423.GG29889@sirena.org.uk>
References: <8fda62c20905120253u42a7f1f9i723888c44541b46f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 930E0103839
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 12:04:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8fda62c20905120253u42a7f1f9i723888c44541b46f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jinjin xu <freebsdxjj@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2009 at 05:53:52PM +0800, jinjin xu wrote:

> I use 2.6.21.5-cfs-v19 on S3C6410(arm),use wm8987 sound card(i2s interface)

This will be with the Samsung BSP...

> soc-core.c:

>         if (playback)
>         {
> 
>                 snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
> 
>         }
> 
>         if (capture)
>         {
> 
>                 snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
>         }
> 

> ens1370.c use two different fops for playback and record(I test it in
> Vmware,It can run on full duplex)
> soc-core.c use the same fops for  playback and record
> 
> It that the problem ?

This is not an issue, ASoC supports full duplex perfectly happily -
where required the drivers can select appropriate behaviour based on the
substream that is passed into them.  Full duplex is fairly widely used
in embedded systems.

> So how to fix it for support full duplex?

You'll need to investigate what the problem is on your system.  I'd
start by checking that the drivers aren't doing excessive initialisation
(eg, disrupting an existing stream when starting a new one).

Note that the Samsung hardware interface makes the two channels very
closely related so the configuration of the recieve and transmit data
paths needs to be identical - it'd probably be useful to compare the
behaviour with that for the s3c24xx drivers, the hardware is very
similar and I believe full duplex works there.
