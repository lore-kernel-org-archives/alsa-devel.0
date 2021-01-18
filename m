Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4936C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:01:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079E6224B8
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079E6224B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ED6717E3;
	Mon, 18 Jan 2021 13:00:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ED6717E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610971286;
	bh=7fABU2jO60f00TOEuMyFx7EyErJZcjnUJM1yubVOkFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2Qf6b2S13nU0ZTnkBQ+s+Xb/s6F/C1eHAeyGdxy1Sca2Tsucdj4c29G7WVCQy+s+
	 wv4ZDwMw7PnKuVfd+r5B72rQqAPTcPQUa1xF8mtBqzS4RKiwXZqIIIrPTx7+VMl5I9
	 vt2TDNeVLmyOo4wXReFgQOQIn3x+dAOLbQbnQTkc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE184F800E7;
	Mon, 18 Jan 2021 13:00:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 165D9F8016E; Mon, 18 Jan 2021 13:00:34 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB935F800E7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 13:00:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB935F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="pgB12yDy"
Received: by mail-pj1-x1031.google.com with SMTP id md11so9376426pjb.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 04:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C9t16M0rhAwwUEc/H1PLusmgr6OGhsXk+XRbU0LxKps=;
 b=pgB12yDy8aBb8+gbgBTicOvn5YaVLxjHWQ6bfBM3l7B+kbl9PvXhpec/b+BRrcpmg+
 kg/zctCk/ywvi+M6NHojc3bseKjbCKRBKjgpU/P1E4YoPZzc4cXIWKrG+g8ZTTS2fQWD
 2nBdt8v03RNwt4ar97bM6Tfc/HsL7DuAAHjVUbaqVFho70akbWeJSlD7JsOCu5EHY04f
 I1WlBeg5WZD4uHsQP6YxFuZLxY3aAv6i5yOwTe6owlklrA5HH/liyu1Mdjd1KhX21yje
 T3yXmPd05BvqCCDYFBmXIVNPEOZIryPRU1hFnZ3k/BJtW0LrBNJTMFd2CK3L/20Slf/Y
 PJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C9t16M0rhAwwUEc/H1PLusmgr6OGhsXk+XRbU0LxKps=;
 b=jIB3WP9U1h1UIQVGrxI69NQJSeaQlc9B2frdxUOiBfcwl4OiK82WXdTHK3PXBtqyeo
 KkkJ+BOf+jvboYFq1/fAGm+i7GNETxeZc3Ahf5IxObtbJJtSFGpvl18k/9OQxyeen17l
 nH1LLZXXbmzGU9+eyUx6H2oY2+4HY88dfxgO77VJvPrKAqiSOQLhA+zy3X9ccbT+g5iM
 rKpyxZw7vehPifYHcChIJtegvx+9euv6X8WnIt1ODmnX4eAEm2+c93AkmA8wvRjOJ0NU
 TxG/gWflpGJgw1xjTVuXTRlO6Iq6bQFtf76pBXPNm+5hLv4bvfHkWaY6GxOyGk9yoB2L
 tXig==
X-Gm-Message-State: AOAM531LFRL+MPjbnSmpsRotBM04jDgBMNIzpLyszYUjaN5986vrFfHx
 +k8XEWiFWckUIZFkSMDXH0Sc5YOVa55EBbC8wEI=
X-Google-Smtp-Source: ABdhPJxnmoCYkRfPwQwFux3QOBPJ7RyAOx2LT0Y/U1zOLGNR2+2sDUkif9CrCw17/VksA4pWQb+BcN0rrSfVHhFBAAc=
X-Received: by 2002:a17:90a:4d83:: with SMTP id
 m3mr26360559pjh.228.1610971227187; 
 Mon, 18 Jan 2021 04:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-7-hdegoede@redhat.com>
In-Reply-To: <20210117160555.78376-7-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Jan 2021 14:01:16 +0200
Message-ID: <CAHp75VfZ5-2+sRwXyhfQcPhv_Eqm_sot8AXt-M0QfW+15YhqRA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] ASoC: arizona-jack: Move jack-detect variables
 to struct arizona_priv
To: Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Move all the jack-detect variables from struct arizona_extcon_info to
> struct arizona_priv.
>
> This is part of a patch series converting the arizona extcon driver into
> a helper library for letting the arizona codec-drivers directly report jack
> state through the standard sound/soc/soc-jack.c functions.

Seems straight forward.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  sound/soc/codecs/arizona-jack.c | 97 ++++++++++-----------------------
>  sound/soc/codecs/arizona.h      | 36 ++++++++++++
>  2 files changed, 65 insertions(+), 68 deletions(-)
>
> diff --git a/sound/soc/codecs/arizona-jack.c b/sound/soc/codecs/arizona-jack.c
> index 72d23b15108c..c81c3b20f94e 100644
> --- a/sound/soc/codecs/arizona-jack.c
> +++ b/sound/soc/codecs/arizona-jack.c
> @@ -27,6 +27,8 @@
>  #include <linux/mfd/arizona/registers.h>
>  #include <dt-bindings/mfd/arizona.h>
>
> +#include "arizona.h"
> +
>  #define ARIZONA_MAX_MICD_RANGE 8
>
>  #define ARIZONA_MICD_CLAMP_MODE_JDL      0x4
> @@ -61,47 +63,6 @@
>
>  #define MICD_LVL_0_TO_8 (MICD_LVL_0_TO_7 | ARIZONA_MICD_LVL_8)
>
> -struct arizona_extcon_info {
> -       struct device *dev;
> -       struct arizona *arizona;
> -       struct mutex lock;
> -       struct regulator *micvdd;
> -       struct input_dev *input;
> -
> -       u16 last_jackdet;
> -
> -       int micd_mode;
> -       const struct arizona_micd_config *micd_modes;
> -       int micd_num_modes;
> -
> -       const struct arizona_micd_range *micd_ranges;
> -       int num_micd_ranges;
> -
> -       bool micd_reva;
> -       bool micd_clamp;
> -
> -       struct delayed_work hpdet_work;
> -       struct delayed_work micd_detect_work;
> -       struct delayed_work micd_timeout_work;
> -
> -       bool hpdet_active;
> -       bool hpdet_done;
> -       bool hpdet_retried;
> -
> -       int num_hpdet_res;
> -       unsigned int hpdet_res[3];
> -
> -       bool mic;
> -       bool detecting;
> -       int jack_flips;
> -
> -       int hpdet_ip_version;
> -
> -       struct extcon_dev *edev;
> -
> -       struct gpio_desc *micd_pol_gpio;
> -};
> -
>  static const struct arizona_micd_config micd_default_modes[] = {
>         { ARIZONA_ACCDET_SRC, 1, 0 },
>         { 0,                  2, 1 },
> @@ -135,9 +96,9 @@ static const unsigned int arizona_cable[] = {
>         EXTCON_NONE,
>  };
>
> -static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info);
> +static void arizona_start_hpdet_acc_id(struct arizona_priv *info);
>
> -static void arizona_extcon_hp_clamp(struct arizona_extcon_info *info,
> +static void arizona_extcon_hp_clamp(struct arizona_priv *info,
>                                     bool clamp)
>  {
>         struct arizona *arizona = info->arizona;
> @@ -222,7 +183,7 @@ static void arizona_extcon_hp_clamp(struct arizona_extcon_info *info,
>         snd_soc_dapm_mutex_unlock(arizona->dapm);
>  }
>
> -static void arizona_extcon_set_mode(struct arizona_extcon_info *info, int mode)
> +static void arizona_extcon_set_mode(struct arizona_priv *info, int mode)
>  {
>         struct arizona *arizona = info->arizona;
>
> @@ -243,7 +204,7 @@ static void arizona_extcon_set_mode(struct arizona_extcon_info *info, int mode)
>         dev_dbg(arizona->dev, "Set jack polarity to %d\n", mode);
>  }
>
> -static const char *arizona_extcon_get_micbias(struct arizona_extcon_info *info)
> +static const char *arizona_extcon_get_micbias(struct arizona_priv *info)
>  {
>         switch (info->micd_modes[0].bias) {
>         case 1:
> @@ -257,7 +218,7 @@ static const char *arizona_extcon_get_micbias(struct arizona_extcon_info *info)
>         }
>  }
>
> -static void arizona_extcon_pulse_micbias(struct arizona_extcon_info *info)
> +static void arizona_extcon_pulse_micbias(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         const char *widget = arizona_extcon_get_micbias(info);
> @@ -282,7 +243,7 @@ static void arizona_extcon_pulse_micbias(struct arizona_extcon_info *info)
>         }
>  }
>
> -static void arizona_start_mic(struct arizona_extcon_info *info)
> +static void arizona_start_mic(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         bool change;
> @@ -339,7 +300,7 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
>         }
>  }
>
> -static void arizona_stop_mic(struct arizona_extcon_info *info)
> +static void arizona_stop_mic(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         const char *widget = arizona_extcon_get_micbias(info);
> @@ -407,7 +368,7 @@ static struct {
>         { 1000, 10000 },
>  };
>
> -static int arizona_hpdet_read(struct arizona_extcon_info *info)
> +static int arizona_hpdet_read(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         unsigned int val, range;
> @@ -527,7 +488,7 @@ static int arizona_hpdet_read(struct arizona_extcon_info *info)
>         return val;
>  }
>
> -static int arizona_hpdet_do_id(struct arizona_extcon_info *info, int *reading,
> +static int arizona_hpdet_do_id(struct arizona_priv *info, int *reading,
>                                bool *mic)
>  {
>         struct arizona *arizona = info->arizona;
> @@ -597,7 +558,7 @@ static int arizona_hpdet_do_id(struct arizona_extcon_info *info, int *reading,
>
>  static irqreturn_t arizona_hpdet_irq(int irq, void *data)
>  {
> -       struct arizona_extcon_info *info = data;
> +       struct arizona_priv *info = data;
>         struct arizona *arizona = info->arizona;
>         int id_gpio = arizona->pdata.hpdet_id_gpio;
>         unsigned int report = EXTCON_JACK_HEADPHONE;
> @@ -684,7 +645,7 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
>         return IRQ_HANDLED;
>  }
>
> -static void arizona_identify_headphone(struct arizona_extcon_info *info)
> +static void arizona_identify_headphone(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         int ret;
> @@ -737,7 +698,7 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
>         info->hpdet_active = false;
>  }
>
> -static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
> +static void arizona_start_hpdet_acc_id(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         int hp_reading = 32;
> @@ -790,8 +751,8 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
>
>  static void arizona_micd_timeout_work(struct work_struct *work)
>  {
> -       struct arizona_extcon_info *info = container_of(work,
> -                                               struct arizona_extcon_info,
> +       struct arizona_priv *info = container_of(work,
> +                                               struct arizona_priv,
>                                                 micd_timeout_work.work);
>
>         mutex_lock(&info->lock);
> @@ -805,7 +766,7 @@ static void arizona_micd_timeout_work(struct work_struct *work)
>         mutex_unlock(&info->lock);
>  }
>
> -static int arizona_micd_adc_read(struct arizona_extcon_info *info)
> +static int arizona_micd_adc_read(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         unsigned int val;
> @@ -842,7 +803,7 @@ static int arizona_micd_adc_read(struct arizona_extcon_info *info)
>         return val;
>  }
>
> -static int arizona_micd_read(struct arizona_extcon_info *info)
> +static int arizona_micd_read(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         unsigned int val = 0;
> @@ -875,7 +836,7 @@ static int arizona_micd_read(struct arizona_extcon_info *info)
>
>  static int arizona_micdet_reading(void *priv)
>  {
> -       struct arizona_extcon_info *info = priv;
> +       struct arizona_priv *info = priv;
>         struct arizona *arizona = info->arizona;
>         int ret, val;
>
> @@ -969,7 +930,7 @@ static int arizona_micdet_reading(void *priv)
>
>  static int arizona_button_reading(void *priv)
>  {
> -       struct arizona_extcon_info *info = priv;
> +       struct arizona_priv *info = priv;
>         struct arizona *arizona = info->arizona;
>         int val, key, lvl, i;
>
> @@ -1017,8 +978,8 @@ static int arizona_button_reading(void *priv)
>
>  static void arizona_micd_detect(struct work_struct *work)
>  {
> -       struct arizona_extcon_info *info = container_of(work,
> -                                               struct arizona_extcon_info,
> +       struct arizona_priv *info = container_of(work,
> +                                               struct arizona_priv,
>                                                 micd_detect_work.work);
>         struct arizona *arizona = info->arizona;
>         int ret;
> @@ -1051,7 +1012,7 @@ static void arizona_micd_detect(struct work_struct *work)
>
>  static irqreturn_t arizona_micdet(int irq, void *data)
>  {
> -       struct arizona_extcon_info *info = data;
> +       struct arizona_priv *info = data;
>         struct arizona *arizona = info->arizona;
>         int debounce = arizona->pdata.micd_detect_debounce;
>
> @@ -1075,8 +1036,8 @@ static irqreturn_t arizona_micdet(int irq, void *data)
>
>  static void arizona_hpdet_work(struct work_struct *work)
>  {
> -       struct arizona_extcon_info *info = container_of(work,
> -                                               struct arizona_extcon_info,
> +       struct arizona_priv *info = container_of(work,
> +                                               struct arizona_priv,
>                                                 hpdet_work.work);
>
>         mutex_lock(&info->lock);
> @@ -1084,7 +1045,7 @@ static void arizona_hpdet_work(struct work_struct *work)
>         mutex_unlock(&info->lock);
>  }
>
> -static int arizona_hpdet_wait(struct arizona_extcon_info *info)
> +static int arizona_hpdet_wait(struct arizona_priv *info)
>  {
>         struct arizona *arizona = info->arizona;
>         unsigned int val;
> @@ -1120,7 +1081,7 @@ static int arizona_hpdet_wait(struct arizona_extcon_info *info)
>
>  static irqreturn_t arizona_jackdet(int irq, void *data)
>  {
> -       struct arizona_extcon_info *info = data;
> +       struct arizona_priv *info = data;
>         struct arizona *arizona = info->arizona;
>         unsigned int val, present, mask;
>         bool cancelled_hp, cancelled_mic;
> @@ -1380,7 +1341,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  {
>         struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
>         struct arizona_pdata *pdata = &arizona->pdata;
> -       struct arizona_extcon_info *info;
> +       struct arizona_priv *info;
>         unsigned int val;
>         unsigned int clamp_mode;
>         int jack_irq_fall, jack_irq_rise;
> @@ -1754,7 +1715,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>
>  static int arizona_extcon_remove(struct platform_device *pdev)
>  {
> -       struct arizona_extcon_info *info = platform_get_drvdata(pdev);
> +       struct arizona_priv *info = platform_get_drvdata(pdev);
>         struct arizona *arizona = info->arizona;
>         int jack_irq_rise, jack_irq_fall;
>         bool change;
> diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
> index b893d3e4c97c..d1a263a67bba 100644
> --- a/sound/soc/codecs/arizona.h
> +++ b/sound/soc/codecs/arizona.h
> @@ -91,6 +91,42 @@ struct arizona_priv {
>         unsigned int dvfs_reqs;
>         struct mutex dvfs_lock;
>         bool dvfs_cached;
> +
> +       /* Variables used by arizona-jack.c code */
> +       struct device *dev;
> +       struct mutex lock;
> +       struct delayed_work hpdet_work;
> +       struct delayed_work micd_detect_work;
> +       struct delayed_work micd_timeout_work;
> +       struct regulator *micvdd;
> +       struct input_dev *input;
> +       struct extcon_dev *edev;
> +       struct gpio_desc *micd_pol_gpio;
> +
> +       u16 last_jackdet;
> +
> +       int micd_mode;
> +       const struct arizona_micd_config *micd_modes;
> +       int micd_num_modes;
> +
> +       const struct arizona_micd_range *micd_ranges;
> +       int num_micd_ranges;
> +
> +       bool micd_reva;
> +       bool micd_clamp;
> +
> +       bool hpdet_active;
> +       bool hpdet_done;
> +       bool hpdet_retried;
> +
> +       bool mic;
> +       bool detecting;
> +
> +       int num_hpdet_res;
> +       unsigned int hpdet_res[3];
> +
> +       int jack_flips;
> +       int hpdet_ip_version;
>  };
>
>  struct arizona_voice_trigger_info {
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
