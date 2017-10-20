From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [Patch v6 7/7] MAINTAINERS: Add SLIMbus maintainer
Date: Thu, 19 Oct 2017 22:00:40 -0700
Message-ID: <CAOCOHw7ufGO40W7-_q9kTc4wO63jZAK3Xh-Hs9JpcgaCEQ79yA@mail.gmail.com>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-8-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B4E5267670
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 07:00:42 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id b79so9340906pfk.5
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 22:00:42 -0700 (PDT)
In-Reply-To: <20171006155136.4682-8-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Michael Opdenacker <michael.opdenacker@free-electrons.com>, poeschel@lemonage.de, Andreas Noever <andreas.noever@gmail.com>, gong.chen@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, kheitke@audience.com, Thierry Reding <treding@nvidia.com>, devicetree <devicetree@vger.kernel.org>, james.hogan@imgtec.com, Pawel Moll <pawel.moll@arm.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, sharon.dvir1@mail.huji.ac.il, Rob Herring <robh+dt@kernel.org>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com, bp@suse.de, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Jiri Kosina <jkosina@suse.cz>, joe@perches.com, David Miller <davem@davemloft.net>
List-Id: alsa-devel@alsa-project.org

On Fri 06 Oct 08:51 PDT 2017, srinivas.kandagatla@linaro.org wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Add myself as maintainer for slimbus.
>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2281af4..014f74b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12320,6 +12320,14 @@ T: git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>  F: include/linux/srcu.h
>  F: kernel/rcu/srcu.c
>
> +SERIAL LOW-POWER INTER-CHIP MEDIA BUS (SLIMbus)
> +M: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +L: alsa-devel@alsa-project.org (moderated for non-subscribers)
> +S: Maintained
> +F: drivers/slimbus/
> +F: Documentation/devicetree/bindings/slimbus/
> +F: include/linux/slimbus.h
> +
>  SMACK SECURITY MODULE
>  M: Casey Schaufler <casey@schaufler-ca.com>
>  L: linux-security-module@vger.kernel.org
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
