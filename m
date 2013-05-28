From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix VAG_POWER
 enabling/disabling order
Date: Tue, 28 May 2013 16:44:54 -0300
Message-ID: <CAOMZO5DMrKOpuyYgurZd7zA6vO=8U+bE_gzS0Aui27fCs1rDJg@mail.gmail.com>
References: <1369366496-15329-1-git-send-email-marex@denx.de>
 <CAOMZO5CpOz3PKiJ8-Ka+0nWN8BLquxHMcb8DZGvEE-cbeq3M8w@mail.gmail.com>
 <201305282023.40181.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f173.google.com (mail-vc0-f173.google.com
 [209.85.220.173])
 by alsa0.perex.cz (Postfix) with ESMTP id D9CF4261692
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 21:44:55 +0200 (CEST)
Received: by mail-vc0-f173.google.com with SMTP id ht10so5794542vcb.18
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 12:44:55 -0700 (PDT)
In-Reply-To: <201305282023.40181.marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Dong Aisheng <dong.aisheng@linaro.org>, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2013 at 3:23 PM, Marek Vasut <marex@denx.de> wrote:

> That's good. But you still hear some noise when the headphone/lineout drivers
> are powered up/down, right?

Only tested on mx51evk and I don't hear no more noises after your
patch is applied.
