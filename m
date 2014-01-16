From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Thu, 16 Jan 2014 02:11:03 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7CD24A@SW-EX-MBX01.diasemi.com>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
 <20140109202446.GQ12858@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
 <20140113211858.GK29039@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCF27@SW-EX-MBX01.diasemi.com>
 <20140114195159.GW15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 268C82619E7
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 03:11:08 +0100 (CET)
In-Reply-To: <20140114195159.GW15567@sirena.org.uk>
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

On Tue, 14 Jan 2014 19:52:19 +0000, Mark Brown wrote:

> > I don't disagree with you on common patterns, and I have been an advocate of
> > following these when working in the kernel as it generally makes things simpler
> > and easier. Here I'm not trying to be awkward but am trying to get a simple,
> > flexible, solution which fits best with our devices, whilst still using common
> > kernel frameworks.
> 
> That's not what's been coming over.

The drivers follow common patterns. The only thing slightly different is that
both the Codec and PMIC are initialised separately, but this reflects the
nature of the chip. I don't believe wanting to add a simple solution which
fits with that as being awkward or against common methods and am not overly
happy you're trying to suggest otherwise, especially when previous kernel
submissions I've been involved with have very much followed common kernel
practices. I just want the correct solution for our drivers here.

> Are you sure that it's not the other way around?  It's much more common
> to have OTP for PMICs...  In any case, for the device configured via the
> register map is there any real scenario where someone might use that
> feature - devices do have this facility but it's generally never used
> since by the time you can do register writes to configure the address
> register I/O is already up and running so it's just making work.

Yes I'm sure, and there are OTP settings for the PMIC as well. For the PMIC
address configurability, there isn't really an issue anyway as you need to
provide the address for this I2C device at board initialisation in the kernel.
The point of note here is that the Codec I2C address is OTP configurable and
therefore not fixed.
