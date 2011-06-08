From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH V4 2/5] sound: asoc: Adding support
 for	SPEAr13XX ASoC platform driver
Date: Wed, 8 Jun 2011 10:05:34 +0100
Message-ID: <4DEF3B5E.8030608@ti.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-3-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id CB3CF243FB
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 11:05:44 +0200 (CEST)
In-Reply-To: <1307339856-30656-3-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 06/06/11 06:57, Rajeev Kumar wrote:
> This patch adds the support for the SPEAr13XX Platform Driver (I2S based)
> as per the ASoC framework.
> 
> SPEAr13XX internally uses a Designware I2S IP and some glue logic on top
> of the same.
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> ---

snip

> +}
> +
> +static int spear13xx_pcm_new(struct snd_card *card,
> +               struct snd_soc_dai *dai, struct snd_pcm *pcm)
> +{

Btw, this API call has recently been refactored to only accept 1 argument since you posted V4.

Thanks

Liam
