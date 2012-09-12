From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] [v2] ASoC: fsl: use
 snd_soc_register_card to register the card
Date: Wed, 12 Sep 2012 10:12:51 -0500
Message-ID: <5050A673.3010401@freescale.com>
References: <1347380607-1564-1-git-send-email-timur@freescale.com>
 <20120912013211.GB9162@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F084261711
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 17:13:04 +0200 (CEST)
In-Reply-To: <20120912013211.GB9162@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> I did explain what's wrong here - it's the use of driver data.

Sorry, I didn't think to update the description with your explanation.

Of course, now I need to figure out why my driver doesn't need driver data
in order to work.

-- 
Timur Tabi
Linux kernel developer at Freescale
