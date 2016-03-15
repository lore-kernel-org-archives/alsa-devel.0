From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: fix interrupt fails and
 unstable after resume
Date: Tue, 15 Mar 2016 15:53:03 +0800
Message-ID: <56E7BF5F.5000103@nuvoton.com>
References: <1456686105-6885-1-git-send-email-KCHSU0@nuvoton.com>
 <20160301032623.GH18327@sirena.org.uk> <56E1105E.8010604@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 981A8261298
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 08:53:08 +0100 (CET)
In-Reply-To: <56E1105E.8010604@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 3/10/2016 2:12 PM, John Hsu wrote:
>>>      regcache_cache_only(nau8825->regmap, false);
>>> -    regcache_sync(nau8825->regmap);
>>> -    enable_irq(client->irq);
>>> +    enable_irq(nau8825->irq);
>>>     
>>
>> We're removing the register cache sync here but I don't see us adding it
>> anywhere else.
>>   
> A part of suspend and resume action moves to set bias function, 
> nau8825_set_bias_level.
> We make register cache dirty in bias off; and make register cache sync 
> after resume in bias standby.
>
Just confirm it. Could you accept the explain about the register cache sync?
We need to change it or not? Very appreciate.
