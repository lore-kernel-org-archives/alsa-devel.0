From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: SoC codec read callback definition
Date: Thu, 23 Jul 2009 16:46:04 +0100
Message-ID: <20090723154603.GA30390@sirena.org.uk>
References: <67059DBF19D7214F9C66BB0EA91BA90E59BA9D93@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C030E2453E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 17:46:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E59BA9D93@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 02:50:53AM -0500, Lopez Cruz, Misael wrote:

> However, actual implementation of that callback in many CODEC drivers
> may return a negative error value (i.e. when a register is out of cache
> reg size). Should the callback definition be changed to return _int_
> instead of _unsigned int_? Some drivers (like wm8900, wm9081) handle
> invalid registers with BUG_ON, in that case it's not necessary to
> return the negative error code.

There's two classes of error.  Reads from the hardware might possibly
fail at runtime, while reads from cache should never fail - an attempt
to read from an uncached register is a clear bug in the driver.  When
the code was originally written there were essentially no devices with
readback so the cache was the only option.

> What should be the best way to handle this? Or is it ok as currently
> implemented? Well, it was just a thought.

Ideally we'd have error codes but that would loose us a bit of data and
IIRC there's at least one codec in there with 32 bit registers which
would need to be handled.
