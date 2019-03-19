From: Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH] ASoC: codecs: Fix to avoid potential NULL
	pointer dereferences
Date: Mon, 18 Mar 2019 20:03:56 -0500
Message-ID: <CA+EnHHTAKMafHG8cspAipzKfH3F3EX8oXaMkZyEfAD1ByQB6Gw@mail.gmail.com>
References: <20190319005805.13823-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-p7.oit.umn.edu (mta-p7.oit.umn.edu [134.84.196.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B476F80792
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 02:04:36 +0100 (CET)
Received: from localhost (unknown [127.0.0.1])
 by mta-p7.oit.umn.edu (Postfix) with ESMTP id EEE19ACB
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 01:04:33 +0000 (UTC)
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPccapG3FB7x for <alsa-devel@alsa-project.org>;
 Mon, 18 Mar 2019 20:04:33 -0500 (CDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p7.oit.umn.edu (Postfix) with ESMTPS id BF0F6677
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 20:04:33 -0500 (CDT)
Received: by mail-oi1-f197.google.com with SMTP id k131so8595762oif.2
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 18:04:33 -0700 (PDT)
In-Reply-To: <20190319005805.13823-1-pakki001@umn.edu>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Aditya Pakki <pakki001@umn.edu>
Cc: Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Apologies for the incorrect patch.
"match" is dead code and I will send a correct patch again.




On Mon, Mar 18, 2019 at 7:58 PM Aditya Pakki <pakki001@umn.edu> wrote:

> In sirf_audio_codec_driver_probe, of_match_node may fail and return a
> NULL pointer. The patch avoids a potential NULL pointer dereference.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  sound/soc/codecs/sirf-audio-codec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/sirf-audio-codec.c
> b/sound/soc/codecs/sirf-audio-codec.c
> index e424499a8450..fd2bbd6a3c58 100644
> --- a/sound/soc/codecs/sirf-audio-codec.c
> +++ b/sound/soc/codecs/sirf-audio-codec.c
> @@ -464,6 +464,8 @@ static int sirf_audio_codec_driver_probe(struct
> platform_device *pdev)
>         const struct of_device_id *match;
>
>         match = of_match_node(sirf_audio_codec_of_match,
> pdev->dev.of_node);
> +       if (!match)
> +               return -ENXIO;
>
>         sirf_audio_codec = devm_kzalloc(&pdev->dev,
>                 sizeof(struct sirf_audio_codec), GFP_KERNEL);
> --
> 2.17.1
>
>
