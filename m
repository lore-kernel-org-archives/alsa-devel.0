From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: Ensure DAPM widgets are set up
	before we sync jacks
Date: Thu, 06 Oct 2011 15:51:15 +0300
Message-ID: <2522011.aBmFsviLZv@barack>
References: <1317904284-7846-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id E62C4103810
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 14:50:59 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so3152097bkb.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 05:50:51 -0700 (PDT)
In-Reply-To: <1317904284-7846-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thursday 06 October 2011 13:31:24 Mark Brown wrote:
> We synchronise jack state on startup - when we do that make sure that we
> have set up all the DAPM widgets first in case we end up touching any of
> the partially set up widgets when syncing the jack pins.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
