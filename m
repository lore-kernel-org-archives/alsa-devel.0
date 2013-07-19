From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ASoC: max98090: Use power efficient
	workqueue
Date: Fri, 19 Jul 2013 09:46:05 +0530
Message-ID: <CAKohpokq63WB0S96jG44eezNjUj=VrQdCVBnYnCTksOicnzoew@mail.gmail.com>
References: <1374184795-11976-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id CFEF8265633
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 06:16:06 +0200 (CEST)
Received: by mail-ob0-f170.google.com with SMTP id ef5so4754591obb.1
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 21:16:05 -0700 (PDT)
In-Reply-To: <1374184795-11976-1-git-send-email-broonie@kernel.org>
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

On 19 July 2013 03:29, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> None of the delayed work the driver schedules has particularly short delays
> and it is not performance sensitive so let the scheduler run it wherever
> is most efficient rather than in a per CPU workqueue by using the system
> power efficient workqueue.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/codecs/max98090.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Thanks for the publicity :)

Ackecd-by: Viresh Kumar <viresh.kumar@linaro.org>
