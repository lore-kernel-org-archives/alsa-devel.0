From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 2/2] ASoC: spear: Normalise module names
Date: Tue, 18 Jun 2013 09:29:13 +0530
Message-ID: <51BFDB11.6080408@st.com>
References: <1371456427-31648-1-git-send-email-broonie@linaro.org>
 <1371456427-31648-2-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog104.obsmtp.com (eu1sys200aog104.obsmtp.com
 [207.126.144.117])
 by alsa0.perex.cz (Postfix) with ESMTP id AB348261A5F
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2013 05:59:18 +0200 (CEST)
In-Reply-To: <1371456427-31648-2-git-send-email-broonie@linaro.org>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 6/17/2013 1:37 PM, Mark Brown wrote:
> Signed-off-by: Mark Brown<broonie@linaro.org>
> ---
>   sound/soc/spear/Makefile |   10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/spear/Makefile b/sound/soc/spear/Makefile
> index 9f47bb4..7c5c175 100644
> --- a/sound/soc/spear/Makefile
> +++ b/sound/soc/spear/Makefile
> @@ -1,4 +1,8 @@
>   # SPEAR Platform Support
> -obj-$(CONFIG_SND_SPEAR_SOC) += spear_pcm.o
> -obj-$(CONFIG_SND_SPEAR_SPDIF_IN) += spdif_in.o
> -obj-$(CONFIG_SND_SPEAR_SPDIF_OUT) += spdif_out.o
> +snd-soc-spear-pcm-objs := spear_pcm.o
> +snd-soc-spear-spdif-in-objs := spear_spdif_in.o
> +snd-soc-spear-spdif-out-objs := spear_spdif_out.o
> +
> +obj-$(CONFIG_SND_SPEAR_SOC) += snd-soc-spear-pcm.o
> +obj-$(CONFIG_SND_SPEAR_SPDIF_IN) += snd-soc-spdif-in.o
> +obj-$(CONFIG_SND_SPEAR_SPDIF_OUT) += snd-soc-spdif-out.o


Acked-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
