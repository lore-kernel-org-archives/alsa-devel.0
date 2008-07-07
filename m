From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC: codec_reg_show and variable length registers
Date: Mon, 7 Jul 2008 12:44:18 +0100
Message-ID: <20080707114417.GC19240@rakim.wolfsonmicro.main>
References: <9e4733910807050637p6583ae25m592aca4c5728a4d3@mail.gmail.com>
	<20080705230331.GA10301@sirena.org.uk>
	<9e4733910807051743w62f37b54nd18bb21a3475f5bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28A1A24573
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 13:44:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807051743w62f37b54nd18bb21a3475f5bf@mail.gmail.com>
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

On Sat, Jul 05, 2008 at 08:43:30PM -0400, Jon Smirl wrote:

> The big registers are arrays. For example register 0x41 is 32 bytes.
> It is an array of eight 32b float gains for that channel's mixer
> inputs.

> Or register 0x51 - 20 bytes, five 32b floats describing a biquad filter.

> Datasheet: http://www.ti.com/lit/gpn/tas5504

Yeah, I checked that it's not a problem for this codec before replying.
I'd imagine that other usages of this sort of large register would be
for similar things and therefore OK with the current implementation.
