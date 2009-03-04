From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: Use network mode with 2 slots
	for 16-bit stereo in pxa-ssp/Zylonite
Date: Wed, 4 Mar 2009 21:45:33 +0100
Message-ID: <74d0deb30903041245q4ba5b97fm80324e46e40e55ff@mail.gmail.com>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
	<20090304013424.GA5165@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 47BFA1038AC
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:45:34 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so2307833yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 04 Mar 2009 12:45:33 -0800 (PST)
In-Reply-To: <20090304013424.GA5165@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 4, 2009 at 2:34 AM, Daniel Mack <daniel@caiaq.de> wrote:
> Hi Phillip,
>
> glad to see someone is wasting time with that issue, too :)
>
> On Tue, Mar 03, 2009 at 04:10:51PM +0100, Philipp Zabel wrote:
>> For consistency with 24-bit and 32-bit modes, don't send 16-bit stereo
>> in one 32-bit transfer. Use 2 slots instead on Zylonite. It should result
>> in exactly the same behaviour.
>> Now it is possible to use 16-bit single slot transfers in pxa-ssp, which
>> are needed for Magician to get two frame clock pulses per sample
>> (one for each channel).
>
> We've been fiddling around with these modes and registers for
> another two days in a row now and figured out that literally all the
> documentation about these registers is entirly bogus. In particular,
> the network mode with the associated timeslots simply does not work at
> all, according to our measurements.
>
> Hence the question: how does your I2S signal look like at the moment?
> How many clocks do you measure in one frame cylce, how many of them are
> actually filled with data? And which format does the userspace use to
> send samples in?

Unfortunately, I can't measure anything. I don't own an oscilloscope
and I don't even know if there are useful test points on the phone's
mainboard.
Also, I've come to the conclusion that on Magician there has to be
some kind of flip-flop between the PXA272's SSPFRMCLK and the codec's
LRCLK input. I'm not using I2S mode at all, but TISSP (or PSP with
DAIFMT_DSP_A) and two full frames per sample.
I can more or less handle S16_LE and S32_LE from userspace now.
Using S24_LE doesn't work because the codec supports LSB aligned
signals only up to 20-bit.
S24_3LE I didn't try yet, but the PXA DMA can't advance the source
pointer by 3 bytes per transfer, so that would be ugly anyway (and
only possible if network mode works).

> We finally got a mode now that outputs 2x16 bit on a 2x32 bits I2S
> frame, padded with zeros. But that is in non-network modes, more
> about that tomorrow ...

Strange, interesting ...

regards
Philipp
