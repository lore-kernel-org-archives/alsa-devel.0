From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: reworking ASOC for large registers
Date: Tue, 22 Jul 2008 20:45:47 +0100
Message-ID: <20080722194547.GB7300@sirena.org.uk>
References: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
	<9e4733910807211625l3268a1a9m59d6914fb55593c6@mail.gmail.com>
	<20080722190933.GA20555@opensource.wolfsonmicro.com>
	<9e4733910807221230x9eadd58s4dc8ec18c1200914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DCEEC103899
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 21:45:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807221230x9eadd58s4dc8ec18c1200914@mail.gmail.com>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 03:30:12PM -0400, Jon Smirl wrote:

> My new plan is to make it work on 32bit registers like it does
> currently, instead of 16b. I only need to use bitfield masks in the
> first 32bits.

Yes, that's needed anyway.  You might want to coordinate with Daniel
Ribeiro (CCed) who recently expressed an interest in the same thing.

> Then to access the wide registers I would encode it into the register
> names. So if the big mixer register is at 0x40 and it is 32 bytes wide
> the defines would look like this.

> #define MIXER_CHANNEL_0 0x0040

That sounds like a good solution to the problem of extremely large
registers.  Some other devices implement virtual registers, mostly to
allow them to map the functionality of the chip into DAPM rather than
for uses like this, though.

> What I'm missing is a fast way to bulk load a bunch of registers. If
> you change equalization settings from jazz to classical I need to
> update 50 registers in bulk.

A transaction interface in the ALSA API might be handy for stuff like
this - something that lets you indicate the start and end of a sequence
of control changes.  It would be helpful for DAPM pop/click suppression
during scenario changes too.
