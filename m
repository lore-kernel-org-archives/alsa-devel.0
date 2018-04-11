From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH v2,
 1/2] ASoC: AMD: Support headset button on Stoney DA7219
Date: Wed, 11 Apr 2018 15:34:18 +0530
Message-ID: <d8373a76-8773-5dd8-9087-c4ae3577c124@amd.com>
References: <1523265596-8837-1-git-send-email-akshu.agrawal@amd.com>
 <CAGS+omDeOT25uMXzBOcc0pA4N+js1=sCGSv8MRJPf6AizwDddw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0042.outbound.protection.outlook.com [104.47.34.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EF822673D8
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 12:04:49 +0200 (CEST)
In-Reply-To: <CAGS+omDeOT25uMXzBOcc0pA4N+js1=sCGSv8MRJPf6AizwDddw@mail.gmail.com>
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
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 4/9/2018 11:02 PM, Daniel Kurtz wrote:
> On Mon, Apr 9, 2018 at 3:20 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
> 
>> Adds headset button support.
> 
>> TEST=Tested Volume UP/Down, Play/Pause functionality
> 
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> 
>> ---
>> v2: Changed KEY_MEDIA to KEY_PLAYPAUSE
> 
>>    sound/soc/amd/acp-da7219-max98357a.c | 8 ++++++++
>>    1 file changed, 8 insertions(+)
> 
>> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
> b/sound/soc/amd/acp-da7219-max98357a.c
>> index b205c78..1012a80 100644
>> --- a/sound/soc/amd/acp-da7219-max98357a.c
>> +++ b/sound/soc/amd/acp-da7219-max98357a.c
>> @@ -33,6 +33,7 @@
>>    #include <linux/gpio.h>
>>    #include <linux/module.h>
>>    #include <linux/i2c.h>
>> +#include <linux/input.h>
>>    #include <linux/acpi.h>
> 
>>    #include "../codecs/da7219.h"
>> @@ -51,6 +52,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
> *rtd)
>>           struct snd_soc_card *card = rtd->card;
>>           struct snd_soc_dai *codec_dai = rtd->codec_dai;
>>           struct snd_soc_component *component = codec_dai->component;
>> +       struct snd_soc_jack *jack;
> 
>>           dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
> 
>> @@ -80,6 +82,12 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
> *rtd)
>>                   return ret;
>>           }
> 
>> +       jack = &cz_jack;
> 
> Hmm, this seems a bit unnecessary.  For all of these, can you just do:
> 
>     snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> 
Accepted.

>> +       snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
>> +       snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
>> +       snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
>> +       snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
>> +
>>           da7219_aad_jack_det(component, &cz_jack);
> 
>>           return 0;
>> --
>> 1.9.1

Thanks,
Akshu
