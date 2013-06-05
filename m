From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Make device cache only
 when powered off
Date: Wed, 5 Jun 2013 20:04:10 -0300
Message-ID: <CAOMZO5Bwe49qssZ0-kWtETgrFpA-CoCC7qnCodiWhajUq89jcw@mail.gmail.com>
References: <1370251350-4679-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f176.google.com (mail-ve0-f176.google.com
 [209.85.128.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 39CB92654D0
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 01:10:24 +0200 (CEST)
Received: by mail-ve0-f176.google.com with SMTP id c13so1719786vea.35
 for <alsa-devel@alsa-project.org>; Wed, 05 Jun 2013 16:10:23 -0700 (PDT)
In-Reply-To: <1370251350-4679-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Jun 3, 2013 at 6:22 AM, Mark Brown <broonie@linaro.org> wrote:
> When the regulators have been disabled mark the device as cache only so
> that we don't try to interact with the hardware.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

I tried to test your patch, but noticed that even without your patch
sgtl5000 fails to probe in linux-next 20130605.

It fails when doing a regmap_read of the sgtl5000 ID register.

I will debug this, but in case you have any ideas about recent regmap
changes that could lead to this, please let me know.

Regards,

Fabio Estevam
