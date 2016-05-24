From: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] pcm: Don't store the state for
	SND_PCM_STATE_SUSPENDED
Date: Tue, 24 May 2016 10:12:49 +0000
Message-ID: <DB5PR04MB212063DBF8904F58516C3137E34F0@DB5PR04MB2120.eurprd04.prod.outlook.com>
References: <1462866346-11878-1-git-send-email-shengjiu.wang@freescale.com>
 <s5h7ff2b9vx.wl-tiwai@suse.de>
 <HE1PR04MB21229D4BBCC605559F98D3FFE3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hzirx9nv4.wl-tiwai@suse.de>
 <HE1PR04MB212240A8E6692FCFF12DF797E3720@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hoa8d9iey.wl-tiwai@suse.de>
 <HE1PR04MB2122FD4500AC192F85542DA2E3490@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5h60ubn42y.wl-tiwai@suse.de>
 <HE1PR04MB212271FEAAEFBBE21A2E358FE34B0@HE1PR04MB2122.eurprd04.prod.outlook.com>
 <s5hk2ipknw2.wl-tiwai@suse.de> <s5hr3cwkdh6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0044.outbound.protection.outlook.com [104.47.2.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 151D426070F
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 12:13:01 +0200 (CEST)
In-Reply-To: <s5hr3cwkdh6.wl-tiwai@suse.de>
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
> Sent: Friday, May 20, 2016 10:32 PM
> To: Shengjiu Wang
> Cc: perex@perex.cz; alsa-devel@alsa-project.org
> Subject: Re: [PATCH] pcm: Don't store the state for
> SND_PCM_STATE_SUSPENDED
> 
> On Fri, 20 May 2016 12:46:37 +0200,
> Takashi Iwai wrote:
> >
> > On Fri, 20 May 2016 11:41:25 +0200,
> > Shengjiu Wang wrote:
> > >
> > > Hi Takashi
> > >
> > >    I tested your patch, after suspend and resume, the playback is
> stopped.
> > > It is caused by the DMA. DMA is not started after resume.
> > >
> > > With your patch, DMA is not terminated but then is re-started. The
> driver don't
> > > support this behavior.
> >
> > If so, it's simply a driver bug.  Blame the kernel driver instead.
> 
> Which driver did you see the problem?  We should fix it.

But my thought is when suspended, the dmaengine_pause() is called, then
dmaengine_resume() should be called in resume(). If there is no resume()
Just call the prepare() and start(), it seems not reasonable. What do
you think?

Best regards
Wang shengjiu
> 
> 
> thanks,
> 
> Takashi
