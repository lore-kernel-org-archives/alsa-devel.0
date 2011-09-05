From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: alc5623: Remove unused mutex
Date: Tue, 6 Sep 2011 00:54:54 +0100
Message-ID: <CABS+qY0ubjiQ3cfqd5Qzpiq9ocMhKMmZ6nUd7tDKc3eFxZUp0g@mail.gmail.com>
References: <1315147707.2662.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id BA451245F1
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 01:54:56 +0200 (CEST)
Received: by qwi2 with SMTP id 2so4360644qwi.36
	for <alsa-devel@alsa-project.org>; Mon, 05 Sep 2011 16:54:54 -0700 (PDT)
In-Reply-To: <1315147707.2662.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On 4 September 2011 15:48, Axel Lin <axel.lin@gmail.com> wrote:

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---
>  sound/soc/codecs/alc5623.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
> index eecffb5..0517315 100644
> --- a/sound/soc/codecs/alc5623.c
> +++ b/sound/soc/codecs/alc5623.c
> @@ -41,7 +41,6 @@ MODULE_PARM_DESC(caps_charge, "ALC5623 cap charge time
> (msecs)");
>  struct alc5623_priv {
>        enum snd_soc_control_type control_type;
>        void *control_data;
> -       struct mutex mutex;
>        u8 id;
>        unsigned int sysclk;
>        u16 reg_cache[ALC5623_VENDOR_ID2+2];
> @@ -1052,7 +1051,6 @@ static int alc5623_i2c_probe(struct i2c_client
> *client,
>        i2c_set_clientdata(client, alc5623);
>        alc5623->control_data = client;
>        alc5623->control_type = SND_SOC_I2C;
> -       mutex_init(&alc5623->mutex);
>
>        ret =  snd_soc_register_codec(&client->dev,
>                &soc_codec_device_alc5623, &alc5623_dai, 1);
> --
> 1.7.4.1
>
>
>
>
Acked-by: Liam Girdwood <lrg@ti.com>
