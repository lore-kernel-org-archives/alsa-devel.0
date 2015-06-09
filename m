From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH] PCM: snd_pcm_dmix_drain() maybe blocked
 after suspend and resume
Date: Tue, 9 Jun 2015 10:35:41 +0800
Message-ID: <20150609023539.GA3277@shlinux2>
References: <1433756291-22999-1-git-send-email-shengjiu.wang@freescale.com>
 <s5hsia2iggy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 by alsa0.perex.cz (Postfix) with ESMTP id D1A36261B01
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 04:37:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsia2iggy.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2015 at 01:31:41PM +0200, Takashi Iwai wrote:
> At Mon, 8 Jun 2015 17:38:11 +0800,
> Shengjiu Wang wrote:
> > 
> > After suspend and resume, the alsa driver is stopped. But if alsa-lib run
> > into snd_pcm_dmix_drain(), it need to wait avail >= pcm->stop_threshold,
> > otherwise, it will not exit the loop, so finally it is blocked at poll() of
> > snd_pcm_wait_nocheck(pcm, -1).
> > This patch is to add state check after snd_pcm_wait_nocheck(pcm, -1), if
> > the state is SND_PCM_STATE_SUSPENDED, then return error.
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > ---
> >  src/pcm/pcm_dmix.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
> > index babde6a..0cc318e 100644
> > --- a/src/pcm/pcm_dmix.c
> > +++ b/src/pcm/pcm_dmix.c
> > @@ -647,6 +647,12 @@ static int snd_pcm_dmix_drain(snd_pcm_t *pcm)
> >  		if (dmix->state == SND_PCM_STATE_DRAINING) {
> >  			snd_pcm_dmix_sync_area(pcm);
> >  			snd_pcm_wait_nocheck(pcm, -1);
> > +			switch (snd_pcm_state(pcm)) {
> 
> It's better (shorter) to call snd_pcm_state(dmix->spcm) in this case.
> 
> And, I think we should have the check of SND_PCM_STATE_SUSPENDED at
> the beginning of snd_pcm_dmix_drain() before entering to the loop,
> too.
> 
> Last but not least, the very same bug is present for dshare.  Could
> you fix this together?
> 
Ok, I will refine the patch. But one thing I don't understand is that why need
to check the SND_PCM_STATE_SUSPENDED before entering the loop, seems check the
state in the loop can resolve the issue.

Best regards
wang shengjiu
> 
> thanks,
> 
> Takashi
> 
> > +			case SND_PCM_STATE_SUSPENDED:
> > +				return -ESTRPIPE;
> > +			default:
> > +				break;
> > +			}
> >  			snd_pcm_direct_clear_timer_queue(dmix); /* force poll to wait */
> >  		}
> >  	} while (dmix->state == SND_PCM_STATE_DRAINING);
> > -- 
> > 1.7.9.5
> > 
