From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 1/6] ASoC: cs42l52: Cleanup manual bias
 level transitions
Date: Tue, 9 Sep 2014 13:47:45 -0500
Message-ID: <alpine.DEB.2.02.1409091347030.27378@heelrod>
References: <1410288165-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 1406F265335
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 20:47:08 +0200 (CEST)
In-Reply-To: <1410288165-32127-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 9 Sep 2014, Lars-Peter Clausen wrote:

> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.
> 
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.
> 
> The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
> can also be removed as the core will automatically do this after the CODEC
> has been probed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
for the Cirrus ones.
Thanks

Acked-by: Brian Austin <brian.austin@cirrus.com>
