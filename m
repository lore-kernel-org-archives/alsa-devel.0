From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/8] ASoC: alc5632: Use params_width()
 rather than memory format
Date: Thu, 09 Jan 2014 11:16:48 +0100
Message-ID: <52CE7710.7080207@metafoo.de>
References: <1389210723-16535-1-git-send-email-broonie@kernel.org>
 <1389210723-16535-2-git-send-email-broonie@kernel.org>
 <CALq1K=Kss-NUYB-mmhOjCbxSjhaRO62GpnY95rFMzruo35i=fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id DB107265281
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 11:16:21 +0100 (CET)
In-Reply-To: <CALq1K=Kss-NUYB-mmhOjCbxSjhaRO62GpnY95rFMzruo35i=fw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 01/09/2014 05:55 AM, Leon Romanovsky wrote:
> Hi Mark,
> 
> On Wed, Jan 8, 2014 at 9:51 PM, Mark Brown <broonie@kernel.org> wrote:
>> From: Mark Brown <broonie@linaro.org>
>>
>> Signed-off-by: Mark Brown <broonie@linaro.org>
>> ---
>>  sound/soc/codecs/alc5632.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
>> index 19e9f222d09c..fb001c56cf8d 100644
>> --- a/sound/soc/codecs/alc5632.c
>> +++ b/sound/soc/codecs/alc5632.c
>> @@ -869,14 +869,14 @@ static int alc5632_pcm_hw_params(struct snd_pcm_substream *substream,
>>         iface &= ~ALC5632_DAI_I2S_DL_MASK;
>>
>>         /* bit size */
>> -       switch (params_format(params)) {
>> -       case SNDRV_PCM_FORMAT_S16_LE:
>> +       switch (params_width(params)) {
>> +       case 16:
> May be the better way will be to use define here and not hard coded value?

like #define SIXTEEN 16? ;)
