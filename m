From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: Resend: [PATCH 1/4] ASoC: dapm: fix error path in
 snd_soc_dapm_new_pcm
Date: Tue, 19 Sep 2017 13:03:59 +0100
Message-ID: <20170919120359.lo455b2r7s377dyp@localhost.localdomain>
References: <CABCoZhCST2kbTNT4BpwniipkaD=dGB5Jb0WFw6QckUaJYxMKxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 808B6266F0D
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 14:04:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABCoZhCST2kbTNT4BpwniipkaD=dGB5Jb0WFw6QckUaJYxMKxA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 14, 2017 at 10:02:17PM -0700, anish kumar wrote:
> From: anish kumar <yesanishhere@gmail.com>
> 
> Before freeing the memory, check if it was allcoated.
> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  sound/soc/soc-dapm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index dcef67a..f51f613 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3907,9 +3907,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
>         devm_kfree(card->dev, (void *)private_value);
>  outfree_link_name:
>         devm_kfree(card->dev, link_name);
> -outfree_w_param:
>         for (count = 0 ; count < num_params; count++)
>                 devm_kfree(card->dev, (void *)w_param_text[count]);
> +outfree_w_param:
>         devm_kfree(card->dev, w_param_text);
> 
>         return ret;
> --
> 2.5.4 (Apple Git-61)

Your email client appears to be mangling the whitespace in your
patches which makes them exceptionally hard to apply. Have a look
in Documentation/process/email-clients.rst and resend please.

Thanks,
Charles
