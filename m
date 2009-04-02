From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC
	while	changing clock
Date: Thu, 2 Apr 2009 11:34:56 +0100
Message-ID: <20090402103455.GA4527@sirena.org.uk>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk>
	<bd7b27490904020039y4616f611l53a96ef12edcf486@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F57C10383A
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 12:34:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490904020039y4616f611l53a96ef12edcf486@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Daniel Gl??ckner <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 10:39:12AM +0300, Jarkko Nikula wrote:

> > Hrm, does the chip support asymmetric configurations for playback and
> > capture?

> My two cents: It supports different sampling rates for ADC and DAC but
> I don't believe there is practical use or HW doing this. In this setup
> there is separate word clock signal on GPIO1 for ADC.

Hrm, that's fairly common for hardware - even with shared LRCLK many
devices will be able to support asymmetric rates providing there are
enough BCLKs to drive the data.  Presumably the only limit in the codec
itself is going to be that whatever the PLL is set for will be the
maximum.

Being a bit stricter than is required probaly won't hurt; someone can
always relax things later on if required.

> Unfortunately I'm bit off from the actual issue here but I remember some
> TI codec had requirement to keep DAC/ADC off while changing the
> configuration...

Yes, that's the issue that Daniel is fixing here - it's not possible to
change the clocking (or at least the PLL) while a DAC or ADC is active.
