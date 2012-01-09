From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] ASoC: jz4740: Convert qi_lb60 to use
	snd_soc_register_card()
Date: Mon, 09 Jan 2012 21:59:50 +0100
Message-ID: <4F0B5546.5050009@metafoo.de>
References: <1325820610.10011.1.camel@phoenix>
	<CAF+7xW=x4mvod17gJXjGdTXA81k4ZoGmt3jC2yFb_KoR6eCcVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A66A24466
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 22:00:56 +0100 (CET)
In-Reply-To: <CAF+7xW=x4mvod17gJXjGdTXA81k4ZoGmt3jC2yFb_KoR6eCcVg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: axel.lin@gmail.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/09/2012 03:12 PM, Axel Lin wrote:
> 2012/1/6 Axel Lin <axel.lin@gmail.com>:
>> Use snd_soc_register_card() instead of creating a "soc-audio" platform device.
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> ---
>> v2: Fix a typo in v1.
>> v3: Free the card before the GPIOs since the card uses the GPIOs
> 
> Hi Lars,
> Any chance to test this patch if you think the patch is ok?
> 
Hi Axel,

The patch looks fine to me, though I didn't had time yet to test it. I'll do
this during next weekend.

Thanks
- Lars
