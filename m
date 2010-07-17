From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] asoc: davinci: let platform data define
 edma queue numbers
Date: Sat, 17 Jul 2010 18:28:53 +0100
Message-ID: <1279387733.3070.0.camel@odin>
References: <1279196059-6031-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 975C0246DA
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 19:28:57 +0200 (CEST)
Received: by wyf19 with SMTP id 19so3034068wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 10:28:55 -0700 (PDT)
In-Reply-To: <1279196059-6031-1-git-send-email-nsekhar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-15 at 17:44 +0530, Sekhar Nori wrote:
> Currently the EDMA queue to be used by for servicing ASP through
> internal RAM is fixed to EDMAQ_0 and that to service internal RAM
> from external RAM is fixed to EDMAQ_1.
> 
> This may not be the desirable configuration on all platforms. For
> example, on DM365, queue 0 has large fifo size and is more suitable
> for video transfers. Having audio and video transfers on the same
> queue may lead to starvation on audio side.
> 
> platform data as defined currently passes a queue number to the driver
> but that remains unused inside the driver.
> 
> Fix this by defining one queue each for ASP and RAM transfers in the
> platform data and using it inside the driver.
> 
> Since EDMAQ_0 maps to 0, thats the queue that will be used if
> the asp queue number is not initialized. None of the platforms
> currently utilize ping-pong transfers through internal RAM so that
> functionality remains unchanged too.
> 
> This patch has been tested on DM644x and OMAP-L138 EVMs.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
