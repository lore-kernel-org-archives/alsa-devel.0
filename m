From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: Fix typos in comment
Date: Wed, 27 Sep 2017 22:47:27 +0800
Message-ID: <CAErzpmu5wRiMEt0nA7Ad1n6Mc08ETFa-qwd2U9Hj44aq4zpwvA@mail.gmail.com>
References: <1506522901-10552-1-git-send-email-dolinux.peng@gmail.com> <c14e9fe8-a98c-e875-84ad-fe6e9becb5ae@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c14e9fe8-a98c-e875-84ad-fe6e9becb5ae@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks, i see.

On Wed, Sep 27, 2017 at 10:39 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/27/2017 04:35 PM, Peng Donglin wrote:
>> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
>> ---
>>  sound/soc/soc-dapm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>> index dcef67a..0867eaa 100644
>> --- a/sound/soc/soc-dapm.c
>> +++ b/sound/soc/soc-dapm.c
>> @@ -4167,7 +4167,7 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
>>   * @dapm: DAPM context
>>   * @pin: pin name
>>   *
>> - * Enables input/output pin and its parents or children widgets iff there is
>> + * Enables input/output pin and its parents or children widgets if there is
>
> https://en.wikipedia.org/wiki/If_and_only_if
