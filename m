From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Tue, 14 Jan 2014 11:04:22 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7CCF27@SW-EX-MBX01.diasemi.com>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
 <20140109202446.GQ12858@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
 <20140113211858.GK29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A8D72616E1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 12:04:24 +0100 (CET)
In-Reply-To: <20140113211858.GK29039@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 13 Jan 2014 21:19:06 +0000, Mark Brown wrote:

> We also get people complaining about other stylistic things that they
> get asked to fix and people going round fixing style issues - the whole
> reason this broke is that people noticed and fixed the fact that the
> drivers looked wrong to inspection without realising that there were
> multiple drivers for the device because it's not done in the manner we
> usually do this (that's definitely why the CODEC driver was changed, I
> picked up on it during review on submission).  It's really useful to
> have things follow common patterns, it makes maintianing the system
> easier and it makes factoring out shareable code easier.  Things like
> interfaces to the rest of the system tend to get particular focus.
> 
> Please, this isn't helping...

I don't disagree with you on common patterns, and I have been an advocate of
following these when working in the kernel as it generally makes things simpler
and easier. Here I'm not trying to be awkward but am trying to get a simple,
flexible, solution which fits best with our devices, whilst still using common
kernel frameworks.
 
> > Well, the truth is that there are default I2C addresses for both PMIC and Codec
> > but as they are standalone devices, albeit in one package, both addresses can
> > be changed. This is one more reason why I don't believe we should be taking your
> > method of implementation here. If you just make sure PMIC and Codec drivers
> 
> ...but on the other hand this sounds like an actual technical issue
> which could be a good reason to do something different - it's a bit
> surprising that it didn't come up before.  What exactly is the
> flexibility the devices have here?  It's a pretty unusual hardware
> design.

The PMIC is configurable via a register in its register map, and the Codec is
configurable via an OTP register, which a customer is able to set themselves
through a series of register writes, in the Codec register map. When you
mentioned the i2c_add_dummy() approach again in your last mail it caused me to
go over your patch once more, and in doing so I then spotted this. I do wish I
had picked this out earlier though as it may have saved some time in e-mail
discussions.
