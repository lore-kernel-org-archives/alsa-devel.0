From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH 1/2] sis7019: support the SiS 7019
	Audio	Accelerator
Date: Wed, 28 Nov 2007 08:03:35 -0500
Message-ID: <1196255015.7017.52.camel@obelisk.thedillows.org>
References: <1196234344.7017.31.camel@obelisk.thedillows.org>
	<s5hejeaithq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id B6D1424661
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 14:03:45 +0100 (CET)
In-Reply-To: <s5hejeaithq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-11-28 at 10:56 +0100, Takashi Iwai wrote:
> At Wed, 28 Nov 2007 02:19:03 -0500,
> Dave Dillow wrote:
> > +static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
> > +static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
> > +static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
> 
> Can there be multiple SIS7019 devices?  If there can only a single
> device, let's avoid array.

Ok, can do.

> > +static struct snd_pcm_hardware sis_playback_hw_info = {
> > +	.info = (SNDRV_PCM_INFO_MMAP |
> > +		 SNDRV_PCM_INFO_MMAP_VALID |
> > +		 SNDRV_PCM_INFO_INTERLEAVED |
> > +		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > +		 SNDRV_PCM_INFO_SYNC_START |
> > +		 SNDRV_PCM_INFO_RESUME),
> 
> SNDRV_PCM_INFO_SYNC_START seems invalid here.  It's not implemented in
> the driver.

Perhaps I'm misunderstanding what SYNC_START is for -- I can start
multiple playback/capture substreams at once in ->trigger(). If it means
something else, can you point to a driver that does implement it
properly so that I can see if can be implemented?

> > +static void __sis_map_silence(struct sis7019 *sis)
> 
> Any reason to use __ prefix?

It requires locks to be held when it is called, making it an internal
helper function. I'd prefer to keep the prefix, but it could go away, or
be merged into the one call-site.

Thanks,
Dave
