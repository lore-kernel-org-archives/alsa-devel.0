From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 6/9] ARM: DaVinci: ASoC: Adds McASP clock
	support for TI DM646X processor
Date: Thu, 19 Mar 2009 10:38:03 -0700
Message-ID: <87ljr1l8g4.fsf@deeprootsystems.com>
References: <FF55437E1F14DA4BAEB721A458B67017069809B098@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f159.google.com (mail-gx0-f159.google.com
	[209.85.217.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 9298624334
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 18:38:08 +0100 (CET)
Received: by gxk3 with SMTP id 3so2308030gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 10:38:07 -0700 (PDT)
In-Reply-To: <FF55437E1F14DA4BAEB721A458B67017069809B098@dbde02.ent.ti.com>
	(Naresh Medisetty's message of "Wed\,
	18 Mar 2009 17\:41\:51 +0530")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Medisetty, Naresh" <naresh@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Mark Brown <broonie@sirena.org.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

"Medisetty, Naresh" <naresh@ti.com> writes:

>> On Mon, Mar 16, 2009 at 08:05:25AM -0400, Naresh Medisetty wrote:
>>
>> > +     CLK("soc-audio.0", NULL, &mcasp0_clk),
>> > +     CLK("soc-audio.1", NULL, &mcasp1_clk),
>>
>> Assuming this is a shorthand for defining two platform devices for two
>> ASoC cards I'd suggest that you instead move towards registering clocks
>> for the DAIs and probing them as platform devices - take a look at how
>> the PXA AC97 driver now does this for an example.  The soc-audio device
>> will hopefully get removed at some point and you can't guarantee that
>> the user won't want to put the two DAIs into a single sound card.
>
> Yes, This is a shorthand for defining two platform devices for two
> ASoC cards.
>

Naresh,

When you move to platform device/data way of handling the clocks
(which I would prefer as well) then these clock definitions can 
use the physical clock name:


    CLK(NULL, "mcasp0" &mcasp0_clk),
    CLK(NULL, "mcasp1", &mcasp1_clk),

The platform code can do a clk_get(<physcial name>) and pass that
clk in with the platform data.

Kevin
