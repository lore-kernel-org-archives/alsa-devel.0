From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix VAG_POWER
	enabling/disabling order
Date: Tue, 28 May 2013 22:04:18 +0200
Message-ID: <201305282204.19078.marex@denx.de>
References: <1369366496-15329-1-git-send-email-marex@denx.de>
 <201305282023.40181.marex@denx.de>
 <CAOMZO5DMrKOpuyYgurZd7zA6vO=8U+bE_gzS0Aui27fCs1rDJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id F1BEA261641
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 22:04:20 +0200 (CEST)
In-Reply-To: <CAOMZO5DMrKOpuyYgurZd7zA6vO=8U+bE_gzS0Aui27fCs1rDJg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Dong Aisheng <dong.aisheng@linaro.org>, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Dear Fabio Estevam,

> On Tue, May 28, 2013 at 3:23 PM, Marek Vasut <marex@denx.de> wrote:
> > That's good. But you still hear some noise when the headphone/lineout
> > drivers are powered up/down, right?
> 
> Only tested on mx51evk and I don't hear no more noises after your
> patch is applied.

Crank the volume up, make it _REALLY_ loud and just before you start hearing the 
audio you're supposed to hear, the HP driver is enabled. This makes such a minor 
noise it seems. It's hard to hear when it's not loud enough ;-)

Best regards,
Marek Vasut
