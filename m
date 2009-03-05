From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 2/4] soc-dai: add bitfields for hardware
	I2S formats
Date: Thu, 5 Mar 2009 16:58:33 +0100
Message-ID: <74d0deb30903050758y7bc18e7eg22a38c13d1424ee6@mail.gmail.com>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<20090304223057.GD10731@sirena.org.uk>
	<20090304231223.GB20915@buzzloop.caiaq.de>
	<20090305105357.GB2416@sirena.org.uk>
	<20090305113141.GC28878@buzzloop.caiaq.de>
	<20090305120335.GF2416@sirena.org.uk>
	<20090305125521.GB29699@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id B58031037F1
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 16:58:34 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so2517015ywa.2
	for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2009 07:58:33 -0800 (PST)
In-Reply-To: <20090305125521.GB29699@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 5, 2009 at 1:55 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Thu, Mar 05, 2009 at 12:03:35PM +0000, Mark Brown wrote:
>> > > The other option would be to use the TDM mode interface to set this up
>> > > since that's roughly what it is; my main concern here is that we already
>> > > have two ways of doing this and I'd like to try to keep the number down
>> > > for consistency.
>>
>> > Probably a matter of taste, but IMO TDM mode is not the place either.
>> > Userspace could decide sending out 24bit samples out of a sudden (which
>> > the CPU DAI might accept) and in this case, you'd need some special
>> > logic in the board file again to set up deviders, time slots etc, right?
>>
>> That's why the clocking interface is generally used here - it's more
>> orthogonal.
>
> Hmm, how would you express 24 sample bits with 32 clocks per channel? I
> might not have gotten your point yet - could you provide an example?

I'm still a bit confused by the alsa formats and how they interact
with the SSP formats.

Do I understand correctly that S24_3LE (24-bit packed in 3 bytes)
can't be supported due to limitations in (at least PXA27x's) DMA
engine?
So the remaining 24-bit formats are S24_LE and S32_LE anyway, both of
which are 24-bit packed in 32 bits (either LSB or MSB aligned).

regards
Philipp
