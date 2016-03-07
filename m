From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] Revert "ASoC: fsl_ssi: remove explicit
	register defaults"
Date: Sun, 6 Mar 2016 21:11:56 -0300
Message-ID: <CAOMZO5BNY6V-Qbo+gBY1dW-9bHgBusXXAmEiG45BzuoZeKSm8w@mail.gmail.com>
References: <1456065300-23752-1-git-send-email-festevam@gmail.com>
 <20160222025930.GO18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id D4D71260592
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 01:11:57 +0100 (CET)
Received: by mail-ig0-f176.google.com with SMTP id ir4so36425485igb.1
 for <alsa-devel@alsa-project.org>; Sun, 06 Mar 2016 16:11:57 -0800 (PST)
In-Reply-To: <20160222025930.GO18327@sirena.org.uk>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sun, Feb 21, 2016 at 11:59 PM, Mark Brown <broonie@kernel.org> wrote:

> There's no problem adding it back for v4.6 for that matter, the changes
> will all have long enough to soak (and have already been soaking for a
> little while).  I'll do that.

I see you applied this one as 56e5fd8feb286ab7 ("ASoC: fsl_ssi: Go
back to explicit register defaults") into your fix/fsl-ssi branch, but
it is still not present in 4.5-rc7.

Any plans to make this one into 4.5 final?

Thanks
