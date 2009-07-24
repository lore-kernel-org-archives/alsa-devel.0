From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: ASoC: PATCH: mpc5200_psc_ac97 (was Re: AC97 on
	pcm030 board with WM9712 codec)
Date: Fri, 24 Jul 2009 10:22:24 -0400
Message-ID: <9e4733910907240722v7ac2529bqed278cd72c3ec3e1@mail.gmail.com>
References: <1248132551.6532.267.camel@riker>
	<20090721090104.GA12667@rakim.wolfsonmicro.main>
	<1248207844.27542.16.camel@riker>
	<20090721230836.GC3472@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f177.google.com (mail-yx0-f177.google.com
	[209.85.210.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 02112103AA4
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 16:22:25 +0200 (CEST)
Received: by yxe7 with SMTP id 7so2866475yxe.16
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2009 07:22:25 -0700 (PDT)
In-Reply-To: <20090721230836.GC3472@opensource.wolfsonmicro.com>
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
Cc: John Bonesio <bones@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Schumann <E.Schumann@phytec.de>, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 21, 2009 at 7:08 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 21, 2009 at 01:24:04PM -0700, John Bonesio wrote:
>
>> Reset was failing with the original udelay(50) between the code in
>> psc_ac97_cold_reset() and the call to psc_ac97_warm_reset(). Through testing
>> it was found that a delay of 1ms was necessary for the cold_reset code to
>> consistently complete successfully.

Something is funky between the mpc5200 and the wm9712 when doing a
cold reset. Increasing this delay seems to fix it but it shouldn't be
needed per the wm9712 datasheet. The only way to know 100% for sure
what is going on is to put a scope (I don't have one) on the reset
line and the SDATAOUT or SYNC lines. Maybe SDATAOUT or SYNC initially
bounce around and delaying for 1ms waits until after the balancing
stops.  Datasheet says pulse only needs to be 1us.

But if the 1ms delays fixes things I'm all for it.

-- 
Jon Smirl
jonsmirl@gmail.com
