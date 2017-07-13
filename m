From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ASoC: spear: spdif_in: constify
	snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 11:54:49 +0530
Message-ID: <CAOh2x=nEV2-DDC5WtXDp0_50o=drtS=RvLL4BfH7oAxpNY=cEA@mail.gmail.com>
References: <20170713055710.GA21105@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com
 [209.85.213.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 5720B266C3C
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 08:24:51 +0200 (CEST)
Received: by mail-yb0-f175.google.com with SMTP id n205so12102541yba.1
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 23:24:50 -0700 (PDT)
In-Reply-To: <20170713055710.GA21105@embeddedgus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 13, 2017 at 11:27 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> This structure is only stored in the ops field of a snd_soc_dai_driver
> structure. That field is declared const, so snd_soc_dai_ops structures
> that have this property can be declared as const also.
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  sound/soc/spear/spdif_in.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
