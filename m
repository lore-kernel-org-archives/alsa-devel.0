From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: bt-sco: support wide band speech
Date: Wed, 26 Nov 2014 12:30:45 +0100
Message-ID: <5475B9E5.7040705@metafoo.de>
References: <1416978538-3318-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-231.synserver.de (smtp-out-231.synserver.de
 [212.40.185.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E1972652C3
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 12:30:42 +0100 (CET)
In-Reply-To: <1416978538-3318-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: Yibo Cai <Yibo.Cai@csr.com>, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

On 11/26/2014 06:08 AM, Barry Song wrote:
> From: Yibo Cai <Yibo.Cai@csr.com>
>
> HFP1.6 requires support for wide band speech(16KHz) over Bluetooth.
>
> Signed-off-by: Yibo Cai <Yibo.Cai@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>   sound/soc/codecs/bt-sco.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
> index c4cf069..3878491 100644
> --- a/sound/soc/codecs/bt-sco.c
> +++ b/sound/soc/codecs/bt-sco.c
> @@ -52,6 +52,14 @@ static struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
>
>   static int bt_sco_probe(struct platform_device *pdev)
>   {
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +
> +	/* Check wide band SCO(16KHz) support */
> +	if (id && (strcmp(id->name, "bt-sco-wb") == 0)) {

Use id->driver_data instead of strcmp.

> +		bt_sco_dai.playback.rates |= SNDRV_PCM_RATE_16000;
> +		bt_sco_dai.capture.rates |= SNDRV_PCM_RATE_16000;

This is modifying a driver global struct with device local data. This is a 
no-go. Either add second snd_soc_dai_driver with the new rates or add a 
startup callback and add the constraints using snd_pcm_hw_constraint_list().
