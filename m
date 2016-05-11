From: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] pcm: Don't store the state for
	SND_PCM_STATE_SUSPENDED
Date: Wed, 11 May 2016 06:24:55 +0000
Message-ID: <HE1PR04MB212240A8E6692FCFF12DF797E3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
References: <1462866346-11878-1-git-send-email-shengjiu.wang@freescale.com>
 <s5h7ff2b9vx.wl-tiwai@suse.de>
 <HE1PR04MB21229D4BBCC605559F98D3FFE3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hzirx9nv4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0087.outbound.protection.outlook.com [104.47.1.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 810062619BE
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 08:25:01 +0200 (CEST)
In-Reply-To: <s5hzirx9nv4.wl-tiwai@suse.de>
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

> On Wed, 11 May 2016 04:28:41 +0200,
> Shengjiu Wang wrote:
> >
> > Hi
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Tuesday, May 10, 2016 4:22 PM
> > > To: Shengjiu Wang
> > > Cc: perex@perex.cz; alsa-devel@alsa-project.org
> > > Subject: Re: [PATCH] pcm: Don't store the state for
> > > SND_PCM_STATE_SUSPENDED
> > >
> > > On Tue, 10 May 2016 09:45:46 +0200,
> > > Shengjiu Wang wrote:
> > > >
> > > > The resume function don't update the dmix->state, if store
> SUSPENDED
> > > > state in snd_pcm_dmix_state, the write function after resume will
> > > > return error -ESTRPIPE, because the snd_pcm_write_areas() will
> check
> > > > the state of the pcm device.
> > > > This patch remove the store SND_PCM_STATE_SUSPENDED state
> operation
> > > > for dmix,dshare,dsnoop.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > >
> > > What's the exact problem you're seeing on surface?  Could
> illustrate
> > > how the bug is triggered and how to reproduce easily?  It'll make
> > > easier to understand what you're trying to fix.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> >
> > The aplay endlessly print " Suspended. Trying resume. Done." if
> suspend
> > and resume in the middle of playback. Which is caused by this patch.
> >
> > commit 8985742d91dbdd74b2f605374207473393454fff
> > Author: Takashi Iwai <tiwai@suse.de>
> > Date:   Fri Oct 30 17:13:50 2015 +0100
> >
> >     pcm: dmix: Handle slave PCM xrun and unexpected states properly
> >
> > This patch store the SUSPENDED state to dmix->state, but after resume
> > the dmix->state still is SUSPENDED, next write function will check
> the
> > state, if state is SUSPENDED, it will return -ESTRPIPE, then the
> aplay
> > will print another " Suspended. Trying resume. Done."  Then repeat
> this
> > behavior again and again.
> 
> Thanks, this is exactly what I wanted to see in the changelog!
> It's rather a regression, and it should be clearly mentioned.
> 
> Now about your fix: the problem is not about setting the correct
> state at suspending.  It is suspended, so setting the right state
> there is the correct behavior.  However, the counterpart, the resume,
> is the culprit of this bug.  It misses the restore of the shadow
> state.
> 
> Does the patch below work instead?
> 
Yes, it is workable.

Best regards
Wang Shengjiu

> 
> Takashi
> 
> ---
> diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
> index 14de734d98eb..e28738b0de96 100644
> --- a/src/pcm/pcm_direct.c
> +++ b/src/pcm/pcm_direct.c
> @@ -848,6 +848,7 @@ int snd_pcm_direct_resume(snd_pcm_t *pcm)
>  		snd_pcm_start(dmix->spcm);
>  		err = 0;
>  	}
> +	dmix->state = snd_pcm_state(dmix->spcm);
>  	snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT);
>  	return err;
>  }
