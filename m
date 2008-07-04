From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: ASoC: Au12x0/Au1550 PSC Audio support.
Date: Fri, 04 Jul 2008 18:24:57 +0200
Message-ID: <486E4ED9.4050106@roarinelk.homelinux.net>
References: <20080703073309.GA24116@roarinelk.homelinux.net>	<1215077359.4882.115.camel@localhost.localdomain>	<20080703095344.GA24177@roarinelk.homelinux.net>	<1215078947.4882.117.camel@localhost.localdomain>	<20080703100925.GA25364@roarinelk.homelinux.net>
	<s5h1w29lm20.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E2871037F2
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 18:24:56 +0200 (CEST)
In-Reply-To: <s5h1w29lm20.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Takashi Iwai wrote:
> At Thu, 3 Jul 2008 12:09:25 +0200,
> Manuel Lauss wrote:
>> On Thu, Jul 03, 2008 at 10:55:47AM +0100, Liam Girdwood wrote:
>>> On Thu, 2008-07-03 at 11:53 +0200, Manuel Lauss wrote:
>>>> On Thu, Jul 03, 2008 at 10:29:19AM +0100, Liam Girdwood wrote:
>>>>> Btw, any plans to fix or remove some of the 'Fixmes' in your other ASoC
>>>>> code. We could upstream the Au1x000 stuff after a little cleanup and
>>>>> resolution of the fixmes.
>>>> I've updated the code considerably since the last year.  It's still ASoC v1,
>>>> and lots of the FIXMEs in the ac97 part won't disappear until it's moved to
>>>> ASoC v2 (I hope, didn't investigate).
>>>>
>>>> If you're interested I can send you a patch (against current linus' HEAD)
>>>> with the newest, most awesome au1xxx psc asoc code ;-)
>>>>
>>> Yes please.
>> Here you go, apply on top of linus' head + the ac97 PM patch.
>>
>> --- 
>>
>> From: Manuel Lauss <mano@roarinelk.homelinux.net>
>>
>> Audio for Au12x0/Au1550 PSCs in AC97 and I2S mode, for ASoC v1 framework.
>>
>> - DBDMA, AC97 and I2S drivers
>> - sample AC97 machine code (Db1200)
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> 
> Shall I apply this one?  At a quick glance, the patch looks OK.

I certainly have no objections, but I intended to wait for ASoCv2 to hit
mainline, convert the drivers to it, then (re)submit. There's still a lot
to be done IMO (it has never been tested with preemption, i2s bitclk master
mode is untested, ...)

Best regards,
	Manuel Lauss
