From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 32/33] ASoC: max98095: use match_string()
	helper
Date: Tue, 22 May 2018 01:25:39 +0300
Message-ID: <CAHp75Vdr08D1XreBRadRTTNFnty4rLm2i=V-uQtVKUPRvXqjYQ@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-33-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83A33267380
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 00:25:41 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id b39-v6so13056618qkb.5
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 15:25:41 -0700 (PDT)
In-Reply-To: <1526903890-35761-33-git-send-email-xieyisheng1@huawei.com>
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


> +       int ret = match_string(bq_mode_name, ARRAY_SIZE(bq_mode_name), name);

Rather split and move an assignment to the line before 'if'.

>
>         /* Shouldn't happen */

> +       if (ret < 0)
> +               dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
> +       return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko
