From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH V3 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Mon, 11 Apr 2011 23:45:47 +0800
Message-ID: <20110411154547.GB12824@qtel.sh.intel.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BE9E224427
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 17:47:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
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

On Mon, Apr 11, 2011 at 01:30:00PM +0800, Rajeev Kumar wrote:
> +static int sta529_hw_params(struct snd_pcm_substream *substream,
> +               struct snd_pcm_hw_params *params,
> +               struct snd_soc_dai *dai)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_codec *codec = rtd->codec;
> +       int pdata = 0;
> +
> +       switch (params_format(params)) {
> +       case SNDRV_PCM_FORMAT_S16_LE:
> +               pdata = 1;
> +               break;
> +       case SNDRV_PCM_FORMAT_S24_LE:
> +               pdata = 2;
> +               break;
> +       case SNDRV_PCM_FORMAT_S32_LE:
> +               pdata = 3;
> +               break;
> +       }
> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +               snd_soc_update_bits(codec, STA529_S2PCFG1, 0xB0, pdata);
> +       else
> +               snd_soc_update_bits(codec, STA529_P2SCFG1, 0xB0, pdata);

Hi,

Reading the spec, the bit 7 and bit 6 of these two registers are related
to the length of data.

While from your code, you're masking bit 10110000, which is weird.
Shouldn't it be 0xC0?

Besides, the value to snd_soc_update_bits should be shifted accordingly.
So the improved one should be something like this:
	snd_soc_update_bits(codec, STA529_P2SCFG1, 0xC0, (pdata << 6));

-- 
guanqun
