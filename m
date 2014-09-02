From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCHv3 2/9] WM8971 uses SOC_ENUM_SINGLE_DECL to
 replace SOC_ENUM_SINGLE
Date: Tue, 02 Sep 2014 16:56:12 +0200
Message-ID: <5405DA8C.7020403@metafoo.de>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
 <1409628470-13059-2-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-164.synserver.de
 [212.40.185.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 1888B2655EA
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 16:56:18 +0200 (CEST)
In-Reply-To: <1409628470-13059-2-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 09/02/2014 05:27 AM, Xavier Hsu wrote:
[...]
> +static int wm8971_put_deemph(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
> +	int deemph = ucontrol->value.enumerated.item[0];
> +	int ret = 0;
> +
> +	if (deemph > 1)
> +		return -EINVAL;
> +
> +	mutex_lock(&codec->mutex);

Please use a driver local mutex. The snd_soc_codec mutex is going to be 
removed sooner or later and we shouldn't add new users.

> +	if (wm8971->deemph != deemph) {
> +		wm8971->deemph = deemph;
> +		wm8971_set_deemph(codec);
> +
> +		ret = 1;
> +	}
> +	mutex_unlock(&codec->mutex);
> +
> +	return ret;
> +}
