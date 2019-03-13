From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next v2 1/2] ASoC: rsnd: src: Avoid a potential
 deadlock
Date: Wed, 13 Mar 2019 20:55:57 +0900
Message-ID: <8cd7f718-bfb2-15c8-823d-88458b385377@mentor.com>
References: <20190307061554.26486-1-jiada_wang@mentor.com>
 <20190307061554.26486-2-jiada_wang@mentor.com>
 <CAMuHMdU+1Ntz6uvk-VYsSdWJgBfzHu99SztqyfLX7z2FRxPdNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU+1Ntz6uvk-VYsSdWJgBfzHu99SztqyfLX7z2FRxPdNg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Geert

On 2019/03/12 18:15, Geert Uytterhoeven wrote:
> Hi Jiada, Fabrizio,
> 
> On Thu, Mar 7, 2019 at 7:17 AM Jiada Wang <jiada_wang@mentor.com> wrote:
>> lockdep warns us that priv->lock and k->k_lock can cause a
>> deadlock when after acquire of k->k_lock, process is interrupted
>> by src, while in another routine of src .init, k->k_lock is
>> acquired with priv->lock held.
>>
>> This patch avoids a potential deadlock by not calling soc_device_match()
>> in SRC .init callback, instead it adds new soc fields in priv->flags to
>> differentiate SoCs.
>>
>> Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   sound/soc/sh/rcar/core.c | 2 ++
>>   sound/soc/sh/rcar/rsnd.h | 5 +++++
>>   sound/soc/sh/rcar/src.c  | 9 +--------
>>   3 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
>> index 022996d2db13..4fe83e611c01 100644
>> --- a/sound/soc/sh/rcar/core.c
>> +++ b/sound/soc/sh/rcar/core.c
>> @@ -110,6 +110,8 @@ static const struct of_device_id rsnd_of_match[] = {
>>          { .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
>>          { .compatible = "renesas,rcar_sound-gen2", .data = (void *)RSND_GEN2 },
>>          { .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN3 },
>> +       /* Special Handling */
>> +       { .compatible = "renesas,rcar_sound-r8a77990", .data = (void *)(RSND_GEN3 | RSND_SOC_E) },
> 
> I guess we need an entry for RZ/G2E, too?
> 
Sorry, I don't have user manual for RZ/G2E,
if you can let me know where to find RZ/G2E's user manual,
I can add entry for these SoCs

Thanks,
Jiada
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
