From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH -next] ASoC: hdmi-codec: fix non static
	symbol warnings
Date: Mon, 27 Feb 2017 10:08:15 +0900
Message-ID: <4a2e36fb-8529-c86a-1d9c-2d85fd39d530@sakamocchi.jp>
References: <20170206143830.6871-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id CC29B266AA9
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 02:08:21 +0100 (CET)
In-Reply-To: <20170206143830.6871-1-weiyj.lk@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, PC Liao <pc.liao@mediatek.com>
Cc: alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 6 2017 23:38, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fixes the following sparse warnings:
>
> sound/soc/codecs/hdmi-codec.c:34:1: warning:
>  symbol 'hdmi_device_list' was not declared. Should it be static?
> sound/soc/codecs/hdmi-codec.c:80:33: warning:
>  symbol 'hdmi_codec_stereo_chmaps' was not declared. Should it be static?
> sound/soc/codecs/hdmi-codec.c:87:33: warning:
>  symbol 'hdmi_codec_8ch_chmaps' was not declared. Should it be static?
> sound/soc/codecs/hdmi-codec.c:354:6: warning:
>  symbol 'hdmi_codec_eld_chmap' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/codecs/hdmi-codec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Unfortunately, this patch causes conflict to Mark's PR[0], due to a 
commit 8480ac567959 ("ASoC: hdmi-codec: remove HDMI device 
unregister")[1]. I think it better for you to post again with rebasing 
this on the PR, however it depends on Mark's maintenance policy (he 
could resolve the conflict by his hand and apply).

[0] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-February/118079.html
[1] 
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=8480ac567959

> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index dc6715a..4982c91 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -31,7 +31,7 @@ struct hdmi_device {
>  	int cnt;
>  };
>  #define pos_to_hdmi_device(pos)	container_of((pos), struct hdmi_device, list)
> -LIST_HEAD(hdmi_device_list);
> +static LIST_HEAD(hdmi_device_list);
>
>  #define DAI_NAME_SIZE 16
>
> @@ -77,14 +77,14 @@ struct hdmi_codec_cea_spk_alloc {
>  };
>
>  /* Channel maps  stereo HDMI */
> -const struct snd_pcm_chmap_elem hdmi_codec_stereo_chmaps[] = {
> +static const struct snd_pcm_chmap_elem hdmi_codec_stereo_chmaps[] = {
>  	{ .channels = 2,
>  	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
>  	{ }
>  };
>
>  /* Channel maps for multi-channel playbacks, up to 8 n_ch */
> -const struct snd_pcm_chmap_elem hdmi_codec_8ch_chmaps[] = {
> +static const struct snd_pcm_chmap_elem hdmi_codec_8ch_chmaps[] = {
>  	{ .channels = 2, /* CA_ID 0x00 */
>  	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
>  	{ .channels = 4, /* CA_ID 0x01 */
> @@ -351,7 +351,7 @@ static unsigned long hdmi_codec_spk_mask_from_alloc(int spk_alloc)
>  	return spk_mask;
>  }
>
> -void hdmi_codec_eld_chmap(struct hdmi_codec_priv *hcp)
> +static void hdmi_codec_eld_chmap(struct hdmi_codec_priv *hcp)
>  {
>  	u8 spk_alloc;
>  	unsigned long spk_mask;


Thanks

Takashi Sakamoto
