From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Wed, 28 Apr 2010 21:43:55 -0600
Message-ID: <w2ofa686aa41004282043y97738d60o94aaed133b645682@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<20100427222913.GE15083@opensource.wolfsonmicro.com>
	<1272427811.24542.59.camel@pasglop>
	<20100428120719.GE31400@opensource.wolfsonmicro.com>
	<1272501411.24542.125.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D09B8103844
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 05:44:17 +0200 (CEST)
Received: by gyd10 with SMTP id 10so7197870gyd.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 20:44:16 -0700 (PDT)
In-Reply-To: <1272501411.24542.125.camel@pasglop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 28, 2010 at 6:36 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2010-04-28 at 13:07 +0100, Mark Brown wrote:
>> > The device-tree helps keep the platform .c file simple and devoid of too
>> > horrible hacks, it allows to easily pass various configuration data to
>> > leaf drivers such as i2c thingies, PHY devices etc... without gross
>> > hooks between these and the platform, but the platform code still has
>> > the upper hand for doing ad-hoc bits and pieces (or overwriting the
>> > device-tree based behaviour) if necessary.
>>
>> Once again, if you can get the device tree guys to buy into this and
>> stick with it that sounds good but my experience has been that this
>> isn't where any of these discussions end up.
>
> Well, as the person who came up with the flattened device-tree format in
> the first place I suppose I qualify as a "device-tree" guy here :-)
>
> At the moment, I'd say Grant (and to some extent Jeremy Kerr) are the
> guys in charge though, but yes, I agree with you, there's a tendency to
> be too over-exited and to want to do "too much" with the DT and that is
> counter productive. It's a good tool but it's not going to solve world
> hunger and in some places an ad-hoc bit of C code is a better option :)
>
> Now, I don't think Grant is totally off the tracks here but I must admit
> I haven't taken the time to ensure I understand perfectly everybody's
> position in that debate. At least I made mine clear, hope this helps :-)

After an IRC conversation with Timur, I think we've pretty much sorted
out the best way to handle the mpc8610 use case that allows the
ssi/dma/codec drivers to remain blissfully ignorant and bind in the
appropriate ASoC machine driver for the board.

g.
