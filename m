From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: cs4271: Add DAPM support
Date: Sun, 11 Aug 2013 18:02:42 +0200
Message-ID: <5207B5A2.2060203@gmail.com>
References: <1376223377-23047-1-git-send-email-broonie@kernel.org>
 <1376223377-23047-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3833726080B
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 18:02:46 +0200 (CEST)
Received: by mail-ea0-f179.google.com with SMTP id b10so3015571eae.10
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 09:02:44 -0700 (PDT)
In-Reply-To: <1376223377-23047-2-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11.08.2013 14:16, Mark Brown wrote:
> +static const struct snd_soc_dapm_widget cs4271_dapm_widgets[] = {
> +SND_SOC_DAPM_INPUT("AINA"),
> +SND_SOC_DAPM_INPUT("AINB"),
> +
> +SND_SOC_DAPM_OUTPUT("AOUTA+"),
> +SND_SOC_DAPM_OUTPUT("AOUTA-"),
> +SND_SOC_DAPM_OUTPUT("AOUTB+"),
> +SND_SOC_DAPM_OUTPUT("AOUTB-"),
> +};
> +
> +static const struct snd_soc_dapm_route cs4271_dapm_routes[] = {
> +	{ "Capture", NULL, "AINL" },
> +	{ "Capture", NULL, "AINR" },

Here you call the widgets "AINL"/"AINR", while above it's "AINA"/"AINB".
 According to the datasheet, the latter is
correct.


Daniel
