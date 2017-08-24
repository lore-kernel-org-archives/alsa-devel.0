From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v2] ASoC: Add a sanity check before using dai driver name
Date: Thu, 24 Aug 2017 11:46:39 +0800
Message-ID: <CAErzpmvnDs-WBRVCn+wdQw2cxiT+h0gdBci5UqPXEvffRtBmMw@mail.gmail.com>
References: <20170824033411.5788-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824033411.5788-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, tiwai@suse.de, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 24, 2017 at 11:34 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>                 list_for_each_entry(dai, &component->dai_list, list) {
>                         if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
> -                           && strcmp(dai->driver->name, dlc->dai_name))
> +                           && (!dai->driver->name
> +                               || !strcmp(dai->driver->name, dlc->dai_name))
>                                 continue;

If the dai->driver->name is match with the dlc->dai_name, does it need
to continue?

>
>                         return dai;
