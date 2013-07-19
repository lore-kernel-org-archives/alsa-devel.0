From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: wm8350: Use power efficient
	workqueue
Date: Fri, 19 Jul 2013 09:46:50 +0530
Message-ID: <CAKohpokF_-1vbFmmJ7OS8U_HHnZUt_t01pS0oPqCObmCtDBqJQ@mail.gmail.com>
References: <1374184638-10691-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D9CC265649
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 06:16:51 +0200 (CEST)
Received: by mail-ob0-f179.google.com with SMTP id xk17so4639214obc.24
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 21:16:50 -0700 (PDT)
In-Reply-To: <1374184638-10691-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 19 July 2013 03:27, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The accessory detect debounce work is not performance sensitive so let
> the scheduler run it wherever is most efficient rather than in a per CPU
> workqueue by using the system power efficient workqueue.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/codecs/wm8350.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

For all four patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
