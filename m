From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: SPEAr spdif_in: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 11:03:08 +0530
Message-ID: <CAOh2x==fRbAjNPg6mX2_5kZzuzoSStN3qRTaSVFSdkQ3nvG7Vw@mail.gmail.com>
References: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f172.google.com (mail-ve0-f172.google.com
 [209.85.128.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 643C12650B4
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 07:33:09 +0200 (CEST)
Received: by mail-ve0-f172.google.com with SMTP id oz11so3755073veb.17
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 22:33:08 -0700 (PDT)
In-Reply-To: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: "vipin.kumar" <vipin.kumar@st.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 17, 2013 at 10:41 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> devm_snd_soc_register_component makes code simpler.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  sound/soc/spear/spdif_in.c |   12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
