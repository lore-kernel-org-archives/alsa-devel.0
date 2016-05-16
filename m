From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ADAU1761 default register value problem
Date: Mon, 16 May 2016 19:02:27 +0200
Message-ID: <5739FD23.4060506@metafoo.de>
References: <alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com>
 <571F2513.1020005@metafoo.de>
 <alpine.DEB.2.02.1605111440510.31333@lnxricardw1.se.axis.com>
 <57358E51.7020000@metafoo.de>
 <alpine.DEB.2.02.1605161150530.31333@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A9FDA2658F5
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 19:02:33 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1605161150530.31333@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05/16/2016 01:07 PM, Ricard Wanderlof wrote:
> 
> On Fri, 13 May 2016, Lars-Peter Clausen wrote:
> 
>>> Having researched this further, it appears that commit
>>>
>>> 27d6e7d1c96c9f51379e0feb972fec26029098bc
>>>
>>> ASoC: adau17x1: Cache writes when core clock is disabled
>>
>> I think it is also related to commit 1c79771a7270 ("regmap: Use
>> regcache_mark_dirty() to indicate power loss or reset"). This changes the
>> regmap code to sync all registers under certain conditions.
> 
> Yes, that commit seems to be the key, although I must admit that I can't 
> get my head around the logic of that commit. The commit message says: "HW 
> was not reset (maybe it was just clock-gated), so if we cached any writes, 
> they should be sent to the hardware regardless of whether they match the 
> HW default.". But if the device was indeed gated off, rather than reset, 
> why should this make a difference when writing out the cache after gating 
> the chip on again? If it were gated off and then on, doesn't this imply 
> that the register settings won't change? Or is the idea that the chip 
> might loose all its state while gated off and hence essentially needs to 
> be reinitialized?

The register settings in the device will stay constant, but the cached
register settings might have changed. E.g. application changes the volume of
a control while the device is powered down. Since regmap does not (yet)
track which registers have changed it has to write out all of them.

> 
> Regardless of the commit message, the code indeed does cause all the 
> cached data to be written out when regcache_sync() is called in this case.
> 
>> We still have the issue though that the CODEC is in an undefined state until
>> the first OFF to STANDBY transitions happens. Usually this will happen early
>> on when the CODEC is bound to the sound card, but if it is not bound
>> immediately it might stay there for a bit longer. So depending on the setup
>> this may or may not be a problem.
> 
> So that means that in the probe function we should really write out the 
> default values, by enabling SYSCLK_EN in the ADAU clock control register, 
> and then calling regcache_sync() before disabling SYSCLK_EN again, and 
> going to regcache_cache_only(..,true) ?

Sounds reasonable.
