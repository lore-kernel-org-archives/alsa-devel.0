From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: cs42l73: Add Device Tree support
	for CS42L73
Date: Fri, 18 Oct 2013 14:05:30 -0500
Message-ID: <alpine.DEB.2.10.1310181404540.6723@heelrod.ad.cirrus.com>
References: <1382025815-7912-1-git-send-email-brian.austin@cirrus.com>
 <1382025815-7912-3-git-send-email-brian.austin@cirrus.com>
 <20131017233953.GY2443@sirena.org.uk>
 <alpine.DEB.2.10.1310181339460.6723@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 by alsa0.perex.cz (Postfix) with ESMTP id E2FCC261AC4
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 21:03:48 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1310181339460.6723@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

>> Actually this doesn't apply for me, some missing dependency perhaps?  I
>> didn't check exactly what's conflicting.
>> 
> If you apply 0003 before the others it can fail with removal of gpio.h from 
> patch 0002 for of_gpio.h. That's the only problem I can find. If I apply them 
> in series they apply OK. Is that the dependency you see? Is is OK to have a 
> patch dependant on another?
>
It's broke. I'll resubmit v2 for 3/3
