From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Make device cache only
 when powered off
Date: Wed, 5 Jun 2013 20:26:04 -0300
Message-ID: <CAOMZO5BTVuajyb-pYrn8dPec0J=b9hrneEqP25CyDXBkot_Ycg@mail.gmail.com>
References: <1370251350-4679-1-git-send-email-broonie@linaro.org>
 <CAOMZO5Bwe49qssZ0-kWtETgrFpA-CoCC7qnCodiWhajUq89jcw@mail.gmail.com>
 <20130605232330.GI31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f174.google.com (mail-ve0-f174.google.com
 [209.85.128.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B50D92654DE
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 01:26:05 +0200 (CEST)
Received: by mail-ve0-f174.google.com with SMTP id oz10so1699536veb.19
 for <alsa-devel@alsa-project.org>; Wed, 05 Jun 2013 16:26:04 -0700 (PDT)
In-Reply-To: <20130605232330.GI31367@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 5, 2013 at 8:23 PM, Mark Brown <broonie@kernel.org> wrote:

> Isn't that the thing with not powering on the regulators before doing
> the ID read?  There was some discussion about that earlier.

No, the board I am using has the sgtl5000 voltages always applied.

Will try to bisect it.

Thanks,

Fabio Estevam
