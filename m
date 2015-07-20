From: anish kumar <yesanishhere@gmail.com>
Subject: Re: ASoC: Add max98925 codec driver
Date: Mon, 20 Jul 2015 08:59:39 -0700
Message-ID: <CABCoZhAXtBiX9qoZ2boaz78ZNhnuH97Jm4h+-0NEpde5gKpy9w@mail.gmail.com>
References: <20150317182843.GA30354@mwanda>
	<20150720110756.GI5422@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B782F261292
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 17:59:39 +0200 (CEST)
Received: by wgmn9 with SMTP id n9so134337103wgm.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 08:59:39 -0700 (PDT)
In-Reply-To: <20150720110756.GI5422@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 20, 2015 at 4:07 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, Mar 17, 2015 at 09:28:43PM +0300, Dan Carpenter wrote:
>> Hello Anish Kumar,
>>
>> The patch 1ff2765182d1: "ASoC: Add max98925 codec driver" from Mar 9,
>> 2015, leads to the following static checker warning:
>>
>>       sound/soc/codecs/max98925.c:274 max98925_rate_value()
>>       error: buffer overflow 'rate_table' 9 <= 9
>>
>> sound/soc/codecs/max98925.c
>>    259  static inline int max98925_rate_value(struct snd_soc_codec *codec,
>>    260                  int rate, int clock, int *value, int *n, int *m)
>>    261  {
>>    262          int ret = -EINVAL;
>>    263          int i;
>>    264
>>    265          for (i = 0; i < ARRAY_SIZE(rate_table); i++) {
>>    266                  if (rate_table[i].rate >= rate) {
>>    267                          *value = rate_table[i].sr;
>>    268                          *n = rate_table[i].divisors[clock][0];
>>    269                          *m = rate_table[i].divisors[clock][1];
>>    270                          ret = 0;
>>    271                          break;
>>    272                  }
>>    273          }
>>    274          dev_dbg(codec->dev, "%s: sample rate is %d, returning %d\n",
>>    275                                  __func__, rate_table[i].rate, *value);
>>                                                   ^^^^^^^^^^^^^^^^^^
>> If we don't break then we're off by one.
>
> I'm going to just delete this because these warnings are annoying and
> debug printks are pointless and if you cared then you would have fixed
> it by now.

Please go ahead.
>
> regards,
> dan carpenter
>
