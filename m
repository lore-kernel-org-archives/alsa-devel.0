From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Commit 8f7206d69a ("ASoC: imx-wm8962: Remove
 global variables") looks strange
Date: Mon, 26 Feb 2018 11:34:44 -0300
Message-ID: <CAOMZO5DEF5EW9zu1qxy69x-1GU8rGCVN9iEJpRqLzRxZLEgMrA@mail.gmail.com>
References: <1519654860.13463.95.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id DCCFB26755D
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 15:34:46 +0100 (CET)
Received: by mail-ot0-f169.google.com with SMTP id h8so91089oti.6
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 06:34:46 -0800 (PST)
In-Reply-To: <1519654860.13463.95.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On Mon, Feb 26, 2018 at 11:21 AM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> Hi Fabio,
>
> Leonard (Cc'ed) noticed that commit in $subject looks very strange.
>
> For example:
>
> @@ -139,7 +140,7 @@ static int imx_wm8962_late_probe(struct snd_soc_card *card)
>  {
>         struct snd_soc_pcm_runtime *rtd;
>         struct snd_soc_dai *codec_dai;
> -       struct imx_priv *priv = &card_priv;
> +       struct imx_priv *priv = snd_soc_card_get_drvdata(card);
>         struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
>
> So, now data and priv point to the same memory area but they are completely
> different structures!
>
> Unless we are missing something this is obviously a bug. I will try to have a look at
> the end of the week, but any comments are welcome.
>
> I think the fix would be to have one global priv structure and to unify imx_wm8962_data
> with imx_priv.

Could you please look in mainline? The structs were re arranged there
and I do not see this problem.

Please confirm.
