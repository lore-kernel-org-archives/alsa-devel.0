From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Feasibility of adding alternative audio transport
 besides I2S/PWM/SPDIF, etc
Date: Fri, 09 Oct 2015 10:34:56 +0100
Message-ID: <1444383296.2479.8.camel@loki>
References: <CAG5mAdwOugskZrHHzeQ-GSu6mAZoN3nybOvupB09FBk2oTwJnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 69952261A40
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 11:35:03 +0200 (CEST)
In-Reply-To: <CAG5mAdwOugskZrHHzeQ-GSu6mAZoN3nybOvupB09FBk2oTwJnw@mail.gmail.com>
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
Cc: "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-10-08 at 08:51 -0700, Caleb Crome wrote:
> Hi All,
>    I'm in a constant struggle to bring up many channel audio on each
> separate SoC.
> 
> I can easily put a microcontroller in place that will collect and
> distrubute all the TDM channels to the codecs, and connect the
> hardware via an SPI interface to the SoC.
> 
> So, instead of:
> 
> CODECS <---TDM--->  SoC
> 
> It would be
> 
> CODECS <---TDM---> uC <---SPI---> SoC
> 
> So, my questions are:
> 
> * I suspect the SPI interface could be used more universally than each
> individual I2S/TDM interface (like FSL SSI vs. Ti McBSP vs. Ti McASP,
> etc).  and the SPI port would provide a very common API regardless of
> SoC.   Is that true?

Some SPI ports could probably be used for audio, but this depends on the
SPI port HW capabilities. e.g. the SSP port on minnowboard can be
configured for TDM, I2S and SPI (afaik). I don't think any advantage
could be gained from running in SPI mode unless your HW permits some
special features ?

> 
> * Is it feasible to integrate an SPI transport into the SoC/alsa
> layer?  What are the difficulties involved with that?
> 

Yes, that's doable providing the SPI port is capable of supporting audio
formats and has good DMA connectivity. A DAI driver would need to be
written for your SPI port to allow it to send audio data within ASoC.

Liam
> 
> Cheers,
>   -Caleb
