From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: pcm186x: fix wrong
 usage of DECLARE_TLV_DB_SCALE()
Date: Tue, 19 Feb 2019 11:05:24 -0600
Message-ID: <abf49724-6567-43cf-852c-027c7948860d@ti.com>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DFEC265535
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 18:05:27 +0100 (CET)
In-Reply-To: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Codrin.Ciubotariu@microchip.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org

On 2/19/19 10:29 AM, Codrin.Ciubotariu@microchip.com wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> According to DS, the gain is between -12 dB and 40 dB, with a 0.5 dB step.
> Tested on pcm1863.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Acked-by: Andrew F. Davis <afd@ti.com>

> 
> Changes in v2:
>  - fixed title - added correct macro;
>  - revert the removal of a new line;
> 
>  sound/soc/codecs/pcm186x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
> index 809b7e9f03ca..c36a391fec8a 100644
> --- a/sound/soc/codecs/pcm186x.c
> +++ b/sound/soc/codecs/pcm186x.c
> @@ -42,7 +42,7 @@ struct pcm186x_priv {
>  	bool is_master_mode;
>  };
>  
> -static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 4000, 50);
> +static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 50, 0);
>  
>  static const struct snd_kcontrol_new pcm1863_snd_controls[] = {
>  	SOC_DOUBLE_R_S_TLV("ADC Capture Volume", PCM186X_PGA_VAL_CH1_L,
> 
