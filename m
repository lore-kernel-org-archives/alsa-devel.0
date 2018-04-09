From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 1/2] ASoC: AMD: Support headset button on
	Stoney DA7219
Date: Mon, 9 Apr 2018 14:25:00 +0530
Message-ID: <eab9ed82-84a2-2c7b-8f46-e4393e54b6c9@amd.com>
References: <1522404297-7555-1-git-send-email-akshu.agrawal@amd.com>
 <CAGS+omDBfWwAS-ztveUqg-iCVEQVd8mODA-cQzRi=q62GaMb9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0065.outbound.protection.outlook.com [104.47.33.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A7B1266C1C
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 10:55:50 +0200 (CEST)
In-Reply-To: <CAGS+omDBfWwAS-ztveUqg-iCVEQVd8mODA-cQzRi=q62GaMb9Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: alsa-devel@alsa-project.org, Jimmy Cheng-Yi Chiang <cychiang@google.com>, tiwai@suse.de, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org



On 4/5/2018 11:34 PM, Daniel Kurtz wrote:
> Hi Akshu,
> 
> On Fri, Mar 30, 2018 at 4:05 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
> 
>> Adds headset button support.
> 
>> TEST=Tested Volume UP/Down functionality
> 
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>>     sound/soc/amd/acp-da7219-max98357a.c | 8 ++++++++
>>     1 file changed, 8 insertions(+)
> 
>> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
> b/sound/soc/amd/acp-da7219-max98357a.c
>> index b205c78..d9491e1 100644
>> --- a/sound/soc/amd/acp-da7219-max98357a.c
>> +++ b/sound/soc/amd/acp-da7219-max98357a.c
>> @@ -33,6 +33,7 @@
>>     #include <linux/gpio.h>
>>     #include <linux/module.h>
>>     #include <linux/i2c.h>
>> +#include <linux/input.h>
>>     #include <linux/acpi.h>
> 
>>     #include "../codecs/da7219.h"
>> @@ -51,6 +52,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
> *rtd)
>>            struct snd_soc_card *card = rtd->card;
>>            struct snd_soc_dai *codec_dai = rtd->codec_dai;
>>            struct snd_soc_component *component = codec_dai->component;
>> +       struct snd_soc_jack *jack;
> 
>>            dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
> 
>> @@ -80,6 +82,12 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
> *rtd)
>>                    return ret;
>>            }
> 
>> +       jack = &cz_jack;
>> +       snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> 
> I think this should be KEY_PLAYPAUSE.
> 
Yes, re-spinning the patch with the change.

> Thanks!
> -Dan
> 
