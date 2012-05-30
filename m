From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 4/5] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 30 May 2012 17:14:43 +0200
Message-ID: <4FC63963.50001@stericsson.com>
References: <1337865998-26150-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120530131421.GK9947@opensource.wolfsonmicro.com>
	<4FC6257F.4080905@stericsson.com>
	<20120530150938.GM9947@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog120.obsmtp.com (eu1sys200aog120.obsmtp.com
	[207.126.144.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 917F7104348
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 17:14:51 +0200 (CEST)
In-Reply-To: <20120530150938.GM9947@opensource.wolfsonmicro.com>
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

On 05/30/2012 05:09 PM, Mark Brown wrote:

> On Wed, May 30, 2012 at 03:49:51PM +0200, Ola Lilja wrote:
>> On 05/30/2012 03:14 PM, Mark Brown wrote:
> 
>> > What problems are you finding when you try to use the debug
>> > infrastructure in both the regulator API and DAPM to discover the state
>> > of the regulators?
> 
>> My vision here is that in a simple way, in one place, activate all
>> debug-information we need in our driver, prefixed with our dev_xxx. This is very
>> valuable for us when debugging, especially when a customer is told to activate
>> debug-information that we can use to debug.
>> I removed the menuconfig flag on your request, and then we lost the information
>> for regulators and clocks when I implemented the clock/regulator-widgets. I'm
>> just trying to keep some aspects of what we want to have but still conforming
>> what you want to see on mainline.
> 
> All the existing diagnostics use dev_name() too...  just turning on the
> standard logging ought to give you exactly the same stuff, indeed if
> debugfs is on there should be no need to even manually enable equivalent
> debugging.
> 
>> >> +int ab8500_audio_init_audioblock(struct snd_soc_codec *codec)
> 
>> > static.  Lots of other functions in the rest of the driver have the same
>> > issue.
> 
>> This one should be static, yes. Cannot find any other non-static functions in
>> the codec-driver that is missing static.
> 
> IIRC the function immediately below was one.


Note that I wrote "...that is missing static". The one you previously mentioned
is indeed a function that we have moved from being called from the machine, but
this one (and one other) is still functions that we need to call from the
machine (or if you have a suggestion to how we could get rid of this connection).
Note that we have pretty much eliminated most of the extra functions we had
between machine and codec.

> 
>> >> +#define PRE_PMU_POST_PMD			(SND_SOC_DAPM_PRE_PMU | \
>> >> +						SND_SOC_DAPM_POST_PMD)
> 
>> > You shouldn't define stuff like this in your driver!
> 
>> This was mainly to avoid impossible situations trying to comply with the
>> 80-char-width.
> 
> Adding things like this if they're useful are fine but they shouldn't be
> driver specific things.  There is a SND_SOC_DAPM_PRE_POST_PMD already
> though.
