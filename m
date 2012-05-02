From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Wed, 2 May 2012 10:27:52 +0200
Message-ID: <4FA0F008.4020108@stericsson.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
	<20120427111523.GE18260@opensource.wolfsonmicro.com>
	<4F9E4CB6.7090606@stericsson.com>
	<20120430100452.GE3170@opensource.wolfsonmicro.com>
	<4FA0EBF7.2090903@stericsson.com>
	<20120502081709.GA4075@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog102.obsmtp.com (eu1sys200aog102.obsmtp.com
	[207.126.144.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 382AB243E3
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 10:28:13 +0200 (CEST)
In-Reply-To: <20120502081709.GA4075@opensource.wolfsonmicro.com>
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

On 05/02/2012 10:17 AM, Mark Brown wrote:

> On Wed, May 02, 2012 at 10:10:31AM +0200, Ola Lilja wrote:
>> On 04/30/2012 12:04 PM, Mark Brown wrote:
> 
>> > The code I'm referring to is this:
> 
>> > which is definitely compile time.  It's not the factoring stuff out,
>> > it's the way it's been done.  Library code like Tegra uses isn't a
>> > problem but this sort of arrangement does cause problems.
> 
>> OK, the thought with this was to be able to activate/deactivate the individual
>> codec-drivers since we have several separate codecs on our Ux500-platform (Note
>> that in this patch-set there is not patches for the other two codec-drivers).
>> Since we already knows at compile-time if any of these three codecs are present
>> we did it this ways, being able to add them separately in menuconfig.
> 
> This really isn't the idiom mainline is looking for, you should be able
> to build a kernel which will boot on multiple boards.  There's a reason
> why you don't see this sort of ifdef in other code...


I'm actually no fan of ifdefs, but let's say that the HDMI-driver is not
activated in menuconfig. This would lead to the point where the ASoC-driver
cannot be activated at all, although there is two codecs in the driver which
could have been used fine.
If this is the way forwards then I'll rewrite it this way.

> 
>> How could we solve this? All three codec-drivers has dependancies to other stuff
>> being activated in menuconfig.
> 
> Like I say, library style code like Tegra has is totally fine if there's
> stuff that can usefully be shared.
