From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 09/11] ASoC: DaVinci: i2s,
 add davinci_i2s_prepare and shutdown
Date: Mon, 27 Sep 2010 13:35:24 -0700
Message-ID: <20100927203523.GA7016@opensource.wolfsonmicro.com>
References: <1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<A24693684029E5489D1D202277BE89447289CD0A@dlee02.ent.ti.com>
	<4C9CF898.7070906@boundarydevices.com>
	<A24693684029E5489D1D202277BE89447289CF40@dlee02.ent.ti.com>
	<20100927005636.GC21247@sirena.org.uk>
	<4CA0E76B.6040209@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 567082436F
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 22:35:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CA0E76B.6040209@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ambrose,
	Martin" <martin@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 27, 2010 at 11:50:19AM -0700, Troy Kisky wrote:
> On 9/26/2010 5:56 PM, Mark Brown wrote:

> > Yes, the trigger callback actually starts data flowing.  This is mostly
> > down to DMA, it's rare for anything except the CPU to be involved in the
> > trigger operation.

> So you'll revert the patch?

I'll let you guys sort it out - it's not the end of the world to have it
as it is now, but it could lead to integration issues such as you've
been seeing so some change is probably needed here.
