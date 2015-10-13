From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Feasibility of adding alternative audio transport
 besides I2S/PWM/SPDIF, etc
Date: Tue, 13 Oct 2015 12:43:04 +0200
Message-ID: <561CE038.10809@metafoo.de>
References: <CAG5mAdwOugskZrHHzeQ-GSu6mAZoN3nybOvupB09FBk2oTwJnw@mail.gmail.com>
 <1444383296.2479.8.camel@loki>
 <CAG5mAdwDFfeJgjsmhYddDvYW1oDDB3AOnPjX8DS4wbSHEADiqA@mail.gmail.com>
 <1444730265.7124.24.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-100.synserver.de (smtp-out-005.synserver.de
 [212.40.185.5]) by alsa0.perex.cz (Postfix) with ESMTP id 3B8122606D4
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 12:43:08 +0200 (CEST)
In-Reply-To: <1444730265.7124.24.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Caleb Crome <caleb@crome.org>
Cc: "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

On 10/13/2015 11:57 AM, Liam Girdwood wrote:
> + Mark
> 
> On Fri, 2015-10-09 at 09:11 -0700, Caleb Crome wrote:
>> On Fri, Oct 9, 2015 at 2:34 AM, Liam Girdwood
>> <liam.r.girdwood@linux.intel.com> wrote:
>>> On Thu, 2015-10-08 at 08:51 -0700, Caleb Crome wrote:
>>>> Hi All,
>>>>    I'm in a constant struggle to bring up many channel audio on each
>>>> separate SoC.
>>>>
>>>> I can easily put a microcontroller in place that will collect and
>>>> distrubute all the TDM channels to the codecs, and connect the
>>>> hardware via an SPI interface to the SoC.
>>>>
>>>> So, instead of:
>>>>
>>>> CODECS <---TDM--->  SoC
>>>>
>>>> It would be
>>>>
>>>> CODECS <---TDM---> uC <---SPI---> SoC
>>>>
>>>> So, my questions are:
>>>>
>>>> * I suspect the SPI interface could be used more universally than each
>>>> individual I2S/TDM interface (like FSL SSI vs. Ti McBSP vs. Ti McASP,
>>>> etc).  and the SPI port would provide a very common API regardless of
>>>> SoC.   Is that true?
>>>
>>> Some SPI ports could probably be used for audio, but this depends on the
>>> SPI port HW capabilities. e.g. the SSP port on minnowboard can be
>>> configured for TDM, I2S and SPI (afaik). I don't think any advantage
>>> could be gained from running in SPI mode unless your HW permits some
>>> special features ?
>>
>> Sorry, I wasn't clear.  The point is to use the 'generic' SPI API in
>> the linux kernel to stream the data, and *not* use an audio format.
>> So, the idea is, the external micro would buffer up a block of data,
>> (in our case, maybe 160 samples * 32 channels  = 10 kBytes), then use
>> the SPI port to read and write to the micro as if it were a memory or
>> something like that to transfer the data.  So the external micro would
>> appear to the CPU as an external register bank, and would do all the
>> audio aggregation.
>>
> 
> Ok, so this sounds like a burst based DAI where the host sends audio
> data in bursts then sleeps. I think this has been done by some codec
> vendors, but I dont know if any code is upstream.

The upstream tlv320dac33 driver does something like this, but it is not
necessarily an implementation I'd recommend to mimic. The whole burst access
mode probably wants some support at the framework level.
