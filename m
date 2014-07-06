From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v5 2/5] ASoC: pcm: Add support for DAI
	multicodec
Date: Sun, 06 Jul 2014 22:23:10 +0200
Message-ID: <53B9B02E.1050203@baylibre.com>
References: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
 <1404490075-24997-3-git-send-email-bcousson@baylibre.com>
 <53B95AB0.8070307@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 by alsa0.perex.cz (Postfix) with ESMTP id CDDEB265456
 for <alsa-devel@alsa-project.org>; Sun,  6 Jul 2014 22:23:32 +0200 (CEST)
Received: by mail-we0-f178.google.com with SMTP id x48so3515589wes.37
 for <alsa-devel@alsa-project.org>; Sun, 06 Jul 2014 13:23:32 -0700 (PDT)
In-Reply-To: <53B95AB0.8070307@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, broonie@kernel.org, lgirdwood@gmail.com
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/07/2014 16:18, Lars-Peter Clausen wrote:
> On 07/04/2014 06:07 PM, Benoit Cousson wrote:
> [...]
>>    */
>>   bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime
>> *rtd)
>>   {
>> +    int i;
>> +    bool ignore =3D true;
>> +
>>       if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
>>           return true;
>>
>> -    return rtd->cpu_dai->component->ignore_pmdown_time &&
>> -            rtd->codec_dai->component->ignore_pmdown_time;
>> +    for (i =3D 0; (i < rtd->num_codecs) && !ignore; i++)
>
> As you said last time this should be '&& ignore'. Or maybe just drop the
> check altogether.

Oops, I forgot to fix it before posting :-(

I guess I'll drop it, it is a little bit overkill.

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
