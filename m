From: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] pcm: Don't store the state for
	SND_PCM_STATE_SUSPENDED
Date: Wed, 11 May 2016 02:28:41 +0000
Message-ID: <HE1PR04MB21229D4BBCC605559F98D3FFE3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
References: <1462866346-11878-1-git-send-email-shengjiu.wang@freescale.com>
 <s5h7ff2b9vx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0060.outbound.protection.outlook.com [104.47.1.60])
 by alsa0.perex.cz (Postfix) with ESMTP id A657E2604AA
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 04:28:42 +0200 (CEST)
In-Reply-To: <s5h7ff2b9vx.wl-tiwai@suse.de>
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

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, May 10, 2016 4:22 PM
> To: Shengjiu Wang
> Cc: perex@perex.cz; alsa-devel@alsa-project.org
> Subject: Re: [PATCH] pcm: Don't store the state for
> SND_PCM_STATE_SUSPENDED
> 
> On Tue, 10 May 2016 09:45:46 +0200,
> Shengjiu Wang wrote:
> >
> > The resume function don't update the dmix->state, if store SUSPENDED
> > state in snd_pcm_dmix_state, the write function after resume will
> > return error -ESTRPIPE, because the snd_pcm_write_areas() will check
> > the state of the pcm device.
> > This patch remove the store SND_PCM_STATE_SUSPENDED state operation
> > for dmix,dshare,dsnoop.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> 
> What's the exact problem you're seeing on surface?  Could illustrate
> how the bug is triggered and how to reproduce easily?  It'll make
> easier to understand what you're trying to fix.
> 
> 
> thanks,
> 
> Takashi

The aplay endlessly print " Suspended. Trying resume. Done." if suspend
and resume in the middle of playback. Which is caused by this patch.

commit 8985742d91dbdd74b2f605374207473393454fff
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Oct 30 17:13:50 2015 +0100

    pcm: dmix: Handle slave PCM xrun and unexpected states properly 

This patch store the SUSPENDED state to dmix->state, but after resume
the dmix->state still is SUSPENDED, next write function will check the
state, if state is SUSPENDED, it will return -ESTRPIPE, then the aplay
will print another " Suspended. Trying resume. Done."  Then repeat this
behavior again and again.

Best regards
Wang shengjiu
> 
> > ---
> >  src/pcm/pcm_dmix.c   | 2 +-
> >  src/pcm/pcm_dshare.c | 2 +-
> >  src/pcm/pcm_dsnoop.c | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
> > index 007d356..66bb288 100644
> > --- a/src/pcm/pcm_dmix.c
> > +++ b/src/pcm/pcm_dmix.c
> > @@ -451,9 +451,9 @@ static snd_pcm_state_t
> snd_pcm_dmix_state(snd_pcm_t *pcm)
> >  	state = snd_pcm_state(dmix->spcm);
> >  	switch (state) {
> >  	case SND_PCM_STATE_XRUN:
> > -	case SND_PCM_STATE_SUSPENDED:
> >  	case SND_PCM_STATE_DISCONNECTED:
> >  		dmix->state = state;
> > +	case SND_PCM_STATE_SUSPENDED:
> >  		return state;
> >  	default:
> >  		break;
> > diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
> > index adb3587..a133c72 100644
> > --- a/src/pcm/pcm_dshare.c
> > +++ b/src/pcm/pcm_dshare.c
> > @@ -241,9 +241,9 @@ static snd_pcm_state_t
> snd_pcm_dshare_state(snd_pcm_t *pcm)
> >  	state = snd_pcm_state(dshare->spcm);
> >  	switch (state) {
> >  	case SND_PCM_STATE_XRUN:
> > -	case SND_PCM_STATE_SUSPENDED:
> >  	case SND_PCM_STATE_DISCONNECTED:
> >  		dshare->state = state;
> > +	case SND_PCM_STATE_SUSPENDED:
> >  		return state;
> >  	default:
> >  		break;
> > diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
> > index 8ff0ba5..d56dd97 100644
> > --- a/src/pcm/pcm_dsnoop.c
> > +++ b/src/pcm/pcm_dsnoop.c
> > @@ -205,9 +205,9 @@ static snd_pcm_state_t
> snd_pcm_dsnoop_state(snd_pcm_t *pcm)
> >  	state = snd_pcm_state(dsnoop->spcm);
> >  	switch (state) {
> >  	case SND_PCM_STATE_XRUN:
> > -	case SND_PCM_STATE_SUSPENDED:
> >  	case SND_PCM_STATE_DISCONNECTED:
> >  		dsnoop->state = state;
> > +	case SND_PCM_STATE_SUSPENDED:
> >  		return state;
> >  	default:
> >  		break;
> > --
> > 1.9.1
> >
