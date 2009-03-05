From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: Use network mode with 2 slots
	for 16-bit stereo in pxa-ssp/Zylonite
Date: Thu, 5 Mar 2009 17:06:02 +0100
Message-ID: <74d0deb30903050806g475c6fd2u48d91f52eea4a46@mail.gmail.com>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
	<20090304013424.GA5165@buzzloop.caiaq.de>
	<74d0deb30903041245q4ba5b97fm80324e46e40e55ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 061F510381F
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 17:06:03 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so2519350ywa.2
	for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2009 08:06:02 -0800 (PST)
In-Reply-To: <74d0deb30903041245q4ba5b97fm80324e46e40e55ff@mail.gmail.com>
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

On Wed, Mar 4, 2009 at 9:45 PM, pHilipp Zabel <philipp.zabel@gmail.com> wrote:
> On Wed, Mar 4, 2009 at 2:34 AM, Daniel Mack <daniel@caiaq.de> wrote:
>> Hi Phillip,
>>
>> glad to see someone is wasting time with that issue, too :)
>>
>> On Tue, Mar 03, 2009 at 04:10:51PM +0100, Philipp Zabel wrote:
>>> For consistency with 24-bit and 32-bit modes, don't send 16-bit stereo
>>> in one 32-bit transfer. Use 2 slots instead on Zylonite. It should result
>>> in exactly the same behaviour.
>>> Now it is possible to use 16-bit single slot transfers in pxa-ssp, which
>>> are needed for Magician to get two frame clock pulses per sample
>>> (one for each channel).
>>
>> We've been fiddling around with these modes and registers for
>> another two days in a row now and figured out that literally all the
>> documentation about these registers is entirly bogus. In particular,
>> the network mode with the associated timeslots simply does not work at
>> all, according to our measurements.
>>
>> Hence the question: how does your I2S signal look like at the moment?
>> How many clocks do you measure in one frame cylce, how many of them are
>> actually filled with data? And which format does the userspace use to
>> send samples in?
>
> Unfortunately, I can't measure anything. I don't own an oscilloscope
> and I don't even know if there are useful test points on the phone's
> mainboard.
> Also, I've come to the conclusion that on Magician there has to be
> some kind of flip-flop between the PXA272's SSPFRMCLK and the codec's
> LRCLK input.
[...]

Unfortunately, this means that if I play sound for an odd number of
frame clocks, the next playback will have left and right channels
switched.
I checked this by measuring the number of frames sent with OSCR8.
Is there a way to force pxa-ssp to only ever stop playback after an
even number of frames?

regards
Philipp
