From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
Date: Fri, 3 Aug 2018 11:41:39 -0500
Message-ID: <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <30613.1533313609@turing-police.cc.vt.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: valdis.kletnieks@vt.edu
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 08/03/2018 11:26 AM, valdis.kletnieks@vt.edu wrote:
> On Wed, 01 Aug 2018 14:56:16 -0500, "Gustavo A. R. Silva" said:
> 
>> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
>> index 7fdfdf3..62f8c5b 100644
>> --- a/sound/soc/codecs/wm8994.c
>> +++ b/sound/soc/codecs/wm8994.c
>> @@ -2432,6 +2432,7 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
>>  			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_2,
>>  					    WM8994_OPCLK_ENA, 0);
>>  		}
>> +		/* fall through */
>>
>>  	default:
>>  		return -EINVAL;
> 
> Wait, what? This looks like the sort of bug -Wimplicit-fallthrough is supposed
> to catch.  Unless for 'case WM8994_SYSCLK_OPCLK:' we actually do want to do a
> whole bunch of snd_soc_component_update_bits() calls and then return -EINVAL
> whether or not that case succeeded?
> 
> 

Yeah, it seems like a bug. Can someone confirm this?

Notice that this code has been there since 2010.

Thanks Valdis for pointing this out.
--
Gustavo
