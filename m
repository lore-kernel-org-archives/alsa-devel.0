From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] [patch 1/2]AC97: add AC97 support for AT91.
Date: Fri, 26 Feb 2010 09:13:47 +0000
Message-ID: <1267175627.3212.4.camel@odin>
References: <1267120770-1752-1-git-send-email-sedji.gaouaou@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 4777124405
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 10:13:51 +0100 (CET)
Received: by fxm20 with SMTP id 20so16713798fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 01:13:50 -0800 (PST)
In-Reply-To: <1267120770-1752-1-git-send-email-sedji.gaouaou@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-02-25 at 18:59 +0100, Sedji Gaouaou wrote:
> This patch add AC97 support for ATMEL AT91, using the AVR32 code.
> While AVR is using a DMA, the AT91 chips are using a Peripheral Data
> Controller.
> 

Btw, any reason why the Atmel AC97 support has not been folded into
ASoC ?

> Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
> ---
>  sound/atmel/Kconfig |    2 +-
>  sound/atmel/ac97c.c |  309 +++++++++++++++++++++++++++++++++++++--------------
>  2 files changed, 226 insertions(+), 85 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>


-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
