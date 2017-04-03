From: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v4] ASoC: Add support for Maxim Integrated MAX98927 Amplifier
Date: Mon, 3 Apr 2017 10:24:38 -0700
Message-ID: <CAN4-ojkdnzp59zMVj8fQj0NBAW-AdNvMt-YhvOMjBnMLv30-rA@mail.gmail.com>
References: <1490922994-19294-1-git-send-email-ryans.lee@maximintegrated.com> <20170403163053.u6b3yadkfyh4z7h5@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170403163053.u6b3yadkfyh4z7h5@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, nh6z-fFIq/eER6g8@public.gmane.org, KCHSU0-KrzQf0k3Iz9BDgjK7y7TUQ@public.gmane.org, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dylan Reid <dgreid-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 3, 2017 at 9:30 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Mar 31, 2017 at 10:16:34AM +0900, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
>> ---
>>
>> Changes since v4:
>>       * Removed support for SND_SOC_DAIFMT_CBS_CFM.
>>       * Fixed coding style for indention.
>>       * Removed variables if it has only one user.
>>       * Assigned ch_size directly.
>>       * Removed oring.
>>       * Put the return false in the switch statement.
>>       * Removed 'Monomix Output' and 'Speaker Source' controls.
>>       * Modified control names per control-names.rst.
>>       * Moved Revision ID check code to i2c_probe function.
>>       * Added 'Current Limit' control.
>>       * Removed 'devm__kfree' function.
>>
>> Changes since v3:
>>       * Combined MAX98926 and MAX98927 binding. Kept existing property name.
>
> This looks fine, but:
>
>> Changes since v2:
>>       * Removed local register read/write function to avoid duplication of ASoC core function.
>>
>>  .../devicetree/bindings/sound/max98925.txt         |  22 -
>>  .../devicetree/bindings/sound/max98926.txt         |  32 -
>>  .../devicetree/bindings/sound/max9892x.txt         |  41 +
>>  sound/soc/codecs/Kconfig                           |   5 +
>>  sound/soc/codecs/Makefile                          |   2 +
>>  sound/soc/codecs/max98927.c                        | 841 +++++++++++++++++++++
>>  sound/soc/codecs/max98927.h                        | 272 +++++++
>>  7 files changed, 1161 insertions(+), 54 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/sound/max98925.txt
>>  delete mode 100644 Documentation/devicetree/bindings/sound/max98926.txt
>>  create mode 100755 Documentation/devicetree/bindings/sound/max9892x.txt
>>  mode change 100644 => 100755 sound/soc/codecs/Kconfig
>>  mode change 100644 => 100755 sound/soc/codecs/Makefile
>>  create mode 100755 sound/soc/codecs/max98927.c
>>  create mode 100755 sound/soc/codecs/max98927.h
>
> These should all be 644 mode.

I've changed the mode to 644. Thank you.

>
> Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
