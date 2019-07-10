From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] sound: soc: codecs: mt6358: change return type of mt6358_codec_init_reg
Date: Wed, 10 Jul 2019 13:24:45 +0800
Message-ID: <CA+Px+wVMn-wZ_aoAV2OMEg4zE7aoYG__my2EJM_PP5ghaXjoFw@mail.gmail.com>
References: <20190709182543.GA6611@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709182543.GA6611@hari-Inspiron-1545>
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Shunli Wang <shunli.wang@mediatek.com>, ALSA development <alsa-devel@alsa-project.org>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 10, 2019 at 2:25 AM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> As mt6358_codec_init_reg function always returns 0 , change return type
> from int to void.
>
> fixes below issue reported by coccicheck
> sound/soc/codecs/mt6358.c:2260:5-8: Unneeded variable: "ret". Return "0"
> on line 2289
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Acked-by: Tzung-Bi Shih <tzungbi@google.com>

Thanks for cleaning this up.
