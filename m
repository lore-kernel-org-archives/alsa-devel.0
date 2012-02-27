From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 7/7] ASoC: ep93xx-pcm: Use dmaengine PCM
	helper functions
Date: Mon, 27 Feb 2012 09:51:57 +0100
Message-ID: <4F4B442D.2050902@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-8-git-send-email-lars@metafoo.de>
	<20120227081933.GA3868@mwesterb-mobl.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-132.synserver.de (smtp-out-134.synserver.de
	[212.40.185.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4992524602
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 09:50:15 +0100 (CET)
In-Reply-To: <20120227081933.GA3868@mwesterb-mobl.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 02/27/2012 09:19 AM, Mika Westerberg wrote:
> On Wed, Feb 22, 2012 at 10:49:11AM +0100, Lars-Peter Clausen wrote:
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> =

> For some reason, this doesn't work on my ep93xx based Sim.One board. On
> playback with mpg123 when I press stop, it continues to play whatever was=
 on
> the ring-buffer forever. Without the patches it works fine.
> =

> I'll try to find some time to debug this further.

Hm, that=92s interesting. The original ep93xx pcm driver was almost identic=
al
to what the common helper functions do. The only difference I can spot right
now is, that it doesn't call dma_issue_pending after submitting the
descriptor. Could you try to comment out the dma_issue_pending in
soc-dmaengine-pcm.c and test whether it makes a difference?

Thanks,
- Lars
