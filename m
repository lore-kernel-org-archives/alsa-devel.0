From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Let it understand mono
Date: Tue, 25 Sep 2012 13:53:59 +0100
Message-ID: <20120925125359.GH4428@opensource.wolfsonmicro.com>
References: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
 <50589DD7.8050409@freescale.com>
 <CAOMZO5D-oHc8hdakFHPHSW_duAZ+dMuM77wUn=K=7jUMwxmg-A@mail.gmail.com>
 <505A3DDB.4060208@freescale.com>
 <20120922145619.GB4495@opensource.wolfsonmicro.com>
 <50606531.8000606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF6A9261710
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 14:54:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50606531.8000606@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, javier.martin@vista-silicon.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 24, 2012 at 08:50:41AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> > In I2S mono just means ignoring the right channel or duplicating the
> > left channel into the right channel at one end of the link or the other.
> > As you say the clocking always has to be for an even number of channels.

> Let me see if I understand this correctly.  In order for I2S mono to work,
> we need the following:

> 1) The I2S controller (the SSI in this case) needs to be programmed to DMA
> data from memory into the left channel only of each frame, and it needs to
> pump dummy data into the right channel.  If it automatically pumps the
> same data into the right channel, then the codec doesn't need to do
> anything.  Otherwise, we need one of these:

> 2a) The codec needs to be programmed to ignore the right channel and
> internally duplicate the left channel into both left and right analog signals.

> 2b) The board needs to be wired such that only the left analog signal gets
> routed to the speakers.

Yes.
