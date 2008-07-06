From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC: codec_reg_show and variable length registers
Date: Sat, 5 Jul 2008 20:43:30 -0400
Message-ID: <9e4733910807051743w62f37b54nd18bb21a3475f5bf@mail.gmail.com>
References: <9e4733910807050637p6583ae25m592aca4c5728a4d3@mail.gmail.com>
	<20080705230331.GA10301@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id EE410243B5
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Jul 2008 02:43:37 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so769413ywk.2
	for <alsa-devel@alsa-project.org>; Sat, 05 Jul 2008 17:43:31 -0700 (PDT)
In-Reply-To: <20080705230331.GA10301@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/5/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 05, 2008 at 09:37:45AM -0400, Jon Smirl wrote:
>
>  > Should the register cache really be part of the core? The core could
>  > still make the sysfs entries and use a callback to print them.
>  > reg_cache_size/reg_cache_step would then become private.
>
>
> It's still useful to share as much of the code as possible to ensure
>  consistency between devices.  Most devices are able to use the generic
>  register cache formatting (which is all that uses the size and step)
>  as is and as a general rule it makes maintinence easier when code is
>  factored out of individual drivers.

I'll post my code when I get it working. The chip is a TI TAS5504 or TAS5508.

>  > It's the sprintf that is the problem. I need to push that into my
>  > driver so that I can print out variable lengths. Or we need to make
>  > the core use an indirect table that encodes the lengths.
>
>
> I'd suggest adding an optional callback that drivers can use to replace
>  the register value display (just the value) so that existing drivers
>  don't need modification to cope with larger register sizes - it's not
>  the common case, after all.
>
>  If there are devices that use these larger registers for operations that
>  are handled by snd_soc_update_bits() and friends that'd require more but
>  I'd be surprised to see such devices.

The big registers are arrays. For example register 0x41 is 32 bytes.
It is an array of eight 32b float gains for that channel's mixer
inputs.

Or register 0x51 - 20 bytes, five 32b floats describing a biquad filter.

Datasheet: http://www.ti.com/lit/gpn/tas5504

>


-- 
Jon Smirl
jonsmirl@gmail.com
