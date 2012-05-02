From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Wed, 2 May 2012 10:10:31 +0200
Message-ID: <4FA0EBF7.2090903@stericsson.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
	<20120427111523.GE18260@opensource.wolfsonmicro.com>
	<4F9E4CB6.7090606@stericsson.com>
	<20120430100452.GE3170@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog119.obsmtp.com (eu1sys200aog119.obsmtp.com
	[207.126.144.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 67D42243D2
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 10:10:39 +0200 (CEST)
In-Reply-To: <20120430100452.GE3170@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 04/30/2012 12:04 PM, Mark Brown wrote:

> On Mon, Apr 30, 2012 at 10:26:30AM +0200, Ola Lilja wrote:
>> On 04/27/2012 01:15 PM, Mark Brown wrote:
> 
>> > No, I really don't see any value at all in it.  The machine drivers
>> > aren't actually sharing anything visible and the effect of what you're
>> > doing is to make the selection of machine a compile time one instead of
>> > a runtime one.
> 
>> No, that is a misunderstanding. We are just dividing the machine-driver file
>> into one main-file and then calling functions from other ones. It is not
>> affecting the framework in any way. We just want to divide the code in a way we
>> find useful. One file calling functions from another one. I don't see how that
>> can be a problem.
> 
> The code I'm referring to is this:
> 
> | +#ifdef CONFIG_SND_SOC_UX500_AB8500
> | +#include <ux500_ab8500.h>
> | +#endif
> | +
> | +/* Define the whole U8500 soundcard, linking platform to the codec-drivers  */
> | +struct snd_soc_dai_link u8500_dai_links[] = {
> | +       #ifdef CONFIG_SND_SOC_UX500_AB8500
> | +       {
> | +               .name = "ab8500_0",
> | +               .stream_name = "ab8500_0",
> 
> which is definitely compile time.  It's not the factoring stuff out,
> it's the way it's been done.  Library code like Tegra uses isn't a
> problem but this sort of arrangement does cause problems.


OK, the thought with this was to be able to activate/deactivate the individual
codec-drivers since we have several separate codecs on our Ux500-platform (Note
that in this patch-set there is not patches for the other two codec-drivers).
Since we already knows at compile-time if any of these three codecs are present
we did it this ways, being able to add them separately in menuconfig.
How could we solve this? All three codec-drivers has dependancies to other stuff
being activated in menuconfig.
