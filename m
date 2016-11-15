From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/19] ASoC: uda1380: Convert to
 module_i2c_driver()
Date: Tue, 15 Nov 2016 13:08:45 +0100
Message-ID: <9078ee4b-d6c6-138d-7bb1-4752dfc6ccfe@metafoo.de>
References: <871syd9vq9.wl%kuninori.morimoto.gx@renesas.com>
 <87zil18h4p.wl%kuninori.morimoto.gx@renesas.com>
 <s5hh979clgu.wl-tiwai@suse.de>
 <87zil16y9l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B6D3E267097
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 13:08:49 +0100 (CET)
In-Reply-To: <87zil16y9l.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 11/15/2016 07:42 AM, Kuninori Morimoto wrote:
> 
> HI Takashi-san
> 
>>>  config SND_SOC_UDA1380
>>>          tristate
>>> +	depends on I2C
>>
>> Note that this doesn't help when it's reverse-selected by others.
>>
>> The same is true for an item with a prompt, but the item like this
>> without prompt is supposed to be reverse-selected only, so adding
>> "depends on" there is merely a placeholder.
>>
>> That being said, currently the only way to guarantee the dependency by
>> a reverse-selection is to put the depends-on to the selecting item,
>> not to the selected item.
>>
>> It's a generic problem of the kbuild implementation, and people know
>> of it over a decade.  It was discussed in the previous Plumbers
>> conference, and developers agreed to improve the situation, so it may
>> be a bit better in near future.
> 
> Hmm.. indeed thanks for your feedback.
> So, should I send v2 patch ? or as-is is OK at this point ?

While it doesn't prevent the symbol from being selected this will generate a
warning if the symbol is selected while its dependencies are not met. So I'd
say it is still useful to have.
