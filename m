From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Feasibility of adding alternative audio transport
 besides I2S/PWM/SPDIF, etc
Date: Tue, 13 Oct 2015 10:57:45 +0100
Message-ID: <1444730265.7124.24.camel@loki>
References: <CAG5mAdwOugskZrHHzeQ-GSu6mAZoN3nybOvupB09FBk2oTwJnw@mail.gmail.com>
 <1444383296.2479.8.camel@loki>
 <CAG5mAdwDFfeJgjsmhYddDvYW1oDDB3AOnPjX8DS4wbSHEADiqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E01662617A4
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 11:57:51 +0200 (CEST)
In-Reply-To: <CAG5mAdwDFfeJgjsmhYddDvYW1oDDB3AOnPjX8DS4wbSHEADiqA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

+ Mark

On Fri, 2015-10-09 at 09:11 -0700, Caleb Crome wrote:
> On Fri, Oct 9, 2015 at 2:34 AM, Liam Girdwood
> <liam.r.girdwood@linux.intel.com> wrote:
> > On Thu, 2015-10-08 at 08:51 -0700, Caleb Crome wrote:
> >> Hi All,
> >>    I'm in a constant struggle to bring up many channel audio on each
> >> separate SoC.
> >>
> >> I can easily put a microcontroller in place that will collect and
> >> distrubute all the TDM channels to the codecs, and connect the
> >> hardware via an SPI interface to the SoC.
> >>
> >> So, instead of:
> >>
> >> CODECS <---TDM--->  SoC
> >>
> >> It would be
> >>
> >> CODECS <---TDM---> uC <---SPI---> SoC
> >>
> >> So, my questions are:
> >>
> >> * I suspect the SPI interface could be used more universally than each
> >> individual I2S/TDM interface (like FSL SSI vs. Ti McBSP vs. Ti McASP,
> >> etc).  and the SPI port would provide a very common API regardless of
> >> SoC.   Is that true?
> >
> > Some SPI ports could probably be used for audio, but this depends on the
> > SPI port HW capabilities. e.g. the SSP port on minnowboard can be
> > configured for TDM, I2S and SPI (afaik). I don't think any advantage
> > could be gained from running in SPI mode unless your HW permits some
> > special features ?
> 
> Sorry, I wasn't clear.  The point is to use the 'generic' SPI API in
> the linux kernel to stream the data, and *not* use an audio format.
> So, the idea is, the external micro would buffer up a block of data,
> (in our case, maybe 160 samples * 32 channels  = 10 kBytes), then use
> the SPI port to read and write to the micro as if it were a memory or
> something like that to transfer the data.  So the external micro would
> appear to the CPU as an external register bank, and would do all the
> audio aggregation.
> 

Ok, so this sounds like a burst based DAI where the host sends audio
data in bursts then sleeps. I think this has been done by some codec
vendors, but I dont know if any code is upstream.

> I was hoping that would provide a pretty much universal means of
> getting many channels of data into and out of pretty much any SoC that
> has an SPI port capable of the requisite speed.
> 
> Does that make sense?

Yes, just need to make sure that your SPI port has low latency and
enough bandwidth and I think you should be OK.

Liam

> 
> I guess there would be an interrupt line from the micro->SoC that
> says, "data ready".   When that's triggered, the SPI bus just goes and
> reads 160 samples x 32 channels x 2 bytes, and writes as many as
> needed to satisfy the given application.
> 
> 
> >
> >>
> >> * Is it feasible to integrate an SPI transport into the SoC/alsa
> >> layer?  What are the difficulties involved with that?
> >>
> >
> > Yes, that's doable providing the SPI port is capable of supporting audio
> > formats and has good DMA connectivity. A DAI driver would need to be
> > written for your SPI port to allow it to send audio data within ASoC.
> 
> Right.  That's the bit I'm pretty clueless on.
> 
> >
> > Liam
> >>
> >> Cheers,
> >>   -Caleb
> >
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
