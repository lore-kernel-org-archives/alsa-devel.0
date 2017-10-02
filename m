From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 1/2] ASoC: codecs: msm8916-wcd-analog:
 move pm8916_wcd_setup_mbhc
Date: Mon, 2 Oct 2017 10:57:52 +0100
Message-ID: <06a1ca9b-f1aa-944e-0202-36a9c5af121b@linaro.org>
References: <20170929174246.12144-1-damien.riegel@savoirfairelinux.com>
 <20170929174246.12144-2-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B4772670B0
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 11:57:54 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id m72so9475952wmc.1
 for <alsa-devel@alsa-project.org>; Mon, 02 Oct 2017 02:57:54 -0700 (PDT)
In-Reply-To: <20170929174246.12144-2-damien.riegel@savoirfairelinux.com>
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
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, kernel@savoirfairelinux.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


Thanks for the patch,

On 29/09/17 18:42, Damien Riegel wrote:
> In preparation of a fix for the initial detection of headset,
> pm8916_wcd_setup_mbhc is moved to be defined after
> pm8916_mbhc_configure_bias instead of before.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>   sound/soc/codecs/msm8916-wcd-analog.c | 88 +++++++++++++++++------------------
>   1 file changed, 44 insertions(+), 44 deletions(-)
> 
I would suggest you to move this changes to second patch.

thanks,
srini

> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index f562f2d86907..9f08d998a79b 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -443,50 +443,6 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
>   						     wcd->micbias1_cap_mode);
>   }
