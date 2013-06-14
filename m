From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: SPEAr: Hide component drivers in
	Kconfig
Date: Fri, 14 Jun 2013 17:50:07 +0530
Message-ID: <CAOh2x=mTJDqqBVEWMyAxagXhjS_0GiRWxh58B9Fwn4L=71BpTQ@mail.gmail.com>
References: <1371209418-32496-1-git-send-email-broonie@linaro.org>
 <1371209418-32496-2-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f169.google.com (mail-ve0-f169.google.com
 [209.85.128.169])
 by alsa0.perex.cz (Postfix) with ESMTP id EF3362652B7
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 14:20:07 +0200 (CEST)
Received: by mail-ve0-f169.google.com with SMTP id m1so414987ves.0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 05:20:07 -0700 (PDT)
In-Reply-To: <1371209418-32496-2-git-send-email-broonie@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 14, 2013 at 5:00 PM, Mark Brown <broonie@linaro.org> wrote:
> The individual component drivers are only useful with a machine driver and
> should be selected by the machine drivers so shouldn't have help text of
> their own in order to hide them in interactive configuration.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/spear/Kconfig |   16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
