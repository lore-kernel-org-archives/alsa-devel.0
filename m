From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH - try2] ASoC: Codec driver for Texas
 Instruments tlv320dac33 codec
Date: Tue, 13 Oct 2009 15:41:38 +0300
Message-ID: <1255437698.30157.289.camel@eenurkka-desktop>
References: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A0D31038B5
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 14:43:15 +0200 (CEST)
In-Reply-To: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-10-13 at 14:03 +0200, Ujfalusi Peter (Nokia-D/Tampere)
wrote:
> +static int dac33_write_locked(struct snd_soc_codec *codec, unsigned int reg,
> +                      unsigned int value)
> +{
> +       struct tlv320dac33_priv *dac33 = codec->private_data;
> +       u8 data[2];
> +       int ret = 0;
> +
> +       /*
> +        * data is
> +        *   D15..D8 dac33 register offset
> +        *   D7...D0 register data
> +        */
> +       data[0] = reg & 0xff;
> +       data[1] = value & 0xff;
> +
> +       dac33_write_reg_cache(codec, data[0], data[1]);
> +       mutex_lock(&dac33->mutex);
> +       if (dac33->chip_power) {
> +               ret = codec->hw_write(codec->control_data, data, 2);
> +               if (ret != 2)
> +                       dev_err(codec->dev, "Write failed (%d)\n", ret);
> +               else
> +                       ret = 0;
> +       }
> +       mutex_unlock(&dac33->mutex);
> +
> +       return ret;
> +}

Mark, aren't all codec bits updated within the snd_soc_update_bits() by
DAPM? It always takes the io_mutex. Does it make sense if we proposed a
new item to struct snd_soc_codec, something like io_mutex? then 
snd_soc_update_bits() would check the presence of this codec->io_mutex,
and if it was present, it would only use that instead of io_mutex.
Just an idea... (I'd help here, no need for double locking like now)
