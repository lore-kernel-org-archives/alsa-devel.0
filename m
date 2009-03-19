From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 6/9] ARM: DaVinci: ASoC: Adds McASP clock
	support for TI DM646X processor
Date: Thu, 19 Mar 2009 14:14:06 -0700
Message-ID: <87prgdnrkx.fsf@deeprootsystems.com>
References: <FF55437E1F14DA4BAEB721A458B67017069809B098@dbde02.ent.ti.com>
	<87ljr1l8g4.fsf@deeprootsystems.com>
	<20090319190942.GA8966@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FAD32434D
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 22:14:10 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so811351wfg.23
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 14:14:09 -0700 (PDT)
In-Reply-To: <20090319190942.GA8966@sirena.org.uk> (Mark Brown's message of
	"Thu\, 19 Mar 2009 19\:09\:43 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Medisetty, Naresh" <naresh@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Thu, Mar 19, 2009 at 10:38:03AM -0700, Kevin Hilman wrote:
>
>>     CLK(NULL, "mcasp0" &mcasp0_clk),
>>     CLK(NULL, "mcasp1", &mcasp1_clk),
>
> Exactly.
>
>> The platform code can do a clk_get(<physcial name>) and pass that
>> clk in with the platform data.
>
> There should be no need to do this - the McASP DAI driver can just be a
> regular platform device, probe as normal and register the DAI with the
> ASoC core once it has done so.  This is, in fact, the preferred method
> for doing this though support for htis is recent so only one CPU DAI
> driver does it so far.

Sure, but what I don't want in that DAI driver is conditional code
because of different clock names on different chips.  For example,
some devices may only have one clk, so the hardware name is actualy
"mcasp" instead of "mcasp0" etc.

IOW, there will always be conditional code, I would prefer it not to
be in sound/soc/* and rather see it in the chip/board specific init
code.

Kevin
