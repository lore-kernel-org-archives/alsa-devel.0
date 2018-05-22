From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 31/33] ASoC: max98088: use match_string() helper
Date: Tue, 22 May 2018 20:23:33 +0300
Message-ID: <CAHp75Vesp4BmnLNK4iqw_nG+7_rtgQceqbRdtGCmU46nLSHT3w@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Vf2ZTf0w=Kg_w7CJ-9XdGqipe3UVS=E=aeRDxGt3BHM3w@mail.gmail.com> <92b32dee-7ba9-ad6d-573b-9924453a69fb@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <92b32dee-7ba9-ad6d-573b-9924453a69fb@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 22, 2018 at 3:30 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:

> hmm, you mean something like:
>
>         int ret;
>
>         ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
>         if (ret < 0) /* Shouldn't happen */
>                 dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
>         return ret;

Yes. (But remove that useless comment).

-- 
With Best Regards,
Andy Shevchenko
