From: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] pcm: Don't store the state for
	SND_PCM_STATE_SUSPENDED
Date: Wed, 18 May 2016 05:48:15 +0000
Message-ID: <HE1PR04MB2122FD4500AC192F85542DA2E3490@HE1PR04MB2122.eurprd04.prod.outlook.com>
References: <1462866346-11878-1-git-send-email-shengjiu.wang@freescale.com>
 <s5h7ff2b9vx.wl-tiwai@suse.de>
 <HE1PR04MB21229D4BBCC605559F98D3FFE3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hzirx9nv4.wl-tiwai@suse.de>
 <HE1PR04MB212240A8E6692FCFF12DF797E3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hoa8d9iey.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0088.outbound.protection.outlook.com [157.55.234.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F09426057F
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 07:48:18 +0200 (CEST)
In-Reply-To: <s5hoa8d9iey.wl-tiwai@suse.de>
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

Hi Takashi

  After adding your patch, I find another regression issue.

  The alsa-lib may stop at 
  
  snd_pcm_write_areas()
		snd_pcm_wait_nocheck()

  with suspend and resume test.

  The reason is that:

  In the beginning of playback, before the snd_pcm_dmix_start() is 
called, the system enter suspend. After resume, snd_pcm_direct_resume()
update the dmix->state, and dmix->state is 3 (RUNNING, because
the dmix->spcm is in RUNNING from snd_pcm_dmix_open()). 

  So in snd_pcm_write_areas() the state is RUNNING, then
snd_pcm_start() will never be called, after a while,
alsa-lib will stop at the snd_pcm_wait_nocheck() for the kernel
will not wake up the timer.


Best regards
Wang shengjiu

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, May 11, 2016 3:13 PM
> To: Shengjiu Wang
> Cc: perex@perex.cz; alsa-devel@alsa-project.org
> Subject: Re: [PATCH] pcm: Don't store the state for
> SND_PCM_STATE_SUSPENDED
> 
> On Wed, 11 May 2016 08:24:55 +0200,
> Shengjiu Wang wrote:
> >
> > Hi
> >
> > > On Wed, 11 May 2016 04:28:41 +0200,
> > > Shengjiu Wang wrote:
> > > >
> > > > Hi
> > > >
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > Sent: Tuesday, May 10, 2016 4:22 PM
> > > > > To: Shengjiu Wang
> > > > > Cc: perex@perex.cz; alsa-devel@alsa-project.org
> > > > > Subject: Re: [PATCH] pcm: Don't store the state for
> > > > > SND_PCM_STATE_SUSPENDED
> > > > >
> > > > > On Tue, 10 May 2016 09:45:46 +0200,
> > > > > Shengjiu Wang wrote:
> > > > > >
> > > > > > The resume function don't update the dmix->state, if store
> > > SUSPENDED
> > > > > > state in snd_pcm_dmix_state, the write function after resume
> will
> > > > > > return error -ESTRPIPE, because the snd_pcm_write_areas()
> will
> > > check
> > > > > > the state of the pcm device.
> > > > > > This patch remove the store SND_PCM_STATE_SUSPENDED state
> > > operation
> > > > > > for dmix,dshare,dsnoop.
> > > > > >
> > > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > > > >
> > > > > What's the exact problem you're seeing on surface?  Could
> > > illustrate
> > > > > how the bug is triggered and how to reproduce easily?  It'll
> make
> > > > > easier to understand what you're trying to fix.
> > > > >
> > > > >
> > > > > thanks,
> > > > >
> > > > > Takashi
> > > >
> > > > The aplay endlessly print " Suspended. Trying resume. Done." if
> > > suspend
> > > > and resume in the middle of playback. Which is caused by this
> patch.
> > > >
> > > > commit 8985742d91dbdd74b2f605374207473393454fff
> > > > Author: Takashi Iwai <tiwai@suse.de>
> > > > Date:   Fri Oct 30 17:13:50 2015 +0100
> > > >
> > > >     pcm: dmix: Handle slave PCM xrun and unexpected states
> properly
> > > >
> > > > This patch store the SUSPENDED state to dmix->state, but after
> resume
> > > > the dmix->state still is SUSPENDED, next write function will
> check
> > > the
> > > > state, if state is SUSPENDED, it will return -ESTRPIPE, then the
> > > aplay
> > > > will print another " Suspended. Trying resume. Done."  Then
> repeat
> > > this
> > > > behavior again and again.
> > >
> > > Thanks, this is exactly what I wanted to see in the changelog!
> > > It's rather a regression, and it should be clearly mentioned.
> > >
> > > Now about your fix: the problem is not about setting the correct
> > > state at suspending.  It is suspended, so setting the right state
> > > there is the correct behavior.  However, the counterpart, the
> resume,
> > > is the culprit of this bug.  It misses the restore of the shadow
> > > state.
> > >
> > > Does the patch below work instead?
> > >
> > Yes, it is workable.
> 
> Great, now I pushed the fix to git tree.
> Thanks for your quick test!
> 
> 
> Takashi
