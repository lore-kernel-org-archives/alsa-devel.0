From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v5 2/9] ASoC: soc-core: Allow searching dai driver name in snd_soc_find_dai
Date: Tue, 22 Aug 2017 21:24:32 +0800
Message-ID: <CAErzpmtbbWbt28KPaFLVdwzuWy3A7se7_WBN8q6aJrHLbtT-LQ@mail.gmail.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com> <20170822075729.8438-3-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170822075729.8438-3-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, briannorris@chromium.org, mengdong.lin@linux.intel.com, mka@chromium.org, lars@metafoo.de, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi jeffy,

On Tue, Aug 22, 2017 at 3:57 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:

> @@ -978,7 +978,8 @@ struct snd_soc_dai *snd_soc_find_dai(
>                 if (dlc->name && strcmp(component->name, dlc->name))
>                         continue;
>                 list_for_each_entry(dai, &component->dai_list, list) {
> -                       if (dlc->dai_name && strcmp(dai->name, dlc->dai_name))
> +                       if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
> +                           && strcmp(dai->driver->name, dlc->dai_name))

In case that dai->driver->name is NULL, strcmp(dai->driver->name,
dlc->dai_name) will cause segmentation fault.
so I think that we can change it as the follows:

                      if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
                           && dai->driver->name &&
strcmp(dai->driver->name, dlc->dai_name))

>                                 continue;
>
>                         return dai;
> --
> 2.11.0
>
>
