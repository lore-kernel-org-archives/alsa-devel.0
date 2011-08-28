From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Add 3D stereo support for wm8996
Date: Sun, 28 Aug 2011 18:40:13 +0100
Message-ID: <4E5A7D7D.4000903@ti.com>
References: <1314386054.3143.10.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 29CD62438B
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Aug 2011 19:40:16 +0200 (CEST)
In-Reply-To: <1314386054.3143.10.camel@ubuntu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: susan gao <sgao@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 26/08/11 20:14, susan gao wrote:
> My first patch to ASoC ever! If I did something wrong, blame Ian.
> 

No blame required ;)

> Signed-off-by: Susan Gao <sgao@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/codecs/wm8996.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
> index 73a1588..c4bc99b 100644
> --- a/sound/soc/codecs/wm8996.c
> +++ b/sound/soc/codecs/wm8996.c
> @@ -414,6 +414,7 @@ static const DECLARE_TLV_DB_SCALE(out_digital_tlv, -1200, 150, 0);
>  static const DECLARE_TLV_DB_SCALE(out_tlv, -900, 75, 0);
>  static const DECLARE_TLV_DB_SCALE(spk_tlv, -900, 150, 0);
>  static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
> +static const DECLARE_TLV_DB_SCALE(threedstereo_tlv, -1600, 183, 1);
>  
>  static const char *sidetone_hpf_text[] = {
>  	"2.9kHz", "1.5kHz", "735Hz", "403Hz", "196Hz", "98Hz", "49Hz"
> @@ -608,6 +609,14 @@ SOC_SINGLE("DAC High Performance Switch", WM8996_OVERSAMPLING, 0, 1, 0),
>  SOC_SINGLE("DAC Soft Mute Switch", WM8996_DAC_SOFTMUTE, 1, 1, 0),
>  SOC_SINGLE("DAC Slow Soft Mute Switch", WM8996_DAC_SOFTMUTE, 0, 1, 0),
>  
> +SOC_SINGLE("DSP1 3D Stereo Switch", WM8996_DSP1_RX_FILTERS_2, 8, 1, 0),
> +SOC_SINGLE("DSP2 3D Stereo Switch", WM8996_DSP2_RX_FILTERS_2, 8, 1, 0),
> +
> +SOC_SINGLE_TLV("DSP1 3D Stereo Volume", WM8996_DSP1_RX_FILTERS_2, 10, 15,
> +		0, threedstereo_tlv),
> +SOC_SINGLE_TLV("DSP2 3D Stereo Volume", WM8996_DSP2_RX_FILTERS_2, 10, 15,
> +		0, threedstereo_tlv),
> +
>  SOC_DOUBLE_TLV("Digital Output 1 Volume", WM8996_DAC1_HPOUT1_VOLUME, 0, 4,
>  	       8, 0, out_digital_tlv),
>  SOC_DOUBLE_TLV("Digital Output 2 Volume", WM8996_DAC2_HPOUT2_VOLUME, 0, 4,
