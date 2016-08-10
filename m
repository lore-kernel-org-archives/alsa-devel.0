From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH -next] ASoC: sun4i-codec: Fix error return
	code in sun4i_codec_probe()
Date: Wed, 10 Aug 2016 22:04:23 +0800
Message-ID: <CAGb2v67cVXWtM=AzeFcftnajSs=+C6F12P_EvnXHB=oKsAm5Cw@mail.gmail.com>
References: <1470836554-11569-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 81C7B265A7F
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 16:04:48 +0200 (CEST)
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
 [209.85.223.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 977C620787
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 21:08:40 +0800 (CST)
Received: by mail-io0-f178.google.com with SMTP id m101so42215545ioi.2
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 07:04:46 -0700 (PDT)
In-Reply-To: <1470836554-11569-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, fengguang.wu@intel.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Emilio Lopez <emilio@elopez.com.ar>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, ats@offog.org, Liam Girdwood <lgirdwood@gmail.com>, Hans De Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 10, 2016 at 9:42 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> Fix to return error code -ENOMEM instead of 0 when create card
> failed, as done elsewhere in this function.
>
> Fixes: 45fb6b6f2aa3 ("ASoC: sunxi: add support for the on-chip
> codec on early Allwinner SoCs")
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 0e19c50..e741659 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -846,6 +846,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>         card = sun4i_codec_create_card(&pdev->dev);
>         if (!card) {
>                 dev_err(&pdev->dev, "Failed to create our card\n");
> +               ret = -ENOMEM;
>                 goto err_unregister_codec;
>         }
>

This works, though it might be better to fix the create_card function and
any custom functions called in there to pass back a proper error value.

Regards
ChenYu
