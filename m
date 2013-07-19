From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ASoC: jack: Use power efficient workqueue
Date: Fri, 19 Jul 2013 09:47:02 +0530
Message-ID: <CAKohponrTbxggKwNbUZOPLcAygU18sRF2Zi1fLP2OL+HRE4V9Q@mail.gmail.com>
References: <1374184063-6969-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f54.google.com (mail-oa0-f54.google.com
 [209.85.219.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B40126564F
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 06:17:03 +0200 (CEST)
Received: by mail-oa0-f54.google.com with SMTP id o6so5345079oag.13
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 21:17:02 -0700 (PDT)
In-Reply-To: <1374184063-6969-1-git-send-email-broonie@kernel.org>
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

On 19 July 2013 03:17, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The accessory detect debounce work is not performance sensitive so let
> the scheduler run it wherever is most efficient rather than in a per CPU
> workqueue by using the system power efficient workqueue.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/soc-jack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
