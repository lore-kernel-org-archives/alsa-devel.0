From: Caleb Crome <caleb@crome.org>
Subject: Re: Feasibility of adding alternative audio transport
 besides I2S/PWM/SPDIF, etc
Date: Tue, 13 Oct 2015 08:33:26 -0700
Message-ID: <CAG5mAdzTihx=4xpneEbNoEwqdrRkspgqqu=pjGZwxonaRc37SQ@mail.gmail.com>
References: <CAG5mAdwOugskZrHHzeQ-GSu6mAZoN3nybOvupB09FBk2oTwJnw@mail.gmail.com>
 <1444383296.2479.8.camel@loki>
 <CAG5mAdwDFfeJgjsmhYddDvYW1oDDB3AOnPjX8DS4wbSHEADiqA@mail.gmail.com>
 <1444730265.7124.24.camel@loki> <20151013123245.GF14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 51734264EF3
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 17:33:46 +0200 (CEST)
Received: by lbbk10 with SMTP id k10so25209338lbb.0
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 08:33:45 -0700 (PDT)
In-Reply-To: <20151013123245.GF14956@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lu,
 Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2015 at 5:32 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 13, 2015 at 10:57:45AM +0100, Liam Girdwood wrote:
>> On Fri, 2015-10-09 at 09:11 -0700, Caleb Crome wrote:
>
>> > Sorry, I wasn't clear.  The point is to use the 'generic' SPI API in
>> > the linux kernel to stream the data, and *not* use an audio format.
>> > So, the idea is, the external micro would buffer up a block of data,
>> > (in our case, maybe 160 samples * 32 channels  = 10 kBytes), then use
>> > the SPI port to read and write to the micro as if it were a memory or
>> > something like that to transfer the data.  So the external micro would
>> > appear to the CPU as an external register bank, and would do all the
>> > audio aggregation.
>
>> Ok, so this sounds like a burst based DAI where the host sends audio
>> data in bursts then sleeps. I think this has been done by some codec
>> vendors, but I dont know if any code is upstream.
>
> Well, it's not triggerd from the CODEC side which is a bit different to
> what the CODEC vendors were trying - it sounds more like what some of
> the DSP vendors are doing with bursting data into the DSP over a message
> based interface which maps pretty well onto the existing copy()
> operation.

That sounds right.  Send over a messaging interface, rather than an
audio interface.  Which copy() operation do you mean?

Thanks,
 - Caleb
