From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] ASoC: add xtensa xtfpga I2S interface and
	platform
Date: Wed, 29 Oct 2014 17:19:05 +0300
Message-ID: <CAMo8Bf+NT6HrtXzgx=9TBJwLYFJK1VE-fuBBuoUmmzchhOON2Q@mail.gmail.com>
References: <1414436825-19416-1-git-send-email-jcmvbkbc@gmail.com>
 <20141027193229.GE18557@sirena.org.uk>
 <CAMo8Bf+Z9V8mkiC3JOupPQmi1EJUDKrb1qcNncDbsEbhjigbww@mail.gmail.com>
 <20141028154224.GX18557@sirena.org.uk>
 <CAMo8BfLpJ0bdmaFt9+gLQ_kEjB68XdjAJUw8f8s=Owv46h_yDQ@mail.gmail.com>
 <20141028173853.GD18557@sirena.org.uk>
 <CAMo8BfL+vW7BjC1bQPNjhuBMTcRTkf8_DDS3NO2HmBUnfHYAFQ@mail.gmail.com>
 <20141028213426.GE18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id F1458260556
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 15:19:06 +0100 (CET)
Received: by mail-oi0-f43.google.com with SMTP id e131so2357385oig.30
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 07:19:05 -0700 (PDT)
In-Reply-To: <20141028213426.GE18557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Takashi Iwai <tiwai@suse.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 29, 2014 at 12:34 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 28, 2014 at 09:11:34PM +0300, Max Filippov wrote:
>> On Tue, Oct 28, 2014 at 8:38 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > You *really* need to explain how it's supposed to work - right now it's
>> > not at all obvious, like I say the fact that this is a rarely used idiom
>> > is not helping.  For example when we tear down the stream we just assign
>> > the pointer in _stop() but don't bother with a sync until the stream is
>> > closed - why?
>
>> Because we can't wait in stop and syncing is not time critical, we can
>> do it any time before the stream becomes invalid.
>
> To be clear: the important part is that someone reading the code can
> understand what's going on.

Ok, I'll change it.

>> >> hw_params callback can change MCLK rate, so it has to disable and
>> >> enable the clock anyway, and since enable can fail it does not guarantee
>> >> that the clock will be left in the same state. Or should I adjust MCLK rate
>> >> w/o disabling the clock?
>
>> > So yet again: why not just enable the clock only when the device is in
>> > use?  If it's being configured it stands to reason that the device isn't
>> > actively in use...
>
>> Mark, I don't get it, sorry ): My clock synthesizer is I2C controlled, so
>> I can't prepare/unprepare it in the trigger callback. When should I do it?
>
> Runtime PM is the normal way of doing it.

Ok, thanks.

>> >> The level field in the control register is 4 bit wide, so the allowed range of
>> >> level is 0..15. FIFO size is 8192 entries, level = 1 corresponds to
>> >> FIFO size / 2, level = 14 -- to FIFO size of 0. I guess this function
>> >> won't get period_size of 0?
>
>> > So if the IP gets changed and the code gets blown up this could well
>> > explode then...  which doesn't seem entirely unlikely considering this
>> > is a FPGA platform so presumably this is easy to update.  To repeat this
>> > is about clarity and the code looking like it's probably hiding bugs as
>> > much as if the code actually works if you really sit down and study it.
>
>> The calculation does not depend on the actual hardware, but on the
>> constant definitions in the same file. They need to be updated if the
>> hardware changes. I'll try to rewrite it in a cleaner way.
>
> Right, my point is that if someone changes the hardware they'll just
> update the constants and then things will break.

Ok, I've rewritten it in a safer manner.

-- 
Thanks.
-- Max
