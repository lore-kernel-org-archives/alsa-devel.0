From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: ts3a227e: Remap keys to match
	Android headset specification
Date: Fri, 23 Jan 2015 07:36:46 -0800
Message-ID: <CAOMFOmUg4BkAt67JKK_Q-i+XCkpzXhTdvURm+pkvWPNGzkWZhA@mail.gmail.com>
References: <1421970436-15862-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
 [209.85.213.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 7901526574E
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:27:40 +0100 (CET)
Received: by mail-ig0-f175.google.com with SMTP id hn18so3064850igb.2
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 09:27:39 -0800 (PST)
In-Reply-To: <1421970436-15862-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Jan 22, 2015 at 3:47 PM, Anatol Pomozov <anatol.pomozov@gmail.com>
wrote:

> ts3a227e datasheet says typical key resistance is
>   key1 50 Om
>

It is a misspelling in the commit message. "Om" should be replaced with
"Ohm" here and below.

Mark are you ok to fix it in your repo or do you want me to resend the
updated patch?


>   key2 135 Om
>   key3 240 Om
>   key4 470 Om
>
> The android headset specification expect buttons impedance:
>   A (MEDIA) 0-70 Om
>   D (VOICECOMMAND) 110-180 Om
>   B (VOLUMEUP) 210-290 Om
>   C (VOLUMEDOWN) 360-680 Om
>
> Thus key mapping should be
>   key1 - MEDIA
>   key2 - VOICECOMMAND
>   key3 - VOLUMEUP
>   key3 - VOLUMEDOWN
>
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>  sound/soc/codecs/ts3a227e.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
> index 9f2dced..54d431c 100644
> --- a/sound/soc/codecs/ts3a227e.c
> +++ b/sound/soc/codecs/ts3a227e.c
> @@ -221,9 +221,9 @@ int ts3a227e_enable_jack_detect(struct
> snd_soc_component *component,
>         struct ts3a227e *ts3a227e =
> snd_soc_component_get_drvdata(component);
>
>         snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> -       snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> -       snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> -       snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
> +       snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +       snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +       snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
>
>         ts3a227e->jack = jack;
>         ts3a227e_jack_report(ts3a227e);
> --
> 2.2.0.rc0.207.ga3a616c
>
>
