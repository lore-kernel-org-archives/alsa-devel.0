From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 01:10:47 +0100
Message-ID: <20100217001047.GB6766@tango.0pointer.de>
References: <4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 0765810382B
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 01:11:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B7B2E9F.3080809@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 17.02.10 12:47, Eliot Blennerhassett (linux@audioscience.com) wrote:

> For our cards this is adjustable, but lets say for consumer cards it is
> fixed.  This information is not currently available via the ALSA
> API.

I wonder how realistic it would even be to add an API for
this. i.e. can we even know the refernce level? On many cards most
likely not. For example, for my integrated USB speakers speaking of a
reference voltage would already be misleading...

> A hypothetical example.
> [DAC>---[Variable gain>---[amplifier>---[output jack]
> 
> Lets say
> the DAC produces 2Vpp (6dBVpp) for fullscale digital input (0dBFS)
> and the amplifier has 6dB gain.
> and the variable gain is from -40dB to 0dB
> and the units of the reference level are dBVpp
> 
> Combining these we represent the DAC + gain + amplifier as a single
> Level control with units of dBVpp and range -28dBVpp to +12dBVpp
> 
> or equally valid, could represent it as
> a Volume with range -40dB to 0dB followed by a
> a fixed level of +12dBVpp
> 
> or equally valid, could represent it as
> a Volume with range 0dB to +40dB followed by a
> a fixed level of -28dBVpp
> 
> i.e. the 0dB position is arbitrary, related to what is chosen as the
> output reference level.

Yepp, that's the exactly what I was asking, Jaroslav's measurements
suggested to shift one of the mixer controls from 0..x dB to -x..0 dB
and I was just wondering why, since we don't define the ref level in
ALSA, hence the shift is kinda arbitrary...

Anyway, I am not pushing for adding an API for reference levels to
ALSA. As mentioned for the PA case I decided to shift 0dB to max
amplification in any case, which I think is a workable way to avoid
this problem.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
