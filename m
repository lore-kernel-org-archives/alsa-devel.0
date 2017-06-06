From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 1/2] ASoC: add es8316 codec driver
Date: Tue, 6 Jun 2017 09:30:25 +0900
Message-ID: <79daa67f-64f1-46b1-fd2d-cb925c02b381@sakamocchi.jp>
References: <20170605201637.4901-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 55EB6266B17
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 02:30:30 +0200 (CEST)
In-Reply-To: <20170605201637.4901-1-drake@endlessm.com>
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
To: Daniel Drake <drake@endlessm.com>, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux@endlessm.com, pierre-louis.bossart@linux.intel.com, yangxiaohua@everest-semi.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 6 2017 05:16, Daniel Drake wrote:
> diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
> new file mode 100644
> index 000000000000..ced60a56b4cb
> --- /dev/null
> +++ b/sound/soc/codecs/es8316.c
> ...
> +/*
> + * ES8316 controls
> + */
> +static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -9600, 50, 1);
> +static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -9600, 50, 1);
> +static const DECLARE_TLV_DB_SCALE(alc_max_gain_tlv, -650, 150, 0);
> +static const DECLARE_TLV_DB_SCALE(alc_min_gain_tlv, -1200, 150, 0);
> +static const DECLARE_TLV_DB_SCALE(alc_target_tlv, -1650, 150, 0);
> +static const DECLARE_TLV_DB_SCALE(hpmixer_gain_tlv, -1200, 150, 0);
> +
> +static unsigned int adc_pga_gain_tlv[] = {
> +	TLV_DB_RANGE_HEAD(12),
> +	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +	1, 1, TLV_DB_SCALE_ITEM(300, 0, 0),
> +	2, 2, TLV_DB_SCALE_ITEM(600, 0, 0),
> +	3, 3, TLV_DB_SCALE_ITEM(900, 0, 0),
> +	4, 4, TLV_DB_SCALE_ITEM(1200, 0, 0),
> +	5, 5, TLV_DB_SCALE_ITEM(1500, 0, 0),
> +	6, 6, TLV_DB_SCALE_ITEM(1800, 0, 0),
> +	7, 7, TLV_DB_SCALE_ITEM(2100, 0, 0),
> +	8, 8, TLV_DB_SCALE_ITEM(2400, 0, 0),
> +};
> +static unsigned int hpout_vol_tlv[] = {
> +	TLV_DB_RANGE_HEAD(1),
> +	0, 3, TLV_DB_SCALE_ITEM(-4800, 1200, 0),
> +};

To me, the array of 'adc_pga_gain_tlv' includes invalid members as 
'SNDRV_CTL_TLVT_DB_RANGE'. In your code, the array represents below table:

Linear range: dB range: coeff: mute
0 <-> 0:    0 <->    0: 0: 0
1 <-> 1:  300 <->  300: 0: 0
2 <-> 2:  600 <->  600: 0: 0
3 <-> 3:  900 <->  900: 0: 0
4 <-> 4: 1200 <-> 1200: 0: 0
5 <-> 5: 1500 <-> 1500: 0: 0
6 <-> 6: 1800 <-> 1800: 0: 0
7 <-> 7: 2100 <-> 2100: 0: 0
8 <-> 8: 2400 <-> 2400: 0: 0

Can I ask you to ensure that your hardware has jumps for current dB 
value against given linear value and investigate the reason that maximum 
value in this table has too large value (2,400) as dB representation.

If you don't have real hardware or don't find the detail in datasheet of 
ES8316, please inform it. Then, I leave the decision of merging to Mark 
Brown, a maintainer of ALSA SoC part.

Additionally, these macros are obsoleted. See memo in header[1]. It's 
better to macros in UAPI header[2] for newer codes. Furthermore, the 
usage of 'TLV_DB_RANGE_HEAD' is obsoleted with 'DECLARE_TLV_DB_RANGE'. 
It's better to use 'SNDRV_CTL_TLVD_DECLARE_DB_RANGE', instead. TLV data 
is exposed to userspace applications as is. It's better to use the same 
name of macro in UAPI header so that application developers can easily 
reach your codes.


[1] include/sound/tlv.h
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/sound/tlv.h#n52
[2] include/uapi/sound/tlv.h
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/tlv.h

Regards

Takashi Sakamoto
