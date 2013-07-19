From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ASoC: sta32x: Use power efficient workqueue
Date: Fri, 19 Jul 2013 09:46:24 +0530
Message-ID: <CAKohponTKNP-6-knmo5axsm2jRZ3S6SaNo=wFSFPJ98T4iWErA@mail.gmail.com>
References: <1374184714-11900-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 80E2126563B
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 06:16:25 +0200 (CEST)
Received: by mail-ob0-f175.google.com with SMTP id xn12so4679230obc.6
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 21:16:24 -0700 (PDT)
In-Reply-To: <1374184714-11900-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 19 July 2013 03:28, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> None of the delayed work the driver schedules has particularly short delays
> and it is not performance sensitive so let the scheduler run it wherever
> is most efficient rather than in a per CPU workqueue by using the system
> power efficient workqueue.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/codecs/sta32x.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
