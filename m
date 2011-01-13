From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] ASoC: soc core move card cleanup from
 soc_remove()
Date: Thu, 13 Jan 2011 20:24:58 +0000
Message-ID: <1294950298.7125.0.camel@odin>
References: <1294939082-26350-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CAF3F103B06
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 21:25:04 +0100 (CET)
Received: by eyg24 with SMTP id 24so1059460eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 12:25:04 -0800 (PST)
In-Reply-To: <1294939082-26350-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, selma.bensaid@intel.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-13 at 22:48 +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> In soc_remove() the card resources are cleaned up.
> This can also be done in card_unregister()
> 
> This patch move this cleanup into a new function and calls it from
> card_unregister. This paves way for further work to allow card registartion
> from machine.
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
