From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] pxa2xx-ac97: fix reset gpio mode setting
Date: Mon, 11 May 2009 14:08:31 +0300
Message-ID: <4A08072F.9020208@compulab.co.il>
References: <1242036698-29136-1-git-send-email-mike@compulab.co.il>
	<f17812d70905110351w6b5250fcqd19590afbc42011e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cathcart.site5.com (cathcart.site5.com [74.54.107.137])
	by alsa0.perex.cz (Postfix) with ESMTP id AE31224793
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 13:08:40 +0200 (CEST)
In-Reply-To: <f17812d70905110351w6b5250fcqd19590afbc42011e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, eric.miao@marvell.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org



Eric Miao wrote:
> On Mon, May 11, 2009 at 6:11 PM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> 
> Acked-by: Eric Miao <eric.miao@marvell.com>
> 
> Just curious, this didn't cause any issue in the past :)

It's 2.6.30 material so there's not much past :)

>> ---
>>  sound/arm/pxa2xx-ac97-lib.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
>> index a2c12d1..6fdca97 100644
>> --- a/sound/arm/pxa2xx-ac97-lib.c
>> +++ b/sound/arm/pxa2xx-ac97-lib.c
>> @@ -65,7 +65,7 @@ static void set_resetgpio_mode(int resetgpio_action)
>>                switch (resetgpio_action) {
>>                case RESETGPIO_NORMAL_ALTFUNC:
>>                        if (reset_gpio == 113)
>> -                               mode = 113 | GPIO_OUT | GPIO_DFLT_LOW;
>> +                               mode = 113 | GPIO_ALT_FN_2_OUT;
>>                        if (reset_gpio == 95)
>>                                mode = 95 | GPIO_ALT_FN_1_OUT;
>>                        break;
>> --
>> 1.5.6.4
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> 
> 
> 

-- 
Sincerely yours,
Mike.
