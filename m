From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC: codec_reg_show and variable length registers
Date: Sun, 6 Jul 2008 00:03:31 +0100
Message-ID: <20080705230331.GA10301@sirena.org.uk>
References: <9e4733910807050637p6583ae25m592aca4c5728a4d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C6E624387
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Jul 2008 01:03:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807050637p6583ae25m592aca4c5728a4d3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 05, 2008 at 09:37:45AM -0400, Jon Smirl wrote:

> Should the register cache really be part of the core? The core could
> still make the sysfs entries and use a callback to print them.
> reg_cache_size/reg_cache_step would then become private.

It's still useful to share as much of the code as possible to ensure
consistency between devices.  Most devices are able to use the generic
register cache formatting (which is all that uses the size and step)
as is and as a general rule it makes maintinence easier when code is
factored out of individual drivers.

> It's the sprintf that is the problem. I need to push that into my
> driver so that I can print out variable lengths. Or we need to make
> the core use an indirect table that encodes the lengths.

I'd suggest adding an optional callback that drivers can use to replace
the register value display (just the value) so that existing drivers
don't need modification to cope with larger register sizes - it's not
the common case, after all.

If there are devices that use these larger registers for operations that
are handled by snd_soc_update_bits() and friends that'd require more but
I'd be surprised to see such devices.
