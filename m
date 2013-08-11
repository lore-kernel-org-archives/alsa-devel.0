From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: ak5386: Add DAPM support
Date: Sun, 11 Aug 2013 13:38:23 +0200
Message-ID: <520777AF.5000900@gmail.com>
References: <1376220924-13246-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f47.google.com (mail-ee0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 58813260309
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 13:38:25 +0200 (CEST)
Received: by mail-ee0-f47.google.com with SMTP id d49so2942672eek.34
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 04:38:25 -0700 (PDT)
In-Reply-To: <1376220924-13246-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11.08.2013 13:35, Mark Brown wrote:
> +static struct snd_soc_codec_driver soc_codec_ak5386 = {
> +	.dapm_widgets = ak4554_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(ak4554_dapm_widgets),
> +	.dapm_routes = ak4554_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(ak4554_dapm_routes),

Any particular reason for the name mismatches (ak4554 vs ak5386)?


Daniel
