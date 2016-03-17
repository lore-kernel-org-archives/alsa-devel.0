From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: support different clock
 source for FLL function
Date: Thu, 17 Mar 2016 11:04:20 +0800
Message-ID: <56EA1EB4.9000409@nuvoton.com>
References: <1458014901-28049-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOMFOmXH-0cZ-VON3Ozttpaouuu+QWMTpdmB_fbELd+BhOUEaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B7EDE261564
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 04:04:29 +0100 (CET)
In-Reply-To: <CAOMFOmXH-0cZ-VON3Ozttpaouuu+QWMTpdmB_fbELd+BhOUEaw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, YHCHuang@nuvoton.com, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 3/17/2016 7:06 AM, Anatol Pomozov wrote:
> Hi
>
> On Mon, Mar 14, 2016 at 9:08 PM, John Hsu <KCHSU0@nuvoton.com> wrote:
>   
>> Extend FLL clock source selection. The source can be from MCLK, BCLK or FS.
>>
>> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
>> ---
>>  sound/soc/codecs/nau8825.c | 82 +++++++++++++++++++++++++++++++++-------------
>>  sound/soc/codecs/nau8825.h |  8 +++++
>>  2 files changed, 67 insertions(+), 23 deletions(-)
>>
>> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
>> index 1c87299..ac264ec 100644
>> --- a/sound/soc/codecs/nau8825.c
>> +++ b/sound/soc/codecs/nau8825.c
>> @@ -1053,6 +1053,37 @@ static int nau8825_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
>>         return 0;
>>  }
>>
>> +static int nau8825_mclk_prepare(struct nau8825 *nau8825, unsigned int freq)
>> +{
>> +       int ret = 0;
>> +
>> +       nau8825->mclk = devm_clk_get(nau8825->dev, "mclk");
>> +       if (IS_ERR(nau8825->mclk)) {
>>     
>
> Is it possible that clock system is not ready at this point and the
> method returns -EPROBE_DEFER? If so it matches IS_ERR() but not a real
> error and the nua8825 driver should backoff and wait a little before
> clocks are ready.
>
>   

The function is used when playback startup not in the driver initiation.
At this moment, we just skip mclk operation and let thing go on.
Should driver return the errorno to machine driver to handle it?

>> +               dev_info(nau8825->dev, "No 'mclk' clock found, assume MCLK is managed externally");
>> +               return 0;
>> +       }
>> +
>> +       if (!nau8825->mclk_freq) {
>> +               ret = clk_prepare_enable(nau8825->mclk);
>> +               if (ret) {
>> +                       dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
>> +                       return ret;
>> +               }
>> +       }
>> +
>>     
> .
>
>   
