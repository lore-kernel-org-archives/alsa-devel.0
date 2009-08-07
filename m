From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Fixed module builds of soc/fsl/*.c
Date: Fri, 7 Aug 2009 11:07:17 -0400
Message-ID: <9e4733910908070807x2c1ef0det834fb60ad8b38f73@mail.gmail.com>
References: <s5heirny98v.wl%tiwai@suse.de> <20090807144540.GH639@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 490F31038D8
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 17:07:19 +0200 (CEST)
Received: by ywh11 with SMTP id 11so2279317ywh.16
	for <alsa-devel@alsa-project.org>; Fri, 07 Aug 2009 08:07:18 -0700 (PDT)
In-Reply-To: <20090807144540.GH639@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 7, 2009 at 10:45 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 07, 2009 at 04:44:00PM +0200, Takashi Iwai wrote:
>> JFYI, I merged the patch below now.
>
> Thanks. =A0CCing in Jon, who wrote the drivers, for info.

Looks fine. We always build them into the kernel. I forgot to check
the standalone build.


>> From afc5e65245255a268ab22a20477ed2c9f2cdfcd3 Mon Sep 17 00:00:00 2001
>> From: Takashi Iwai <tiwai@suse.de>
>> Date: Fri, 7 Aug 2009 16:33:53 +0200
>> Subject: ASoC: Add missing DRV_NAME definitions for fsl/* drivers
>>
>> Module builds are broken due to missing DRV_NAME for
>> efika-audio-fabric and pcm030-audio-fabric.
>>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>> =A0sound/soc/fsl/efika-audio-fabric.c =A0| =A0 =A02 ++
>> =A0sound/soc/fsl/pcm030-audio-fabric.c | =A0 =A02 ++
>> =A02 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-au=
dio-fabric.c
>> index 85b0e75..3326e2a 100644
>> --- a/sound/soc/fsl/efika-audio-fabric.c
>> +++ b/sound/soc/fsl/efika-audio-fabric.c
>> @@ -30,6 +30,8 @@
>> =A0#include "mpc5200_psc_ac97.h"
>> =A0#include "../codecs/stac9766.h"
>>
>> +#define DRV_NAME "efika-audio-fabric"
>> +
>> =A0static struct snd_soc_device device;
>> =A0static struct snd_soc_card card;
>>
>> diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-=
audio-fabric.c
>> index 8766f7a..b928ef7 100644
>> --- a/sound/soc/fsl/pcm030-audio-fabric.c
>> +++ b/sound/soc/fsl/pcm030-audio-fabric.c
>> @@ -30,6 +30,8 @@
>> =A0#include "mpc5200_psc_ac97.h"
>> =A0#include "../codecs/wm9712.h"
>>
>> +#define DRV_NAME "pcm030-audio-fabric"
>> +
>> =A0static struct snd_soc_device device;
>> =A0static struct snd_soc_card card;
>>
>> --
>> 1.6.3.3
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
> --
> "You grabbed my hand and we fell into it, like a daydream - or a fever."
>



-- =

Jon Smirl
jonsmirl@gmail.com
