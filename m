From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 31/33] ASoC: max98088: use match_string()
	helper
Date: Tue, 22 May 2018 01:24:41 +0300
Message-ID: <CAHp75Vf2ZTf0w=Kg_w7CJ-9XdGqipe3UVS=E=aeRDxGt3BHM3w@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id EBCFE267380
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 00:24:42 +0200 (CEST)
Received: by mail-qt0-f181.google.com with SMTP id f5-v6so21000858qth.2
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 15:24:42 -0700 (PDT)
In-Reply-To: <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

>  static int max98088_get_channel(struct snd_soc_component *component, const char *name)
>  {

> +       int ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
I would rather split this and move an assignment to the line before 'if'

>
>         /* Shouldn't happen */

> +       if (ret < 0)
> +               dev_err(component->dev, "Bad EQ channel name '%s'\n", name);

>         return -EINVAL;

return ret;

?

>  }
>
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
