From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Let it understand mono
Date: Mon, 24 Sep 2012 08:50:41 -0500
Message-ID: <50606531.8000606@freescale.com>
References: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
 <50589DD7.8050409@freescale.com>
 <CAOMZO5D-oHc8hdakFHPHSW_duAZ+dMuM77wUn=K=7jUMwxmg-A@mail.gmail.com>
 <505A3DDB.4060208@freescale.com>
 <20120922145619.GB4495@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 399E62615DD
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 15:50:49 +0200 (CEST)
In-Reply-To: <20120922145619.GB4495@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, javier.martin@vista-silicon.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> In I2S mono just means ignoring the right channel or duplicating the
> left channel into the right channel at one end of the link or the other.
> As you say the clocking always has to be for an even number of channels.

Let me see if I understand this correctly.  In order for I2S mono to work,
we need the following:

1) The I2S controller (the SSI in this case) needs to be programmed to DMA
data from memory into the left channel only of each frame, and it needs to
pump dummy data into the right channel.  If it automatically pumps the
same data into the right channel, then the codec doesn't need to do
anything.  Otherwise, we need one of these:

2a) The codec needs to be programmed to ignore the right channel and
internally duplicate the left channel into both left and right analog signals.

2b) The board needs to be wired such that only the left analog signal gets
routed to the speakers.

For item #1, as far as I know, there is only one way to get the SSI to do
that: use dual-FIFO mode.  The "left" FIFO points to the audio data as
normal, and the right FIFO points to whatever.  If the right FIFO also
points to the same audio data, then we don't need any codec changes.

I can say for certain that fsl_ssi.c does not implement dual-FIFO mode.  I
considered it once, but I figured it wasn't worth the effort.  Getting it
to work for audio capture would be difficult, and the feature must be
enabled for both capture and playback.  I don't think I could support
simultaneous playback and capture in dual-FIFO mode.

I do not see any code in imx-ssi.c that enables dual-FIFO mode.  This
would be done by setting SSI_SCR_TCH_EN in the SCR, and I don't see that
bit being set anywhere.

So unless there's some hackery happening on the mx6qsabrelite board, I
can't believe that any of these patches actually work.

-- 
Timur Tabi
Linux kernel developer at Freescale
