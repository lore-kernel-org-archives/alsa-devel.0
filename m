From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: select CONFIG_HDMI
Date: Wed, 1 Jun 2016 09:32:42 +0300
Message-ID: <574E818A.4000708@ti.com>
References: <1464729159-587126-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DA862656F0
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 08:32:47 +0200 (CEST)
In-Reply-To: <1464729159-587126-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, PC Liao <pc.liao@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On 06/01/16 00:12, Arnd Bergmann wrote:
> SND_SOC_HDMI_CODEC can be enabled without HDMI support, leading
> to a link error:
> 
> In function `hdmi_codec_hw_params':
> sound/soc/codecs/hdmi-codec.c:188: undefined reference to `hdmi_audio_infoframe_init'
> sound/built-in.o:(.debug_addr+0x1a5c0): undefined reference to `hdmi_audio_infoframe_init'
> 
> This changes the Kconfig file to select HDMI, as the other codec using
> hdmi_audio_infoframe_init already does.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 09184118a8ab ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")

Oops. I wonder how I missed that. Something in omap2plus_defconfig must
trigger the selecting of HDMI.

Acked-by: Jyri Sarha <jsarha@ti.com>


> ---
>  sound/soc/codecs/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 4d82a58ff6b0..f3fb98f0a995 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -483,9 +483,10 @@ config SND_SOC_DMIC
>  	tristate
>  
>  config SND_SOC_HDMI_CODEC
> -       tristate
> -       select SND_PCM_ELD
> -       select SND_PCM_IEC958
> +	tristate
> +	select SND_PCM_ELD
> +	select SND_PCM_IEC958
> +	select HDMI
>  
>  config SND_SOC_ES8328
>  	tristate "Everest Semi ES8328 CODEC"
> 
