From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] fix odd_ptr_err.cocci warnings
Date: Fri, 9 Aug 2019 16:14:35 +0300
Message-ID: <88ac4c79-5ce3-3f1a-5f6e-3928a30a1ef5@ti.com>
References: <alpine.DEB.2.21.1908091229140.2946@hadrien>
 <20190809123112.GC3963@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809123112.GC3963@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: kbuild-all@01.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/08/2019 15.31, Mark Brown wrote:
> On Fri, Aug 09, 2019 at 12:30:46PM +0200, Julia Lawall wrote:
> 
>> tree:   https://github.com/omap-audio/linux-audio peter/ti-linux-4.19.y/wip
>> head:   62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a
>> commit: 62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a [34/34] j721e new machine driver wip
>> :::::: branch date: 20 hours ago
>> :::::: commit date: 20 hours ago
>>
>>  j721e-evm.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- a/sound/soc/ti/j721e-evm.c
>> +++ b/sound/soc/ti/j721e-evm.c
>> @@ -283,7 +283,7 @@ static int j721e_get_clocks(struct platf
> 
> This file isn't upstream, it's only in the TI BSP.

Yes, it is not upstream, but the fix is valid.

Julia: is it possible to direct these notifications only to me from
https://github.com/omap-audio/linux-audio.git ?

It mostly carries TI BSP stuff and my various for upstream branches nowdays.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
