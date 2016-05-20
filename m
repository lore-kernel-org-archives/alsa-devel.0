From: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] pcm: Don't store the state for
	SND_PCM_STATE_SUSPENDED
Date: Fri, 20 May 2016 10:03:48 +0000
Message-ID: <HE1PR04MB21222CA0FC93548DA63CC878E34B0@HE1PR04MB2122.eurprd04.prod.outlook.com>
References: <1462866346-11878-1-git-send-email-shengjiu.wang@freescale.com>
 <s5h7ff2b9vx.wl-tiwai@suse.de>
 <HE1PR04MB21229D4BBCC605559F98D3FFE3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hzirx9nv4.wl-tiwai@suse.de>
 <HE1PR04MB212240A8E6692FCFF12DF797E3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hoa8d9iey.wl-tiwai@suse.de>
 <HE1PR04MB2122FD4500AC192F85542DA2E3490@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5h60ubn42y.wl-tiwai@suse.de> <s5hfutd42an.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0094.outbound.protection.outlook.com [157.55.234.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 58F712673C3
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2016 12:03:50 +0200 (CEST)
In-Reply-To: <s5hfutd42an.wl-tiwai@suse.de>
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
> Sent: Friday, May 20, 2016 3:27 PM
> To: Shengjiu Wang
> Cc: perex@perex.cz; alsa-devel@alsa-project.org
> Subject: Re: [PATCH] pcm: Don't store the state for
> SND_PCM_STATE_SUSPENDED
> 
> On Wed, 18 May 2016 10:49:25 +0200,
> Takashi Iwai wrote:
> >
> > On Wed, 18 May 2016 07:48:15 +0200,
> > Shengjiu Wang wrote:
> > >
> > > Hi Takashi
> > >
> > >   After adding your patch, I find another regression issue.
> > >
> > >   The alsa-lib may stop at
> > >
> > >   snd_pcm_write_areas()
> > > 		snd_pcm_wait_nocheck()
> > >
> > >   with suspend and resume test.
> > >
> > >   The reason is that:
> > >
> > >   In the beginning of playback, before the snd_pcm_dmix_start() is
> > > called, the system enter suspend. After resume,
> snd_pcm_direct_resume()
> > > update the dmix->state, and dmix->state is 3 (RUNNING, because
> > > the dmix->spcm is in RUNNING from snd_pcm_dmix_open()).
> > >
> > >   So in snd_pcm_write_areas() the state is RUNNING, then
> > > snd_pcm_start() will never be called, after a while,
> > > alsa-lib will stop at the snd_pcm_wait_nocheck() for the kernel
> > > will not wake up the timer.
> >
> > A good point.  Actually the culprit is that we declare dmix as if
> it's
> > supporting the resume properly.  Even if the resume works in the
> > slave, dmix itself can't guarantee the proper resume.  So, we should
> > rather drop the whole resume stuff from dmix & co.
> >
> > Below is the patch against to the current git tree.  Give it a try.
> >
> >
> > thanks,
> >
> > Takashi
> >
> > ---
> > From: Takashi Iwai <tiwai@suse.de>
> > Subject: [PATCH] pcm: Remove resume support from dmix & co
> >
> > PCM dmix and other plugins inherit the resume behavior from the slave
> > PCM.  However, the resume on dmix can't work reliably even if the
> > slave PCM may do resume.  The running state of each dmix stream is
> > individual and may be PREPARED or RUN_PENDING while the slave PCM is
> > already in RUNNING.  And, when the slave PCM is resumed, the whole
> > samples that have been already mapped are also played back, even if
> > the corresponding dmix stream is still in SUSPENDED.  Such
> > inconsistencies can't be avoided as long as we manage each stream
> > individually.
> >
> > That said, dmix & co can't provide the proper resume support "by
> > design".  For aligning with it, we should drop the whole resume code
> > and clear the PCM SND_PCM_INFO_RESUME flag.
> >
> > Reported-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> I performed a few tests and they seemed OK.
> I'm going to push the fix to git tree.
> 
   I tested your patch, after suspend and resume, the playback is stopped.
It is caused by the DMA. DMA is not started after resume.

With your this change, DMA is not terminated but then is re-started. The
Driver don't support this behavior.

Wang Shengjiu
> 
> thanks,
> 
> Takashi
