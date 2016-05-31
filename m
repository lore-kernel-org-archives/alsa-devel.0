From: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] pcm: Don't store the state for
	SND_PCM_STATE_SUSPENDED
Date: Tue, 31 May 2016 07:30:49 +0000
Message-ID: <HE1PR04MB21221E104C044C42AD5909ECE3460@HE1PR04MB2122.eurprd04.prod.outlook.com>
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
 <s5hvb23hi8l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0094.outbound.protection.outlook.com [157.56.112.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B2802651D5
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 09:30:50 +0200 (CEST)
In-Reply-To: <s5hvb23hi8l.wl-tiwai@suse.de>
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

> On Tue, 24 May 2016 12:12:49 +0200,
> Shengjiu Wang wrote:
> >
> > Hi
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Friday, May 20, 2016 10:32 PM
> > > To: Shengjiu Wang
> > > Cc: perex@perex.cz; alsa-devel@alsa-project.org
> > > Subject: Re: [PATCH] pcm: Don't store the state for
> > > SND_PCM_STATE_SUSPENDED
> > >
> > > On Fri, 20 May 2016 12:46:37 +0200,
> > > Takashi Iwai wrote:
> > > >
> > > > On Fri, 20 May 2016 11:41:25 +0200,
> > > > Shengjiu Wang wrote:
> > > > >
> > > > > Hi Takashi
> > > > >
> > > > >    I tested your patch, after suspend and resume, the playback
> is
> > > stopped.
> > > > > It is caused by the DMA. DMA is not started after resume.
> > > > >
> > > > > With your patch, DMA is not terminated but then is re-started.
> The
> > > driver don't
> > > > > support this behavior.
> > > >
> > > > If so, it's simply a driver bug.  Blame the kernel driver instead.
> > >
> > > Which driver did you see the problem?  We should fix it.
> >
> > But my thought is when suspended, the dmaengine_pause() is called,
> then
> > dmaengine_resume() should be called in resume(). If there is no
> resume()
> > Just call the prepare() and start(), it seems not reasonable. What do
> > you think?
> 
> There are several ways to fix the problem, but the point is that, from
> the API POV, the direct state change from SUSPENDED to PREPARED is
> valid.  So, the kernel driver has to support such a state change, no
> matter how.
> 
> An easier way would be to add a check and some trigger in PCM core
> side.  OTOH, this would affect effectively all drivers, thus we'd need
> a wider test coverage, too.
> 
> Judging from your comment, the broken driver is ASoC one, right?
> 
No, the driver is in dma folder, path is /drivers/dma/. We use the
/drivers/dma/imx-sdma.c But the driver in community is old. We have
updated the dma driver to support virtual-dma, just like the
drivers/dma/omap-dma.c.

The c->desc should be released in terminate_all() function, if it not
Released, the issue_pending() will not go to start dma.

I can't find a good way to fix this issue in dma driver. 

> 
> Takashi
