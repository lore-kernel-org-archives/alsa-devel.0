From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [GIT PULL] ASoC fixes for v4.0
Date: Wed, 18 Mar 2015 10:17:12 +0100
Message-ID: <55094298.8020306@metafoo.de>
References: <20150317113635.GB28806@sirena.org.uk>
 <s5hh9tin02o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-134.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DF06260496
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 10:17:00 +0100 (CET)
In-Reply-To: <s5hh9tin02o.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Gabriel Dobato <dobatog@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/18/2015 10:09 AM, Takashi Iwai wrote:
> At Tue, 17 Mar 2015 11:36:35 +0000,
> Mark Brown wrote:
>>
>> Lars-Peter Clausen (4):
>>        ASoC: ak4671: Fix control-less DAPM routes
>>        ASoC: da732x: Fix control-less DAPM routes
>>        ASoC: sn95031: Fix control-less DAPM routes
>
> BTW, there are still "NULL" routes.
>
> % git grep '"NULL"' sound/soc/
> sound/soc/codecs/tlv320aic23.c: {"Line Input", "NULL", "LLINEIN"},
> sound/soc/codecs/tlv320aic23.c: {"Line Input", "NULL", "RLINEIN"},
> sound/soc/codecs/tlv320aic23.c: {"Mic Input", "NULL", "MICIN"},

Gabriel send a patch for this a while ago, which was actually the reason why 
I started to look for more of them. Looks like the patch had some formality 
issues and wasn't applied yet.

- Lars
