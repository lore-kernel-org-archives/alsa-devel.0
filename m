From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
 before writting
Date: Mon, 1 Jul 2013 22:26:12 +0800
Message-ID: <20130701142610.GR13206@S2101-09.ap.freescale.net>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
 <20130701100710.GB27646@sirena.org.uk>
 <201307011254.18952.marex@denx.de>
 <CAOMZO5BAs5-Tf_O0TVLFAuCchVuukV+bH2MpjqMU83tTw2GD=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 3101226514A
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 16:25:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5BAs5-Tf_O0TVLFAuCchVuukV+bH2MpjqMU83tTw2GD=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 01, 2013 at 11:12:48AM -0300, Fabio Estevam wrote:
> On Mon, Jul 1, 2013 at 7:54 AM, Marek Vasut <marex@denx.de> wrote:
> 
> > The delay might also be caused by the I2C driver, I have this in my ToDo to
> 
> Yes, this extra delay could be related to the mxs i2c driver, as we do
> not need to add this delay when using sgtl5000 on other i.mx devices.
> 
> Other people have also reported mxs i2c issues currently:
> http://marc.info/?l=linux-i2c&m=137241339917261&w=2
> 
> ,so this may be related some how.

How does it explain the fact that sgtl5000 read has been working there?
The sgtl5000 revision has been successfully read out at that point.

Shawn
