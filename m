From: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] pcm: Don't store the state for
	SND_PCM_STATE_SUSPENDED
Date: Wed, 1 Jun 2016 03:10:41 +0000
Message-ID: <HE1PR04MB2122B936112C26E400A9B5B4E3470@HE1PR04MB2122.eurprd04.prod.outlook.com>
References: <1462866346-11878-1-git-send-email-shengjiu.wang@freescale.com>
 <s5h7ff2b9vx.wl-tiwai@suse.de>
 <HE1PR04MB21229D4BBCC605559F98D3FFE3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hzirx9nv4.wl-tiwai@suse.de>
 <HE1PR04MB212240A8E6692FCFF12DF797E3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hoa8d9iey.wl-tiwai@suse.de>
 <HE1PR04MB2122FD4500AC192F85542DA2E3490@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5h60ubn42y.wl-tiwai@suse.de>
 <HE1PR04MB212271FEAAEFBBE21A2E358FE34B0@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hk2ipknw2.wl-tiwai@suse.de>	<s5hr3cwkdh6.wl-tiwai@suse.de>
 <DB5PR04MB212063DBF8904F58516C3137E34F0@DB5PR04MB2120.eurprd04.prod.outlook.com>
 <s5hvb23hi8l.wl-tiwai@suse.de>	<s5hr3cmwoxd.wl-tiwai@suse.de>
 <HE1PR04MB2122B4E35FAB6FD526D88EEEE3460@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hmvn65wkp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0074.outbound.protection.outlook.com [157.55.234.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AD8A26523B
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 05:10:45 +0200 (CEST)
In-Reply-To: <s5hmvn65wkp.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

> 
> On Tue, 31 May 2016 11:27:39 +0200,
> Shengjiu Wang wrote:
> >
> > Hi
> >
> > >
> > > On Tue, 24 May 2016 12:18:18 +0200,
> > > Takashi Iwai wrote:
> > > >
> > > > On Tue, 24 May 2016 12:12:49 +0200,
> > > > Shengjiu Wang wrote:
> > > > >
> > > > > Hi
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > > Sent: Friday, May 20, 2016 10:32 PM
> > > > > > To: Shengjiu Wang
> > > > > > Cc: perex@perex.cz; alsa-devel@alsa-project.org
> > > > > > Subject: Re: [PATCH] pcm: Don't store the state for
> > > > > > SND_PCM_STATE_SUSPENDED
> > > > > >
> > > > > > On Fri, 20 May 2016 12:46:37 +0200,
> > > > > > Takashi Iwai wrote:
> > > > > > >
> > > > > > > On Fri, 20 May 2016 11:41:25 +0200,
> > > > > > > Shengjiu Wang wrote:
> > > > > > > >
> > > > > > > > Hi Takashi
> > > > > > > >
> > > > > > > >    I tested your patch, after suspend and resume, the
> > > playback is
> > > > > > stopped.
> > > > > > > > It is caused by the DMA. DMA is not started after resume.
> > > > > > > >
> > > > > > > > With your patch, DMA is not terminated but then is re-
> started.
> > > The
> > > > > > driver don't
> > > > > > > > support this behavior.
> > > > > > >
> > > > > > > If so, it's simply a driver bug.  Blame the kernel driver
> > > instead.
> > > > > >
> > > > > > Which driver did you see the problem?  We should fix it.
> > > > >
> > > > > But my thought is when suspended, the dmaengine_pause() is
> called,
> > > then
> > > > > dmaengine_resume() should be called in resume(). If there is no
> > > resume()
> > > > > Just call the prepare() and start(), it seems not reasonable.
> What
> > > do
> > > > > you think?
> > > >
> > > > There are several ways to fix the problem, but the point is that,
> > > from
> > > > the API POV, the direct state change from SUSPENDED to PREPARED
> is
> > > > valid.  So, the kernel driver has to support such a state change,
> no
> > > > matter how.
> > > >
> > > > An easier way would be to add a check and some trigger in PCM
> core
> > > > side.  OTOH, this would affect effectively all drivers, thus we'd
> > > need
> > > > a wider test coverage, too.
> > > >
> > > > Judging from your comment, the broken driver is ASoC one, right?
> > >
> > > Thinking of this again, I'm inclined to have a workaround for such
> > > buggy drivers.  In the end, alsa-lib should work for older kernels,
> > > too.
> > >
> > > Does the patch below work on your device?
> > >
> > > Maybe better to clear the buffer beforehand for avoiding the
> > > unnecessary noise.  But it can be done later.
> > >
> >
> > I test this patch, there will be error after resume.
> >
> > aplay: pcm_write:1940: write error: Input/output error
> >
> >
> > The reason is that the snd_pcm_state(dmix->spcm) is SETUP, the
> > snd_pcm_direct_prepare() won't do snd_pcm_prepare().
> 
> OK, one fix would be to allow SETUP in snd_pcm_direct_prepare().  I'll
> prepare it later.  Meanwhile, the prepare of the slave should be done
> immediately at resume, so it's good to call in
> snd_pcm_direct_resume().
> 
> Below is the revised version.  Give it a try.

I test this patch, it is ok. But I have some questions.

1. Why do you add snd_pcm_drop()? It seems only adding snd_pcm_resume(spcm)
can fix this issue also.
2. Does the snd_pcm_drop cause some several period data be dropped?
3. The return values -ENOSYS, always cause error print "Failed. Restarting
stream." in aplay. Can it be fixed?

Best regards
Wang shengjiu
> 
> 
> thanks,
> 
> Takashi
> 
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] pcm: dmix: resume workaround for buggy driver
> 
> The previous commit removed the whole handling of resume in dmix, but
> this seems causing another regression; some buggy drivers assume that
> the device-resume needs to be triggered before transitioning to
> PREPARED state.  As an ugly workaround, in this patch, when the slave
> PCM supports resume, snd_pcm_direct_resume() does resume of the slave
> PCM but immediately drop the stream after that.  In that way, the
> device is brought to the sane active state, then the apps can prepare
> and restart the stream properly.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  src/pcm/pcm_direct.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
> index 53c49929cb1f..343fd3c6da3c 100644
> --- a/src/pcm/pcm_direct.c
> +++ b/src/pcm/pcm_direct.c
> @@ -837,6 +837,27 @@ int snd_pcm_direct_prepare(snd_pcm_t *pcm)
> 
>  int snd_pcm_direct_resume(snd_pcm_t *pcm)
>  {
> +	snd_pcm_direct_t *dmix = pcm->private_data;
> +	snd_pcm_t *spcm = dmix->spcm;
> +
> +	snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT);
> +	/* some buggy drivers require the device resumed before prepared;
> +	 * when a device has RESUME flag and is in SUSPENDED state,
> resume
> +	 * here but immediately drop to bring it to a sane active state.
> +	 */
> +	if ((spcm->info & SND_PCM_INFO_RESUME) &&
> +	    snd_pcm_state(spcm) == SND_PCM_STATE_SUSPENDED) {
> +		snd_pcm_resume(spcm);
> +		snd_pcm_drop(spcm);
> +		snd_pcm_direct_timer_stop(dmix);
> +		snd_pcm_direct_clear_timer_queue(dmix);
> +		snd_pcm_areas_silence(snd_pcm_mmap_areas(spcm), 0,
> +				      spcm->channels, spcm->buffer_size,
> +				      spcm->format);
> +		snd_pcm_prepare(spcm);
> +		snd_pcm_start(spcm);
> +	}
> +	snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT);
>  	return -ENOSYS;
>  }
> 
> @@ -845,7 +866,7 @@ int snd_pcm_direct_resume(snd_pcm_t *pcm)
>  /* copy the slave setting */
>  static void save_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
>  {
> -	spcm->info &= ~(SND_PCM_INFO_PAUSE | SND_PCM_INFO_RESUME);
> +	spcm->info &= ~SND_PCM_INFO_PAUSE;
> 
>  	COPY_SLAVE(access);
>  	COPY_SLAVE(format);
> @@ -874,6 +895,8 @@ static void save_slave_setting(snd_pcm_direct_t
> *dmix, snd_pcm_t *spcm)
>  	COPY_SLAVE(buffer_time);
>  	COPY_SLAVE(sample_bits);
>  	COPY_SLAVE(frame_bits);
> +
> +	dmix->shmptr->s.info &= ~SND_PCM_INFO_RESUME;
>  }
> 
>  #undef COPY_SLAVE
> --
> 2.8.3
