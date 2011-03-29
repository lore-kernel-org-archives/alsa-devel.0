From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 4/5] sound: asoc: Adding Kconfig and
 Makefile to support SPEAr13XX ASoC driver
Date: Wed, 30 Mar 2011 08:33:02 +0900
Message-ID: <20110329233300.GM30482@opensource.wolfsonmicro.com>
References: <1301397423-4693-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-5-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E56910399B
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 01:32:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301397423-4693-5-git-send-email-rajeev-dlh.kumar@st.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 29, 2011 at 04:47:02PM +0530, Rajeev Kumar wrote:

> +++ b/sound/soc/spear/Makefile
> @@ -0,0 +1,6 @@
> +# SPEAR Platform Support
> +obj-$(CONFIG_SND_SOC_SPEAR) += spear13xx-pcm.o
> +obj-$(CONFIG_SND_SOC_SPEAR_I2S) += spear13xx-i2s.o
> +
> +# SPEAR Machine Support
> +obj-$(CONFIG_SND_SOC_SPEAR_EVM) += evb_sta529.o

As previously mentioned you should give all the modules snd-soc-
prefixes to their names.
