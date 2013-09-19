From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] ASoC: SPEAr spdif_out: Remove
	redundant variable
Date: Thu, 19 Sep 2013 12:24:55 +0530
Message-ID: <CAKohpokuTKVm5UsJRpoG8FgFaTM8UbGN3xTCCEdb0An+4KcOZQ@mail.gmail.com>
References: <1379573624-15382-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 68F662617AE
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 08:54:56 +0200 (CEST)
Received: by mail-ob0-f171.google.com with SMTP id wm4so9537348obc.30
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 23:54:55 -0700 (PDT)
In-Reply-To: <1379573624-15382-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 19 September 2013 12:23, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Return directly and remove the intermediate local variable.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  sound/soc/spear/spdif_out.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
