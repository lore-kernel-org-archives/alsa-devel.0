From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: cs42l73: Add Device Tree support
	for CS42L73
Date: Fri, 18 Oct 2013 13:42:25 -0500
Message-ID: <alpine.DEB.2.10.1310181339460.6723@heelrod.ad.cirrus.com>
References: <1382025815-7912-1-git-send-email-brian.austin@cirrus.com>
 <1382025815-7912-3-git-send-email-brian.austin@cirrus.com>
 <20131017233953.GY2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 by alsa0.perex.cz (Postfix) with ESMTP id DC448261AC4
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 20:40:20 +0200 (CEST)
In-Reply-To: <20131017233953.GY2443@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, 18 Oct 2013, Mark Brown wrote:

> On Thu, Oct 17, 2013 at 11:03:35AM -0500, Brian Austin wrote:
>> This patch adds device tree support for the cs42l73 codec.
>> Reset Gpio and Charge Pump Frequency are available
>
> Actually this doesn't apply for me, some missing dependency perhaps?  I
> didn't check exactly what's conflicting.
>
If you apply 0003 before the others it can fail with removal of gpio.h 
from patch 0002 for of_gpio.h. That's the only problem I can find. If I 
apply them in series they apply OK. Is that the dependency you see? Is is 
OK to have a patch dependant on another?
