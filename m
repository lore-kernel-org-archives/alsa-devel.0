From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH V1 09/11] ASoC: DaVinci: i2s,
 add	davinci_i2s_prepare and shutdown
Date: Mon, 27 Sep 2010 11:50:19 -0700
Message-ID: <4CA0E76B.6040209@boundarydevices.com>
References: <1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>	<A24693684029E5489D1D202277BE89447289CD0A@dlee02.ent.ti.com>	<4C9CF898.7070906@boundarydevices.com>	<A24693684029E5489D1D202277BE89447289CF40@dlee02.ent.ti.com>
	<20100927005636.GC21247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpoproxy2-pub.bluehost.com (cpoproxy2-pub.bluehost.com
	[67.222.39.38]) by alsa0.perex.cz (Postfix) with SMTP id E7D6B24418
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 20:50:30 +0200 (CEST)
In-Reply-To: <20100927005636.GC21247@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ambrose,
	Martin" <martin@ti.com>
List-Id: alsa-devel@alsa-project.org

On 9/26/2010 5:56 PM, Mark Brown wrote:
> Yes, the trigger callback actually starts data flowing.  This is mostly
> down to DMA, it's rare for anything except the CPU to be involved in the
> trigger operation.
> _______________________________________________

So you'll revert the patch?
